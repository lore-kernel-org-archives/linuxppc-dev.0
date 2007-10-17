Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 98D23DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 21:24:59 +1000 (EST)
Message-ID: <4715F0F6.1050905@semihalf.com>
Date: Wed, 17 Oct 2007 13:24:38 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
References: <47075FA7.3030108@semihalf.com> <4708C0DA.2040606@semihalf.com>
	<fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com>
In-Reply-To: <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Both this patch and the CM5200 support patch (#6 in your series) are
> pretty much clones of lite5200.c.  I don't think this is the right
> approach.  Don't duplicate code in this way.  Determine the common
> bits and put them in a common place to be usable by any 5200 board
> port.
> 
> It might even be better just to add a platform that matches on
> compatible='mpc5200-generic' which is usable for mpc5200 boards that
> don't need any custom setup by the kernel at platform setup time.
> (which will probably be most 5200 boards).

Agree, will try more generic approach.


>> +static void __init
>> +tqm5200_setup_cpu(void)
>> +{
>> +       struct mpc52xx_gpio __iomem *gpio;
>> +       u32 port_config;
>> +
>> +       /* Map zones */
>> +       gpio = mpc52xx_find_and_map("mpc5200-gpio");
>> +       if (!gpio) {
>> +               printk(KERN_ERR __FILE__ ": "
>> +                       "Error while mapping GPIO register for port config. "
>> +                       "Expect some abnormal behavior\n");
>> +               goto error;
>> +       }
>> +
>> +       /* Set port config */
>> +       port_config = in_be32(&gpio->port_config);
>> +
>> +       port_config &= ~0x00800000;     /* 48Mhz internal, pin is GPIO  */
>> +
>> +       port_config &= ~0x00007000;     /* USB port : Differential mode */
>> +       port_config |=  0x00001000;     /*            USB 1 only        */
>> +
>> +       port_config &= ~0x03000000;     /* ATA CS is on csb_4/5         */
>> +       port_config |=  0x01000000;
> 
> Are you *sure* you want this?  You should only be touching port_config
> if firmware fails to set it up correctly.  Don't blindly copy what was
> done for the lite5200.
> 
> Lite5200 touches it because firmware does *not* do the right thing at
> the moment.

Yes, that's needed, but will be moved to U-boot.


>> +void tqm5200_show_cpuinfo(struct seq_file *m)
>> +{
>> +       struct device_node* np = of_find_all_nodes(NULL);
>> +       const char *model = NULL;
>> +
>> +       if (np)
>> +               model = of_get_property(np, "model", NULL);
>> +
>> +       seq_printf(m, "vendor\t\t:      Freescale Semiconductor\n");
> 
> Freescale?  Really?

Well, not really...

Something like

        seq_printf(m, "Vendor\t\t: TQ Components\n");
        seq_printf(m, "Machine\t\t: %s\n", model);

and model set to 'tqc,tqm5200' would be more accurate but going for
compatible='mpc5200-generic' platform we may need to drop Vendor line
anyway.

m.
