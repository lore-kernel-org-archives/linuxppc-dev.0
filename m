Return-Path: <dan.j.williams@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 63E4ADDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 03:57:59 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so312186nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 09:57:57 -0700 (PDT)
Message-ID: <e9c3a7c20703160957o7f1ecf41gb47d47227575629c@mail.gmail.com>
Date: Fri, 16 Mar 2007 09:57:57 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
In-Reply-To: <1174033758.6861.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<1174033758.6861.41.camel@localhost.localdomain>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/16/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > +     PRINTK("\tfree slot %x: %d stride: %d\n", desc->phys, desc->idx, desc->stride);
>
> Why don't you use the kernel existing debugging facilitie, like
> pr_debug, or dev_dbg if you have a proper struct device (which you
> should have with an arch/powerpc port hopefully using
> of_platform_device).
>
This came from the the iop-adma driver.  I blindly copied it from
drivers/md/raid5.c, but yes it should change to dev_dbg.

> > +     spin_lock_bh(&spe_chan->lock);
> > +     /* Allocate descriptor slots */
> > +     i = spe_chan->slots_allocated;
> > +     if (spe_chan->device->id != PPC440SPE_XOR_ID)
> > +             db_sz = sizeof (dma_cdb_t);
> > +     else
> > +             db_sz = sizeof (xor_cb_t);
> > +
> > +     for (; i < (plat_data->pool_size/db_sz); i++) {
> > +             slot = kzalloc(sizeof(struct spe_adma_desc_slot), GFP_KERNEL);
>
> GFP_KERNEL within spin_lock_bh is no good...
>
This is an iop-adma wart... will fix.

> > diff --git a/include/asm-ppc/adma.h b/include/asm-ppc/adma.h
> > new file mode 100644
> > index 0000000..0be88f1
> > --- /dev/null
> > +++ b/include/asm-ppc/adma.h
>
> There's way too many code in this .h file, too big inline functions. It
> should mostly be moved to a .c file
>
The iop-adma driver uses separate .h files because the driver is
shared between iop3xx and iop13xx implementations and I did not want
the overhead of another indirect-branch layer.  In this case the
hardware specific routines can be written inline since the driver is
only supporting one architecture... other suggestions?

> Cheers,
> Ben.
>

Regards,
Dan
