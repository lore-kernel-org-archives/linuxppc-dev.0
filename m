Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: abstract spu management routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1162962074.20271.16.camel@localhost.localdomain>
References: <455161D2.3090004@am.sony.com>
	<1162962074.20271.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 16:35:03 +1100
Message-Id: <1162964103.28571.708.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +struct platform_data {
> > +	int nid;
> > +	struct device_node *devnode;
> > +	struct spu_priv1 __iomem *priv1;
> > +};
> > +
> > +static struct platform_data *platform_data(struct spu *spu)
> > +{
> > +	BUG_ON(!spu->platform_data);
> > +	return (struct platform_data*)spu->platform_data;
> > +}
> 
> I don't see the point of this, why not just grab platform data directly?

Because it's a void * in the struct spu. This accessor casts it and BUGS
if it's not set (which is probably unnecessary).

I'd prefer however a different naming:

struct spu_pdata {
	blah
};

static struct spu_pdata *spu_get_pdata(struct spu *spu)

Either that, or you could just do something like that in spu.h :

struct spu_pdata;

struct spu
{
	.../...
	struct spu_pdata *pdata;
	../...
};

And have the various priv1 implementation define their own struct
spu_pdata. A bit sneaky but provides strong typing without needing an
accessor.

Ben.
