Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <brian.auld@adic.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel Preemption patch
Date: Sun, 23 Feb 2003 14:33:55 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFGEILECAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0045_01C2DB48.981EF890"
In-reply-to: <995FF289C9D69747A09E42992644595405B23680@penguin.adic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0045_01C2DB48.981EF890
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> Has anyone successfully applied and run the linux kernel
> preemption patch on
> a 2.4.20 kernel. I have the following:
>
> - Latest Denx kernel (2_4_devel) running on 440GP ebony
> - 'preempt-kernel-rml-2.4.20-1.patch' applied to my kernel source
>   (I manually corrected a couple of fails and double checked a few
>    'successfully applied with fuzz' instances when applying the patch).
> - Kernel compiled with 'Kernel preemption =y' in make oldconfig

Yes, but didn't you get any compile errors? There are some missing brackets,
etc. to fix. Check the attached message from this list.

------=_NextPart_000_0045_01C2DB48.981EF890
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment

From: "Eugene Surovegin" <ebs@innocent.com>
Sender: <owner-linuxppc-dev@lists.linuxppc.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <3DF84AD5.9090500@intracom.gr><5.1.0.14.2.20021212102609.02d48730@pop.prodigy.net>
Subject: Re: Is the preemptive kernel patch unsafe for 8xx/PPC?
Date: Thu, 12 Dec 2002 22:09:48 -0800
Message-ID: <5.1.0.14.2.20021212214102.02bf1338@mail.attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: QUALCOMM Windows Eudora Version 5.1
X-Spam-Status: No, hits=-8.5 required=5.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Importance: Normal
In-reply-to: <001901c2a21d$f3f4e760$0200a8c0@jockeXP>
X-Sender: eugenesurovegin@mail.attbi.com
X-Message-Flag: Follow up
X-ICQ-UIN: 1193073


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

3) to support 440GP you have to modify
arc/ppc/kernel/irc.c:preempt_intercept:

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




------=_NextPart_000_0045_01C2DB48.981EF890--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
