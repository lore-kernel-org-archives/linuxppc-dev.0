Message-ID: <3E96C07B.4060809@dgt-lab.com.pl>
Date: Fri, 11 Apr 2003 15:17:47 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel/timer.c
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anyone knows why tehere is a line:

expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);

in kernel/timer.c sys_nanosleep
It adds additional time tick to expire. If anyone uses small HZ value
(eg 100 which is default for arch-ppc) this causes aditional 10ms delay
when calling nanosleep.


For me ( found by Andrzej Kass)
 it should be:

expire = timespec_to_jiffies(&t) + !(t.tv_sec || t.tv_nsec);
   //^^add extra tick if there is
  // nothing in tv_sec and nothing in tv_nsec


--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
