Date: Wed, 05 Jul 2000 09:47:57 -0700
From: Matthew Locke <mlocke@jps.net>
Subject: PCMCIA (some answers)
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <NDBBJCEBJMJJJBIMCFBECEAICEAA.mlocke@jps.net>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, at least one answer.  There have been several people asking about
using an ATA flash card with a RPX-lite.  The kernel has some routines that
connect the 8xx PCMCIA controller to the kernel's IDE driver.  Two changes
were necessary to make that work.  One change is timing related specific to
a SanDisk.  I tested the patch on both a RPX-lite CW and a CLLF BW.  Here
are the steps I took to make this work

apply patch  ftp://ftp.mvista.com/pub/unsupported/embedded-planet/
select _IDE and _IDEDISK config options
make dep
make zImage

Make sure you insert the flash card before you boot linux.  the IDE driver
probes for a disk at boot time.

As for the pcmcia-cs questions...

Magnus provided a patch to pcmcia-cs to run on 8xx and Jo-Ellen provided a
kernel patch to the MV 2.2.13 kernel. Since Mark and Jo-Ellen wrote thier
own pcmcia module (for thier super cool wireless project), they didn't run
into the problems using the ide,ethernet pcmcia modules.  I know that the
above mentioned 8xx pcmcia/ide kernel routines conflict with the pcmcia-cs
ide module.  Some work in the kernel will be necessary to resolve that
conflict.  As for the ethernet problems, I tried several different 3COM
models with strange results.  I haven't looked into that any further.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
