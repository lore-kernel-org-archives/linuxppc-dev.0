From: Wulf Hofbauer <wh@echo.chem.tu-berlin.de>
Subject: Re: IDE problems with 2.3.49?
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 9 Mar 2000 21:32:25 MEZ
Message-Id: <E12T9bd-0004vk-00@mail.zrz.tu-berlin.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been experiencing IDE interrupt problems with anything more
recent than 2.1.24. On my 7220, the IDE controller doesn't seem to
be properly initialized and raises an interrupt when none is expected.
The kernel then gets stuck in an infinite interrupt loop. This occured
however only when booting from OF. When using a MacOS-based loader,
MacOS would have initialized the IDE controller before the kernel was
running.

The workaround for me has been to reset the IDE controller. The kernel
bootflags are something like ide0=reset, ide1=reset. After that, the
unexpected interrupt is discarded, though it still generates a warning.

Maybe the current problems are related to this.

- Wulf

--
 ________________________________________________________
! Dipl. Phys. Wulf Hofbauer  (wh@echo.chem.tu-berlin.de) !
! Max-Volmer-Institut     Technische Universitaet Berlin !
! Strasse des 17. Juni 135     10623 Berlin      Germany !
!________________________________________________________!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
