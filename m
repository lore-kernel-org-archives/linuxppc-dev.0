Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp08.mail.mci.yahoo.co.jp (ybbsmtp08.mail.mci.yahoo.co.jp
	[210.80.241.157]) by ozlabs.org (Postfix) with SMTP id A595E67A46
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Mar 2005 03:45:30 +1100 (EST)
Message-ID: <42331CA8.3030400@ybb.ne.jp>
Date: Sun, 13 Mar 2005 01:45:28 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, galak@freescale.com,
	mporter@kernel.crashing.org, ebs@ebshome.net
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] compilation failure due to confliction of time_offset
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:

I send carbon copy of the mail to maintainers of Embedded PowerPC,
because I can not figure out who is responsible for arch/ppc/kernel/time.c.

I found a trivial bug made compilation fail.
I show error log as follows:

-- error log
arch/ppc/kernel/time.c:92: error: static declaration of 'time_offset'
follows non-static declaration
include/linux/timex.h:236: error: previous declaration of 'time_offset'
was heremake[1]: *** [arch/ppc/kernel/time.o] Error 1
make: *** [arch/ppc/kernel] Error 2
--

Please apply following patch if this is a correct fix.

Regards,
-- 
Takeharu KATO

Signed-off-by: Takeharu KATO <takeharu1219@ybb.ne.jp>

--- linux-2.6.11.maybe/arch/ppc/kernel/time.c   2005-03-05
23:58:20.000000000 +0900
+++ linux-2.6.11/arch/ppc/kernel/time.c 2005-03-13 00:46:49.000000000 +0900
@@ -89,7 +89,6 @@ unsigned long tb_to_ns_scale;

 extern unsigned long wall_jiffies;

-static long time_offset;

 DEFINE_SPINLOCK(rtc_lock);
