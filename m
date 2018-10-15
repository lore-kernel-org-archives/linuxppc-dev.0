Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD860C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:10:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76332064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76332064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YbMK3BYFzF3Ny
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:10:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YbK96J1MzF3MY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 22:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YbK9424wz9s55;
 Mon, 15 Oct 2018 22:08:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
In-Reply-To: <458fb5e1-3654-e8db-dfa7-074195decb11@linux.vnet.ibm.com>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
 <458fb5e1-3654-e8db-dfa7-074195decb11@linux.vnet.ibm.com>
Date: Mon, 15 Oct 2018 22:08:28 +1100
Message-ID: <87sh17zcur.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> On Saturday 13 October 2018 04:26 PM, Michael Ellerman wrote:
>> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
>> That means the layout of the structure is ABI, ie. we can't change it.
>>
>> That would be fine if it was only used to describe the user-visible
>> register state of a process, but it's also the struct we use in the
>> kernel to describe the registers saved in an interrupt frame.
>>
>> We'd like more flexibility in the content (and possibly layout) of the
>> kernel version of the struct, but currently that's not possible.
>>
>> So split the definition into a user-visible definition which remains
>> unchanged, and a kernel internal one.
>>
>> At the moment they're still identical, and we check that at build
>> time. That's because we have code (in ptrace etc.) that assumes that
>> they are the same. We will fix that code in future patches, and then
>> we can break the strict symmetry between the two structs.
>
> Nice and awesome. But just trying to understand. What will
> *regs will point to in the "struct sigcontext".

Yeah that's a bit fishy.

It should always point to a user_pt_regs.

So in the kernel we want:

  struct sigcontext {
  	...
  	struct user_pt_regs	__user *regs;

And in userspace we want:

  struct sigcontext {
  	...
  	struct pt_regs	__user *regs;


I think it's not actually broken at the moment, because it's just a
pointer, and we don't do anything based on the sizeof() the type.

But still we should fix it.

I guess I'll do this:

diff --git a/arch/powerpc/include/uapi/asm/sigcontext.h b/arch/powerpc/include/uapi/asm/sigcontext.h
index 2fbe485acdb4..630aeda56d59 100644
--- a/arch/powerpc/include/uapi/asm/sigcontext.h
+++ b/arch/powerpc/include/uapi/asm/sigcontext.h
@@ -22,7 +22,11 @@ struct sigcontext {
 #endif
 	unsigned long	handler;
 	unsigned long	oldmask;
-	struct pt_regs	__user *regs;
+#ifdef __KERNEL__
+	struct user_pt_regs __user *regs;
+#else
+	struct pt_regs	*regs;
+#endif
 #ifdef __powerpc64__
 	elf_gregset_t	gp_regs;
 	elf_fpregset_t	fp_regs;


Thanks for the review.

cheers
