Message-Id: <5.1.0.14.2.20021212214102.02bf1338@mail.attbi.com>
Date: Thu, 12 Dec 2002 22:09:48 -0800
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Is the preemptive kernel patch unsafe for 8xx/PPC?
Cc: <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <001901c2a21d$f3f4e760$0200a8c0@jockeXP>
References: <3DF84AD5.9090500@intracom.gr>
 <5.1.0.14.2.20021212102609.02d48730@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim,

At 12:35 PM 12/12/2002, you wrote:
>Was that the 2.4.19-2 patch? What were the bugs and have you fixed them?

I had the following issues with 2.4.19-2 (2.4.20-1 is identical in this
regard):

1) arch/ppc/kernel.entry.S

diff -urN linux-2.4.20/arch/ppc/kernel/entry.S linux/arch/ppc/kernel/entry.S
--- linux-2.4.20/arch/ppc/kernel/entry.S        2002-11-28
18:53:11.000000000 -0500
+++ linux/arch/ppc/kernel/entry.S       2002-12-11 02:34:47.000000000 -0500
@@ -278,6 +278,41 @@
          */
         cmpi    0,r3,0
         beq     restore
+#ifdef CONFIG_PREEMPT
+       lwz     r3,PREEMPT_COUNT(r2)
+       cmpi    0,r3,1
+       bge     ret_from_except
+       lwz     r5,_MSR(r1)
+       andi.   r5,r5,MSR_PR
+       bne     do_signal_ret

     <rest of the diff is skipped>

I had to change the last command to "bne ret_from_except".
I checked MontaVista tree, and they have "ret_from_except" there also.

Without this change trivial code:

   while (true) ;

locked the box completely.

2) include/asm-ppc/pgalloc.h  There are curly brackets missing in
get_pgd_fast()

3) to support 440GP you have to modify arc/ppc/kernel/irc.c:preempt_intercept:

#if !defined(CONFIG_4xx) || defined(CONFIG_440)
         case 0x900:
#else
         case 0x1000:
#endif

With these changes (an maybe some others I forgot to mention here :),
I have pretty stable preemptable kernel (2.4.19, PPC440GP & 405GP, also
with rtsched patch by George Anzinger)

Thanks,


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
