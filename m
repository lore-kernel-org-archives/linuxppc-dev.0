Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED0C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 00:04:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5E9214C6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 00:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5E9214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bNQk1TmfzDqrj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 11:04:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=nstange@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bNLC2q4QzDqng
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 11:00:44 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 88094AD7F;
 Fri, 11 Jan 2019 00:00:40 +0000 (UTC)
From: Nicolai Stange <nstange@suse.de>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
Date: Fri, 11 Jan 2019 01:00:38 +0100
In-Reply-To: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com> (Joe Lawrence's
 message of "Thu, 10 Jan 2019 16:14:00 -0500")
Message-ID: <87bm4ocbbt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 11 Jan 2019 11:03:15 +1100
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
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Joe,

Joe Lawrence <joe.lawrence@redhat.com> writes:

> tl;dr: On ppc64le, what is top-most stack frame for scheduled tasks
>        about?

If I'm reading the code in _switch() correctly, the first frame is
completely uninitialized except for the pointer back to the caller's
stack frame.

For completeness: _switch() saves the return address, i.e. the link
register into its parent's stack frame, as is mandated by the ABI and
consistent with your findings below: it's always the second stack frame
where the return address into __switch_to() is kept.

<snip>

>
>
> Example 1 (RHEL-7)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> crash> struct task_struct.thread c00000022fd015c0 | grep ksp
>     ksp =3D 0xc0000000288af9c0
>
> crash> rd 0xc0000000288af9c0 -e 0xc0000000288b0000
>
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>
> sp[0]:
>
> c0000000288af9c0:  c0000000288afb90 0000000000dd0000   ...(............
> c0000000288af9d0:  c000000000002a94 c000000001c60a00   .*..............
>
>         crash> sym c000000000002a94
>         c000000000002a94 (T) hardware_interrupt_common+0x114

So that c000000000002a94 certainly wasn't stored by _switch(). I think
what might have happened is that the switching frame aliased with some
prior interrupt frame as setup by hardware_interrupt_common().

The interrupt and switching frames seem to share a common layout as far
as the lower STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) bytes are
concerned.

That address into hardware_interrupt_common() could have been written by
the do_IRQ() called from there.


> c0000000288af9e0:  c000000001c60a80 0000000000000000   ................
> c0000000288af9f0:  c0000000288afbc0 0000000000dd0000   ...(............
> c0000000288afa00:  c0000000014322e0 c000000001c60a00   ."C.............
> c0000000288afa10:  c0000002303ae380 c0000002303ae380   ..:0......:0....
> c0000000288afa20:  7265677368657265 0000000000002200   erehsger."......
>
>         Uh-oh...
>
>         /* Mark stacktraces with exception frames as unreliable. */
>         stack[STACK_FRAME_MARKER] =3D=3D STACK_FRAME_REGS_MARKER


Aliasing of the switching stack frame with some prior interrupt stack
frame would explain why that STACK_FRAME_REGS_MARKER is still found on
the stack, i.e. it's a leftover.

For testing, could you try whether clearing the word at STACK_FRAME_MARKER
from _switch() helps?

I.e. something like (completely untested):

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 435927f549c4..b747d0647ec4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -596,6 +596,10 @@ _GLOBAL(_switch)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
 	std	r0,_NIP(r1)	/* Return to switch caller */
+
+	li	r23,0
+	std	r23,96(r1)	/* 96 =3D=3D STACK_FRAME_MARKER * sizeof(long) */
+
 	mfcr	r23
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */


<snap>

>
> save_stack_trace_tsk_reliable
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> arch/powerpc/kernel/stacktrace.c :: save_stack_trace_tsk_reliable() does
> take into account the first stackframe, but only to verify that the link
> register is indeed pointing at kernel code address.

It's actually the other way around:

	if (!firstframe && !__kernel_text_address(ip))
		return 1;


So the address gets sanitized only if it's _not_ coming from the first
frame.


Thanks,

Nicolai

--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton,
HRB 21284 (AG N=C3=BCrnberg)
