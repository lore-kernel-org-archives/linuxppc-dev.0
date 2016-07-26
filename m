Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6MV6NH9zDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:37:26 +1000 (AEST)
Message-ID: <1469511443.5228.2.camel@russell.cc>
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com
Date: Tue, 26 Jul 2016 15:37:23 +1000
In-Reply-To: <146949753931.3859.11305398485148230358@concordia>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <146949753931.3859.11305398485148230358@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-26 at 11:45 +1000, Michael Ellerman wrote:
> Quoting Russell Currey (2016-07-22 15:23:36)
> > 
> > On EEH events the kernel will print a dump of relevant registers.
> > If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
> > doesn't have EEH support, etc) this information isn't readily available.
> > 
> > Add a new debugfs handler to trigger a PHB register dump, so that this
> > information can be made available on demand.
> 
> This is a bit weird.
> 
> It's a debugfs file, but when you read from it you get nothing (I think,
> you have no read() defined).
> 
> When you write to it, regardless of what you write, the kernel spits
> some stuff out to dmesg and throws away whatever you wrote.
> 
> Ideally pnv_pci_dump_phb_diag_data() would write its output to a buffer,
> which we could then either send to dmesg, or give to debugfs. But that
> might be more work than we want to do for this.
> 
> If we just want a trigger file, then I think it'd be preferable to just
> use a simple attribute, with a set and no show, eg. something like:
> 
> static int foo_set(void *data, u64 val)
> {
>         if (val != 1)
>                 return -EINVAL;
> 
>         ...
> 
>         return 0;
> }
> 
> DEFINE_SIMPLE_ATTRIBUTE(fops_foo, NULL, foo_set, "%llu\n");
> 
> That requires that you write "1" to the file to trigger the reg dump.

I don't think I can use this here.  Triggering the diag dump on the given PHB
(these are in /sys/kernel/debug/powerpc/PCI####), and that PHB is retrieved from
the file handler.  It looks like I have no access to the file struct if using a
simple getter/setter.

> 
> 
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 891fc4a..ada2f3c 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -3036,6 +3068,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
> >                 if (!phb->dbgfs)
> >                         pr_warning("%s: Error on creating debugfs on
> > PHB#%x\n",
> >                                 __func__, hose->global_number);
> > +
> > +               debugfs_create_file("regdump", 0200, phb->dbgfs, hose,
> > +                                   &pnv_pci_debug_ops);
> >         }
> 
> You shouldn't be trying to create the file if the directory create failed. So
> the check for (!phb->dbgfs) should probably print and then continue.

Good catch.

> 
> And a better name would be "dump-regs", because it indicates that the file
> does
> something, rather than is something.

That is indeed better.

> 
> cheers
