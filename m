Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7513D14008B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 22:59:59 +1100 (EST)
Message-ID: <1396267178.11529.80.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL message log interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Mon, 31 Mar 2014 22:59:38 +1100
In-Reply-To: <21604.1396238935@ale.ozlabs.ibm.com>
References: <1395964240-8305-1-git-send-email-joel@jms.id.au>
 <1395964240-8305-2-git-send-email-joel@jms.id.au>
 <21604.1396238935@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: stewart@linux.vnet.ibm.com, michael@ellerman.id.au,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com, paulus@samba.org,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-31 at 15:08 +1100, Michael Neuling wrote:

> > +/* OPAL in-memory console. Defined in OPAL source at core/console.c */
> > +struct memcons {
> > +	__be64 magic;
> > +#define MEMCONS_MAGIC	0x6630696567726173L
> 
> 0x6630696567726173 == f0iegras ... Ben!!! :-P

Yummy ! :-)

> > +	__be64 obuf_phys;
> > +	__be64 ibuf_phys;
> > +	__be32 obuf_size;
> > +	__be32 ibuf_size;
> > +	__be32 out_pos;
> > +#define MEMCONS_OUT_POS_WRAP	0x80000000u
> > +#define MEMCONS_OUT_POS_MASK	0x00ffffffu
> > +	__be32 in_prod;
> > +	__be32 in_cons;
> > +};
> > +
> > +static ssize_t opal_messages_read(struct file *file, struct kobject *kobj,
> > +	struct bin_attribute *bin_attr, char *to, loff_t pos, size_t count)
> > +{
> > +	struct memcons *mc = bin_attr->private;
> > +	const char *conbuf;
> > +	bool wrapped;
> > +	size_t num_read;
> > +	int out_pos;
> > +
> > +	if (!mc)
> > +		return -ENODEV;
> > +
> > +	conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
> > +	wrapped = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_WRAP;
> > +	out_pos = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_MASK;
> > +
> 
> Are there ordering issues we need to think about here with reading
> these?  Can the messages be written on another CPU at the same time as
> these are being read?

Good point. out_pos should probably be read only once into a local
variable using the ACCESS_ONCE macro, and then only be broken up.

> What happens if in between reading wrapped and out_pos the buffer wraps?
> You'd end up getting only a few bytes of console?  Maybe you need to
> read wrapped before and after out_pos to make should it's not wrapped in
> between.

Unlikely but yes, it can happen.

> > +	if (!wrapped) {
> 
> Why the negative case first?  Just make it:
> 
>    if (wrapped) {
>       wrapped case
>    } else {
>       not wrapped case
>    }
> 
> Also, no curlies needed for single statement.
> 
> 
> > +		num_read = memory_read_from_buffer(to, count, &pos, conbuf,
> > +				out_pos);
> 
> This is probably not necessary, but do we need to sanity check out_pos <
> obuf_size?  I guess we don't generally sanity check numbers from OPAL as
> it can screw us in many other ways anyway.

On the other hand it doesn't cost much and if the FW goes bonkers it
will give us a better handle to debug from.

> > +	} else {
> > +		num_read = memory_read_from_buffer(to, count, &pos,
> > +				conbuf + out_pos,
> > +				be32_to_cpu(mc->obuf_size) - out_pos);
> > +
> > +		if (num_read < 0)
> > +			goto out;
> > +
> > +		num_read += memory_read_from_buffer(to + num_read,
> > +				count - num_read, &pos, conbuf,
> >                out_pos);
> 
> What if this second read returns an error?  num_read += -ERRNO?  I think
> you need to check this return independently.

Cheers,
Ben.

> Mikey
> 
> > +	}
> > +out:
> > +	return num_read;
> > +}
> > +
> > +static struct bin_attribute messages_attr = {
> > +	.attr = {.name = "messages", .mode = 0444},
> > +	.read = opal_messages_read
> > +};
> > +
> > +void __init opal_messages_init(void)
> > +{
> > +	u64 mcaddr;
> > +	struct memcons *mc;
> > +
> > +	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr)) {
> > +		pr_warn("OPAL: Property ibm,opal-memcons not found, no message log\n");
> > +		return;
> > +	}
> > +
> > +	mc = phys_to_virt(mcaddr);
> > +	if (!mc) {
> > +		pr_warn("OPAL: memory console address is invalid\n");
> > +		return;
> > +	}
> > +
> > +	if (be64_to_cpu(mc->magic) != MEMCONS_MAGIC) {
> > +		pr_warn("OPAL: memory console version is invalid\n");
> > +		return;
> > +	}
> > +
> > +	messages_attr.private = mc;
> > +
> > +	if (sysfs_create_bin_file(opal_kobj, &messages_attr) != 0)
> > +		pr_warn("OPAL: sysfs file creation failed\n");
> > +}
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index e92f2f6..2bc032a 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -46,7 +46,7 @@ struct mcheck_recoverable_range {
> >  static struct mcheck_recoverable_range *mc_recoverable_range;
> >  static int mc_recoverable_range_len;
> >  
> > -static struct device_node *opal_node;
> > +struct device_node *opal_node;
> >  static DEFINE_SPINLOCK(opal_write_lock);
> >  extern u64 opal_mc_secondary_handler[];
> >  static unsigned int *opal_irqs;
> > @@ -574,6 +574,8 @@ static int __init opal_init(void)
> >  		opal_platform_dump_init();
> >  		/* Setup system parameters interface */
> >  		opal_sys_param_init();
> > +		/* Setup message log interface. */
> > +		opal_messages_init();
> >  	}
> >  
> >  	return 0;
> > -- 
> > 1.9.1
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
