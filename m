MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: VME driver patch for PowerPC
Date: Wed, 9 Jun 2004 15:01:12 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D007E84017@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >>Could you check, whether the patch to your driver (version
> >>7433-3.2 of your
> >>Linux support) still compiles on an Intel platform, and works
> >>as intended?
> >>
> >Yep. I only did a quick test, but it appears to work fine on x86.
> >I've merged your patch up with the code base for the next release.
> >
> Great!
>
> I don't know about x86 bus organization, but maybe it limits
> the address
> range for available addresses too strongly (on a single bus,
> where the
> Universe is on). Comparing how much window space you can map with the
> old version and the new one on x86 could prove useful.

Your dead on right. I cannot allocate as much space. In fact,
on a VMIVME-7750 I'm only able to allocate 768KB now vs. the
~2MB I could access before.

> Adding the patch below activated correct behaviour for vme_peek/poke,
> with correct data width (tested VME_D8, VME_D16 and VME_D32), and
> without cache bursts.
>
> It simply sets the cache-inhibited and guarded bits before
> remapping the pages (these flags are PowerPC-specific, and the
> pci_mmap_page_range() function is sadly no exported kernel symbol).
>
> Would you again be so kind to run some "still works"-test on an
> Intel board?

That part still works.

Thanks,
Daniel L. Heater
Software Development, Embedded Systems
GE Fanuc Automation Americas, Inc.
VMIC, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
