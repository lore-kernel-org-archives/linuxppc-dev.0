Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5030C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 04:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E92B20844
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 04:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vTRk6w1RzDqPP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 15:46:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vTPv11tmzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 15:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43vTPt6lfJz9sDX;
 Wed,  6 Feb 2019 15:44:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon
 exception return
In-Reply-To: <CAKTCnznr9MoL=eZsNWyGkKYdx7UbLQr86VL=xmC8h2ig8Sw+RQ@mail.gmail.com>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-2-joe.lawrence@redhat.com>
 <20190202011455.GN26056@350D>
 <CAKTCnzmWCxPRSBdc8T_phtmoBftNZLV3BdFp3Dee5Lc8VGzFYg@mail.gmail.com>
 <87bm3qmqak.fsf@concordia.ellerman.id.au>
 <CAKTCnznr9MoL=eZsNWyGkKYdx7UbLQr86VL=xmC8h2ig8Sw+RQ@mail.gmail.com>
Date: Wed, 06 Feb 2019 15:44:48 +1100
Message-ID: <8736p1msov.fsf@concordia.ellerman.id.au>
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
 Jiri Kosina <jkosina@suse.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 live-patching@vger.kernel.org,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Balbir Singh <bsingharora@gmail.com> writes:
> On Tue, Feb 5, 2019 at 10:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> > On Sat, Feb 2, 2019 at 12:14 PM Balbir Singh <bsingharora@gmail.com> wrote:
>> >> On Tue, Jan 22, 2019 at 10:57:21AM -0500, Joe Lawrence wrote:
>> >> > From: Nicolai Stange <nstange@suse.de>
>> >> >
>> >> > The ppc64 specific implementation of the reliable stacktracer,
>> >> > save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
>> >> > trace" whenever it finds an exception frame on the stack. Stack frames
>> >> > are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
>> >> > as written by exception prologues, is found at a particular location.
>> >> >
>> >> > However, as observed by Joe Lawrence, it is possible in practice that
>> >> > non-exception stack frames can alias with prior exception frames and thus,
>> >> > that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
>> >> > the stack. It in turn falsely reports an unreliable stacktrace and blocks
>> >> > any live patching transition to finish. Said condition lasts until the
>> >> > stack frame is overwritten/initialized by function call or other means.
>> >> >
>> >> > In principle, we could mitigate this by making the exception frame
>> >> > classification condition in save_stack_trace_tsk_reliable() stronger:
>> >> > in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
>> >> > account that for all exceptions executing on the kernel stack
>> >> > - their stack frames's backlink pointers always match what is saved
>> >> >   in their pt_regs instance's ->gpr[1] slot and that
>> >> > - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>> >> >   uncommonly large for non-exception frames.
>> >> >
>> >> > However, while these are currently true, relying on them would make the
>> >> > reliable stacktrace implementation more sensitive towards future changes in
>> >> > the exception entry code. Note that false negatives, i.e. not detecting
>> >> > exception frames, would silently break the live patching consistency model.
>> >> >
>> >> > Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
>> >> > rely on STACK_FRAME_REGS_MARKER as well.
>> >> >
>> >> > Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
>> >> > for those exceptions running on the "normal" kernel stack and returning
>> >> > to kernelspace: because the topmost frame is ignored by the reliable stack
>> >> > tracer anyway, returns to userspace don't need to take care of clearing
>> >> > the marker.
>> >> >
>> >> > Furthermore, as I don't have the ability to test this on Book 3E or
>> >> > 32 bits, limit the change to Book 3S and 64 bits.
>> >> >
>> >> > Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
>> >> > PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
>> >> > on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
>> >> > PPC_BOOK3S_64, there's no functional change here.
>> >> >
>> >> > Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
>> >> > Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
>> >> > Signed-off-by: Nicolai Stange <nstange@suse.de>
>> >> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> >> > ---
>> >> >  arch/powerpc/Kconfig           | 2 +-
>> >> >  arch/powerpc/kernel/entry_64.S | 7 +++++++
>> >> >  2 files changed, 8 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> >> > index 2890d36eb531..73bf87b1d274 100644
>> >> > --- a/arch/powerpc/Kconfig
>> >> > +++ b/arch/powerpc/Kconfig
>> >> > @@ -220,7 +220,7 @@ config PPC
>> >> >       select HAVE_PERF_USER_STACK_DUMP
>> >> >       select HAVE_RCU_TABLE_FREE              if SMP
>> >> >       select HAVE_REGS_AND_STACK_ACCESS_API
>> >> > -     select HAVE_RELIABLE_STACKTRACE         if PPC64 && CPU_LITTLE_ENDIAN
>> >> > +     select HAVE_RELIABLE_STACKTRACE         if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
>> >> >       select HAVE_SYSCALL_TRACEPOINTS
>> >> >       select HAVE_VIRT_CPU_ACCOUNTING
>> >> >       select HAVE_IRQ_TIME_ACCOUNTING
>> >> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> >> > index 435927f549c4..a2c168b395d2 100644
>> >> > --- a/arch/powerpc/kernel/entry_64.S
>> >> > +++ b/arch/powerpc/kernel/entry_64.S
>> >> > @@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>> >> >       ld      r2,_NIP(r1)
>> >> >       mtspr   SPRN_SRR0,r2
>> >> >
>> >> > +     /*
>> >> > +      * Leaving a stale exception_marker on the stack can confuse
>> >> > +      * the reliable stack unwinder later on. Clear it.
>> >> > +      */
>> >> > +     li      r2,0
>> >> > +     std     r2,STACK_FRAME_OVERHEAD-16(r1)
>> >> > +
>> >>
>> >> Could you please double check, r4 is already 0 at this point
>> >> IIUC. So the change might be a simple
>> >>
>> >> std r4,STACK_FRAME_OVERHEAD-16(r1)
>> >>
>> >
>> > r4 is not 0, sorry for the noise
>>
>> Isn't it?
>
> It is, I seem to be reading the wrong bits and confused myself, had to
> re-read mtmsrd to ensure it does not modify RS, just MSR. So I guess
> we could reuse r4.

Yeah it's a bit hard to follow now that we have the split exit paths for
user vs kernel. r4 does get used on the return to userspace case, by
ACCOUNT_CPU_USER_EXIT(), but for the return to kernel it's still got
zero in it.

> Should I send a patch on top of this? I have limited testing
> infrastructure at the moment, I could use qemu

I'm not sure. It's a bit fragile relying on the r4 value being zero, it
would be easy to accidentally reuse r4. Though it actually wouldn't
matter as long as r4 never has "regshere" in it.

In fact we could store any random value there, it just needs to not be
the exception marker. eg. we could just stick the SRR0 value in there,
that should never alias with "regshere".

But I think maybe we're over thinking it, the cost of the li is pretty
minimal compared to everything else going on here, and this is only on
the return to kernel case, which is arguably not a super hot path.

cheers
