Message-Id: <l03130300b4ee7a26b302@[192.168.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 11 Mar 2000 16:16:29 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Christian Jaeger <christian.jaeger@rektorat.ethz.ch>
Subject: TCP/PPP stall problem; kernel2.3.48 on BWG3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some weeks ago I started suffering from the TCP over PPP stall/machine
lockup, which several people have reported since october. It's strange that
I've never had this problem before, but now it seems getting worse and
worse (perhaps I should contact the internet provider?). Sometimes there's
no problem at all (several MB transfer with 0 errors), but more often than
not only some packets are received correctly, then there's this loop of
receiving a packet with increasing delays between (the delay is doubled
after each received packet) and (almost?) all received packets increase the
'errors' and 'overruns' counts in ifconfig. Since logging in to the
provider again (and also rebooting linux) then doesn't help, it's probably
tied to the machine(s) at the other end.

I'm using 2.2.15pre11 now. At Jan31 I compiled 2.2.15pre4 from linuxcare
with IPmasquerading and at the same time updated pppd, some days ago I
upgraded to the 2.2.15pre11 I'm using now. Before Jan31 I used 2.2.14pre9
from RShaw.

Switching off VJ compression (novj in ~/.ppprc) has not helped against the
stall. My machine has not _crashed_ the last few tries, but that might be
coincidence.

I have a Blue G3 (rev.2).

What is the best solution for this so far? I've read that the 2.3.x kernel
doesn't have this problem. Is this really true? Is using 2.3.x a good idea?

I have rsynced 2.3.48 from PaulM's tree, and have compiled it seven times
now without any luck getting it booted. The first 6 tries were with
BOOTX_TEXT (early boot) enabled. (I use BootX.) The first 3 tries hanged
just after the "booting..." line, the next 3 tries printed some further
lines and then hanged too.
(In detail:
...
 booting...
 pmac_init(): exit
 id mach(): done
 MMU: enter
 MMU: hash_init
 hash: enter
 hash: find_piece
 hash: patch
 hash: done
 MMU: mapin
 MMU: setbat
 MMU: exit
 setup_arch: enter
 setup_arch: bootmem
 arch: exit
)

I've read the tips on the list from yesterday about 'early booting text'
and have now tried once more with a fresh source tree (still 2.3.48) with
.config from linuxcare and 3 changes: DEVFS_FS off, BOOTX_TEXT off, Altivec
off. Switching the Bootx stuff off has only changed that the MacOS screen
doesn't disappear. Would this be all right? Should I still try yaboot?


BTW: if you switch off General/Powerbook Power Management, the kernel will
not get linked:

drivers/block/block.a(ide-pmac.o): In function `pmac_ide_init_hwif_ports':
ide-pmac.o(.text+0xfc): undefined reference to `check_media_bay_by_base'

...which is defined in ./include/asm/mediabay.h,
./include/asm-ppc/mediabay.h and ./drivers/macintosh/mediabay.c


Christian.

(PS. I only receive the digest form of the list)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
