From: Wulf Hofbauer <wh@echo.chem.TU-Berlin.DE>
Subject: IDE/ATAPI driver broken in newer kernels
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 22 Jan 1999 17:22:08 +0100 (MEZ)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <"mail.zrz.T.556:22.01.99.16.29.10"@TU-Berlin.DE>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Kernels since at least 2.1.120 lock up on my PowerMac 4400 when booting
from Open Firmware/quik. The interrupt handler for the ATAPI interface on IRQ
14 doesn't seem to do it's job right. Right after installation of the
IRQ handler, IRQ14 is enabled and taken. The IRQ handler however never
seems to clear the interrupt condition, so the machine will lock up
running the IRQ handler permanently.

The problem seems to go away when booting via BootX. I suspect that the
IRQ-generating condition (media changed?) is cleared by MacOS. I'm not familiar
enough with IDE/ATAPI to solve the problem on my own. I described the
problem some months ago, but noone seems to care to fix it. Isn't anyone
willing to look into this?

As a sidenote, I find that atyfb is broken for most resolutions and bit depths.
Is this a known problem?

Last note: newer kernels quite often won't even compile without correcting
some blatant bugs in the header files. (In 2.1.132, some jerk tries to assign/
increment/decrement a struct in softirq.h.) I know it's a hackers kernel,
but I'd expect correct C syntax from it anyway.
Who is changing the ppc-specific headers without even trying to rebuild the
kernel afterwards? I've got the impression some people are actively trying to
destabilize LinuxPPC...

- Wulf

-- 
 ________________________________________________________
! Dipl. Phys. Wulf Hofbauer  (wh@echo.chem.tu-berlin.de) !
! Max-Volmer-Institut     Technische Universitaet Berlin !
! Strasse des 17. Juni 135     10623 Berlin      Germany !
!________________________________________________________!

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
