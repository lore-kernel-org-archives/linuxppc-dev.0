Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BACC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:47:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE952087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE952087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qq565rn9zDqWr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 16:47:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qq3L2vHxzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:46:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qq3K6r8jz9sDX;
 Thu, 31 Jan 2019 16:46:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon
 exception return
In-Reply-To: <87a7jirrn6.fsf@suse.de>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-2-joe.lawrence@redhat.com>
 <87tvhqpbzd.fsf@concordia.ellerman.id.au> <87a7jirrn6.fsf@suse.de>
Date: Thu, 31 Jan 2019 16:46:05 +1100
Message-ID: <87zhrhnzvm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Nicolai Stange <nstange@suse.de>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicolai Stange <nstange@suse.de> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Joe Lawrence <joe.lawrence@redhat.com> writes:
>>> From: Nicolai Stange <nstange@suse.de>
>>>
>>> The ppc64 specific implementation of the reliable stacktracer,
>>> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
>>> trace" whenever it finds an exception frame on the stack. Stack frames
>>> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
>>> as written by exception prologues, is found at a particular location.
>>>
>>> However, as observed by Joe Lawrence, it is possible in practice that
>>> non-exception stack frames can alias with prior exception frames and thus,
>>> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
>>> the stack. It in turn falsely reports an unreliable stacktrace and blocks
>>> any live patching transition to finish. Said condition lasts until the
>>> stack frame is overwritten/initialized by function call or other means.
>>>
>>> In principle, we could mitigate this by making the exception frame
>>> classification condition in save_stack_trace_tsk_reliable() stronger:
>>> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
>>> account that for all exceptions executing on the kernel stack
>>> - their stack frames's backlink pointers always match what is saved
>>>   in their pt_regs instance's ->gpr[1] slot and that
>>> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>>>   uncommonly large for non-exception frames.
>>>
>>> However, while these are currently true, relying on them would make the
>>> reliable stacktrace implementation more sensitive towards future changes in
>>> the exception entry code. Note that false negatives, i.e. not detecting
>>> exception frames, would silently break the live patching consistency model.
>>>
>>> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
>>> rely on STACK_FRAME_REGS_MARKER as well.
>>>
>>> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
>>> for those exceptions running on the "normal" kernel stack and returning
>>> to kernelspace: because the topmost frame is ignored by the reliable stack
>>> tracer anyway, returns to userspace don't need to take care of clearing
>>> the marker.
>>>
>>> Furthermore, as I don't have the ability to test this on Book 3E or
>>> 32 bits, limit the change to Book 3S and 64 bits.
>>>
>>> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
>>> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
>>> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
>>> PPC_BOOK3S_64, there's no functional change here.
>>
>> That has nothing to do with the fix and should really be in a separate
>> patch.
>>
>> I can split it when applying.
>
> If you don't mind, that would be nice! Or simply drop that
> chunk... Otherwise, let me know if I shall send a split v2 for this
> patch [1/4] only.

No worries, I split it out:

commit a50d3250d7ae34c561177a1f9cfb79816fcbcff1
Author:     Nicolai Stange <nstange@suse.de>
AuthorDate: Thu Jan 31 16:41:50 2019 +1100
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Thu Jan 31 16:43:29 2019 +1100

    powerpc/64s: Make reliable stacktrace dependency clearer
    
    Make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
    PPC_BOOK3S_64 for documentation purposes. Before this patch, it
    depended on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN
    implies PPC_BOOK3S_64, there's no functional change here.
    
    Signed-off-by: Nicolai Stange <nstange@suse.de>
    Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
    [mpe: Split out of larger patch]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..73bf87b1d274 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -220,7 +220,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
+	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING


cheers
