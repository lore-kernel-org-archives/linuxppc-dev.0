Message-ID: <006501c3eeff$536fe8a0$0400a8c0@portatile>
Reply-To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Fw: MPC8260 bad interrupts
Date: Mon, 9 Feb 2004 12:24:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Jon Diekema  wrote:

> This problem was discussed on mailing list before also and you can
> eliminate this problem by inserting a sync instruction at a certain
> place in the 8260 interrupt handling code. See, for example,

I had the same problem with our custom driver, and the patch eliminated the
problem.
After a double check on our code we found a small bug over a possible race
condition.
After fixed the bug we removed the sync instruction and bad interrupt never
happened again.

My personal suggestion is:

1 - have a look to the mail thread then  you will discover that this problem
     occours only with centain kernel revision;
2 - double check your code to be sure that you do not have any race
condition;
3 - check your hardware init sequence;
4 - finally apply the patch (only in you do not have any better solution).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
