Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz1D35VByzDqdt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:45:39 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Russell Currey <ruscur@russell.cc>,  linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20160722052336.3340-1-ruscur@russell.cc>
Cc: gwshan@linux.vnet.ibm.com, "Russell Currey" <ruscur@russell.cc>
References: <20160722052336.3340-1-ruscur@russell.cc>
Message-ID: <146949753931.3859.11305398485148230358@concordia>
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
Date: Tue, 26 Jul 2016 11:45:39 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Russell Currey (2016-07-22 15:23:36)
> On EEH events the kernel will print a dump of relevant registers.
> If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
> doesn't have EEH support, etc) this information isn't readily available.
> =

> Add a new debugfs handler to trigger a PHB register dump, so that this
> information can be made available on demand.

This is a bit weird.

It's a debugfs file, but when you read from it you get nothing (I think,
you have no read() defined).

When you write to it, regardless of what you write, the kernel spits
some stuff out to dmesg and throws away whatever you wrote.

Ideally pnv_pci_dump_phb_diag_data() would write its output to a buffer,
which we could then either send to dmesg, or give to debugfs. But that
might be more work than we want to do for this.

If we just want a trigger file, then I think it'd be preferable to just
use a simple attribute, with a set and no show, eg. something like:

static int foo_set(void *data, u64 val)
{
        if (val !=3D 1)
                return -EINVAL;

        ...

        return 0;
}

DEFINE_SIMPLE_ATTRIBUTE(fops_foo, NULL, foo_set, "%llu\n");

That requires that you write "1" to the file to trigger the reg dump.


> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 891fc4a..ada2f3c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3036,6 +3068,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
>                 if (!phb->dbgfs)
>                         pr_warning("%s: Error on creating debugfs on PHB#=
%x\n",
>                                 __func__, hose->global_number);
> +
> +               debugfs_create_file("regdump", 0200, phb->dbgfs, hose,
> +                                   &pnv_pci_debug_ops);
>         }

You shouldn't be trying to create the file if the directory create failed. =
So
the check for (!phb->dbgfs) should probably print and then continue.

And a better name would be "dump-regs", because it indicates that the file =
does
something, rather than is something.

cheers
