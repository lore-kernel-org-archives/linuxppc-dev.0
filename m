Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E6F42C02B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 17:18:54 +1000 (EST)
Message-ID: <51A308D2.6040101@windriver.com>
Date: Mon, 27 May 2013 15:18:42 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: Re: [PATCH] powerpc/32bit, PREEMPT:Load TI_FLAGS to check NEED_RESCHED
References: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
 <51A300F4.80103@windriver.com>
 <AC83832D6324604BB08FAE5A33553F190B3B7A4C@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <AC83832D6324604BB08FAE5A33553F190B3B7A4C@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/2013 02:55 PM, Jain Priyanka-B32167 wrote:
>
> If we go some more lines up in the same file, the code is
>
> resume_kernel:
>          /* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>          CURRENT_THREAD_INFO(r9, r1)
>          lwz     r8,TI_FLAGS(r9)
>          andis.  r8,r8,_TIF_EMULATE_STACK_STORE@h

Okay, but could you fix this directly like:

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e514de5..4498467 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -851,7 +851,7 @@ resume_kernel:
         /* check current_thread_info, _TIF_EMULATE_STACK_STORE */
         CURRENT_THREAD_INFO(r9, r1)
         lwz     r8,TI_FLAGS(r9)
-       andis.  r8,r8,_TIF_EMULATE_STACK_STORE@h
+       andis.  r0,r8,_TIF_EMULATE_STACK_STORE@h
         beq+    1f

         addi    r8,r1,INT_FRAME_SIZE    /* Get the kprobed function entry */

Tiejun
