Date: Tue, 01 Apr 2003 16:41:39 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: kernel hangs after printing "Calibrating delay loop ..." on mpc860
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEKEFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi List

Every now and then my kernel gets stuck after printing "Calibrating delay loop ..."
and I have to press the reset button to recover.

Someone else has experienced this on a 8260 board. This board did not have a RTC
and the fix was to add a set_tb(0,0) early in arch/ppc/kernel/time.c/time_init

Our board has a RTC but it gets initialized very late(after the Calibrating
delay loop stuff).

Either one of us can't understand why this would fix the problem and since I can't
repeat the problem at will I can't verify if a set_tb(0,0) will fix anything.

Can anybody explain why(or why not) a set_tb(0,0) will make a difference?
Kernel is linuxppc_dev, 2.4.20

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
