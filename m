To: Dan Malek <dan@netx4.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Real Time response/latency question
References: <19991130034844.1B3E0F380@elph.research.canon.com.au> <3843ED00.20D47DF4@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 01 Dec 1999 16:34:35 +0100
In-Reply-To: Dan Malek's message of "Tue, 30 Nov 1999 10:28:00 -0500"
Message-ID: <kfyk8my1xpw.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Graham Stoney wrote:
> > .... Can anyone give me a rough idea of the maximum latency in user
> >space I could expect on an 860T based system with multiple threads,
> >where only one thread has SCHED_RR realtime scheduling priority?
> 
> 
> You can't answer this question due to the design and implementation of
> the kernel.  Most "real-time" systems can't either once you throw
> protocol stacks, file systems, disk drives, and other external devices
> or distributed services into the feature mix.
> 
> I have successfully written applications that required sub-millisecond
> latency.  You just have to be careful about other applications in the
> system, and remember that you can't preempt the kernel.

Ingo molnars lowlatency patch (http://www.redhat.com/~mingo/lowlatency-2.2.13-A1)
(adapted to PPC ofcourse) in combination with POSIX realtime scheduling
can actually do great things for you. (Not hard realtime ofcourse
but very good "normal-case" latency even under high load)

However, if you use a serial console - don't even think about doing
anything remotely realtime without the following patch. Without it
the 8xx serial driver can busy-wait up to 25ms(!!!) (assuming 9600
bits/s) when it prints a newline.

Index: n_tty.c
===================================================================
RCS file: /swb/cvs_repository/linux/drivers/char/n_tty.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 n_tty.c
--- n_tty.c	1999/07/07 13:57:03	1.1.1.1
+++ n_tty.c	1999/11/30 20:17:16
@@ -144,11 +144,13 @@
 			if (O_ONLCR(tty)) {
 				if (space < 2)
 					return -1;
-				tty->driver.put_char(tty, '\r');
+				tty->driver.write(tty, 0, "\r\n", 2);
 				tty->column = 0;
+			} else {
+				tty->driver.put_char(tty, c);
 			}
 			tty->canon_column = tty->column;
-			break;
+			return 0;
 		case '\r':
 			if (O_ONOCR(tty) && tty->column == 0)
 				return 0;


//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
