Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtKR5499zDqyN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:10:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@bayern-mail.de>,
 linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, Darren Stevens <darren@stevens-zone.net>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@me.com>,
 Julian Margetson <runaway@candw.ms>, "contact\@a-eon.com" <contact@a-eon.com>,
 Alex Perez <aperez@alexperez.com>, luigi burdo <intermediadc@hotmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 Sasha Levin  <sasha.levin@oracle.com>
Subject: Re: Kernel 4.1.28: Update TM user feature bits in scan_features()
In-Reply-To: <01f37269-7f95-225a-b09e-2f1995a394a3@bayern-mail.de>
References: <01f37269-7f95-225a-b09e-2f1995a394a3@bayern-mail.de>
Date: Thu, 14 Jul 2016 21:10:34 +1000
Message-ID: <87d1mga311.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@bayern-mail.de> writes:

> Hi All,
>
> I tried to compile the kernel 4.1.28 today. Unfortunately it doesn't 
> compile because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.
>
> Error message:
>
>    CHK     include/config/kernel.release
>    CHK     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
>    CHK     include/generated/bounds.h
>    CHK     include/generated/asm-offsets.h
>    CALL    scripts/checksyscalls.sh
>    CHK     include/generated/compile.h
>    CALL    arch/powerpc/kernel/systbl_chk.sh
>    CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c:170:25: error: 'PPC_FEATURE2_HTM_NOSC_COMP' 
> undeclared here (not in a function)
>     PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
>                           ^
> make[1]: *** [arch/powerpc/kernel/prom.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
>
> ---
>
> Commit:
>
> f49eb503f0f9ab66874a81992b14249a1c59b6ad
> Author: Anton Blanchard <anton@samba.org>
> Date:   Fri Apr 15 12:08:19 2016 +1000
>
>      powerpc: Update TM user feature bits in scan_features()
>
>      [ Upstream commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017 ]
>
>      We need to update the user TM feature bits (PPC_FEATURE2_HTM and
>      PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
>      bit.
>
>      At the moment, if firmware reports TM is not available we turn off
>      the kernel TM feature bit but leave the userspace ones on. Userspace
>      thinks it can execute TM instructions and it dies trying.
>
>      This (together with a QEMU patch) fixes PR KVM, which doesn't currently
>      support TM.
>
>      Signed-off-by: Anton Blanchard <anton@samba.org>
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>      Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
>
> ---
>
> PPC_FEATURE2_HTM_NOSC_COMP isn't defined or doesn't exist in the 
> following files:

Thanks.

> arch/powerpc/include/asm/cputable.h
> arch/powerpc/kernel/cputable.c
> arch/powerpc/include/uapi/asm/tm.h
>
> That means the following patches aren't included in the 4.1.28 source code:

Sorry that's the wrong fix.

PPC_FEATURE2_HTM_NOSC indicates the presence of a certain kernel
behaviour, which has *not* been backported to 4.1.

The right fix is just to remove the reference to PPC_FEATURE2_HTM_NOSC
in 4.1.28.

eg:

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 28dbbb0d12c4..9b19d96e9562 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -166,8 +166,7 @@ static struct ibm_pa_feature {
 	 * we don't want to turn on TM here, so we use the *_COMP versions
 	 * which are 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0,
-	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
+	{CPU_FTR_TM_COMP, 0, 0, PPC_FEATURE2_HTM_COMP, 22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,



cheers
