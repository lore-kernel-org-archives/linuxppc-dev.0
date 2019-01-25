Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:10:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8917220844
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 12:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8917220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mHsB2LM7zDqGY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 23:10:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ilande.co.uk
 (client-ip=82.165.15.123; helo=s16892447.onlinehome-server.info;
 envelope-from=mark.cave-ayland@ilande.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ilande.co.uk
X-Greylist: delayed 1498 seconds by postgrey-1.36 at bilbo;
 Fri, 25 Jan 2019 23:07:39 AEDT
Received: from s16892447.onlinehome-server.info (chuckie.co.uk [82.165.15.123])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mHpM6yDKzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 23:07:38 +1100 (AEDT)
Received: from host86-147-134-102.range86-147.btcentralplus.com
 ([86.147.134.102] helo=[192.168.1.65])
 by s16892447.onlinehome-server.info with esmtpsa
 (TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1gmzsb-0006iq-8W; Fri, 25 Jan 2019 11:42:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <9a0d1b68-47fb-70bc-7fb4-521d0179da03@ilande.co.uk>
Date: Fri, 25 Jan 2019 11:42:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.102
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: MSR_FE mask change broke KVM PR MacOS guest
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Jan 2012 02:45:44 +0000)
X-SA-Exim-Scanned: Yes (on s16892447.onlinehome-server.info)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: paulus@samba.org, cyrilbur@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

Referencing my bug report over on the kvm-ppc list at
https://www.spinics.net/lists/kvm-ppc/msg14971.html, I've been experiencing a hard
lockup and panic on a G4 Mac Mini when trying run MacOS X under KVM PR which I've
bisected down to the following commit:


$ git bisect bad
8792468da5e12e77e76e1edf081acf0392abb331 is the first bad commit
commit 8792468da5e12e77e76e1edf081acf0392abb331
Author: Cyril Bur <cyrilbur@gmail.com>
Date:   Mon Feb 29 17:53:49 2016 +1100

    powerpc: Add the ability to save FPU without giving it up

    This patch adds the ability to be able to save the FPU registers to the
    thread struct without giving up (disabling the facility) next time the
    process returns to userspace.

    This patch optimises the thread copy path (as a result of a fork() or
    clone()) so that the parent thread can return to userspace with hot
    registers avoiding a possibly pointless reload of FPU register state.

    Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Working through the changes which can be found at
https://github.com/torvalds/linux/commit/8792468da5e12e77e76e1edf081acf0392abb331,
I've discovered that the lockup is being caused by the removal of the the MSR_FE0 and
MSR_FE1 masks from the previous task during giveup_fpu().

Before this patch:


_GLOBAL(giveup_fpu)
        mfmsr   r5
        ori     r5,r5,MSR_FP
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
        oris    r5,r5,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
        SYNC_601
        ISYNC_601
        MTMSRD(r5)                      /* enable use of fpu now */
        SYNC_601
        isync
        PPC_LCMPI       0,r3,0
        beqlr-                          /* if no previous owner, done */
        addi    r3,r3,THREAD            /* want THREAD of task */
        PPC_LL  r6,THREAD_FPSAVEAREA(r3)
        PPC_LL  r5,PT_REGS(r3)
        PPC_LCMPI       0,r6,0
        bne     2f
        addi    r6,r3,THREAD_FPSTATE
2:      PPC_LCMPI       0,r5,0
        SAVE_32FPVSRS(0, R4, R6)
        mffs    fr0
        stfd    fr0,FPSTATE_FPSCR(r6)
        beq     1f
        PPC_LL  r4,_MSR-STACK_FRAME_OVERHEAD(r5)
        li      r3,MSR_FP|MSR_FE0|MSR_FE1

                ^^^^^^^^^^^^^^^^^^^^^^^^^
#ifdef CONFIG_VSX
BEGIN_FTR_SECTION
        oris    r3,r3,MSR_VSX@h
END_FTR_SECTION_IFSET(CPU_FTR_VSX)
#endif
        andc    r4,r4,r3                /* disable FP for previous task */


and after the patch:

void __giveup_fpu(struct task_struct *tsk)
{
	save_fpu(tsk);
	tsk->thread.regs->msr &= ~MSR_FP;
                                 ^^^^^^^

#ifdef CONFIG_VSX
	if (cpu_has_feature(CPU_FTR_VSX))
		tsk->thread.regs->msr &= ~MSR_VSX;
#endif
}


Reinstating the MSR_FE0 and MSR_FE1 bitmasks fixes the issue allowing MacOS X to boot
without incident again:


diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 14c09d25de98..f9ac44621dda 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL(__msr_check_and_clear);
 void __giveup_fpu(struct task_struct *tsk)
 {
        save_fpu(tsk);
-       tsk->thread.regs->msr &= ~MSR_FP;
+       tsk->thread.regs->msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
 #ifdef CONFIG_VSX
        if (cpu_has_feature(CPU_FTR_VSX))
                tsk->thread.regs->msr &= ~MSR_VSX;


Would the above be accepted as a patch? The commit message for the patch above fails
to mention why the MSR_FE* constants were removed from the MSR bitmask, so I'm not
sure whether this was deliberate? Certainly running with the above patch applied, I
haven't noticed anything obviously broken. And could this patch cause any ill-effects
on 64-bit PPC CPUs?


ATB,

Mark.
