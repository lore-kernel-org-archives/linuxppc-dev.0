MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Differing PCI layouts trigger porting driver problem [Was: Memory layout question]
Date: Wed, 19 May 2004 13:33:06 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCC@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-- snip --

> I guess the correct new order would be:
> allocate_resource(&iomem_resource, ... ) to obtain a range of
> physical addresses, ioremap_nocache that physical start address to
> obtain virtual addresses for the ->virt pointer in the master
> window structure (now done in vme_master_window_map() I think),
> and then use virt_to_bus () to obtain the address to store in the
> master window base register. Then the driver should work both on
> (nearly) arbitrary setups for x86 and PPC.

That sounds about right. This type of issue is sprinkled throughout.
I'm on a tight deadline for another project, but I will refer you
to another developer who is currently working on a maintenance release
of that driver. I'll see if we can add porting to PPC to the scope
of the next release.

BTW, I am the original developer, so all bugs can be blamed on me!
If you need help digging through the driver code, just let me know.

> Of course I have to try that out first (I'm still home now),
> and let you know if that produced any results. Did VMIC run into
> similar problems when trying to run the driver module on the
> VMIVME7050 (750FX/GX IBM PowerPC board)?

We have not started that port yet, but I'm sure we will run into
the same issue.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
