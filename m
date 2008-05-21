Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id E33D9DE0D7
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:23:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 1 GB lowmem
Date: Wed, 21 May 2008 16:24:26 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E7B25@ismail.innsys.innovsys.com>
In-Reply-To: <1941C6C3-9883-4015-91A6-35F5966AA1ED@kernel.crashing.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AA0@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AF5@ismail.innsys.innovsys.com>
	<1941C6C3-9883-4015-91A6-35F5966AA1ED@kernel.crashing.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 21, 2008, at 3:55 PM, Rune Torgersen wrote:
>> Argh... Found it. Had to set CONFIG_TASK_SIZE to 0x80000000. Now it
>> works in both vaniulla an d RT kernel.
>=20
> We should really add some sanity check on CONFIG_TASK_SIZE vs
> KERNEL_START.=20

Something like this?
Wording sould probablyy be a bit different/cleare.

diff --git a/include/asm-powerpc/processor.h
b/include/asm-powerpc/processor.h
index fd98ca9..72e0e3f 100644
--- a/include/asm-powerpc/processor.h
+++ b/include/asm-powerpc/processor.h
@@ -81,6 +81,10 @@ extern struct task_struct *last_task_used_altivec;
 extern struct task_struct *last_task_used_spe;

 #ifdef CONFIG_PPC32
+
+#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
+#error User TASK_SIZE overlaps with KERNEL_START address
+#endif
 #define TASK_SIZE      (CONFIG_TASK_SIZE)

 /* This decides where the kernel will search for a free chunk of vm
