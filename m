Message-ID: <393EA909.3350A92B@amberdata.demon.co.uk>
Date: Wed, 07 Jun 2000 20:56:57 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: ide breakage in 2.3.99 series kernels
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

looks to me like something broke IDE about 2.3.99-pre7 for my IBM 850.
Instead of

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: Maxtor 83228D3, ATA DISK drive
hdb: Maxtor 83228D3, ATA DISK drive
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 13
hda: 6306048 sectors (3229 MB) w/256KiB Cache, CHS=3079/64/32
hdb: 6306048 sectors (3229 MB) w/256KiB Cache, CHS=6256/16/63

i get

Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ, ATA DISK drive
hdb: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ, ATA DISK drive
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 13
hda: 6305792 sectors (3229 MB) w/11565KiB Cache, CHS=3079/64/32
hda: INVALID GEOMETRY: 64 PHYSICAL HEADS?

and then it panics.

Anybody else seeing this? It seems to still be broken in 2.4.0test1-ac9
(except there it actually manages to detect ide1 as well, so something
else must have gotten fixed).

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
