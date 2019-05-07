Return-Path: <SRS0=Sivu=TH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE6C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 01:31:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319920835
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 01:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yhrg11RTzDqNF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 11:30:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yhpy1Xj9zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2019 11:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44yhpy0kRQz9sB3; Tue,  7 May 2019 11:29:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44yhpy03Rbz9s9y;
 Tue,  7 May 2019 11:29:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christopher M Riedl <cmr@informatik.wtf>,
 Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64s: support nospectre_v2 cmdline option
In-Reply-To: <1109071681.181819.1557148869293@privateemail.com>
References: <20190505221048.28212-1-cmr@informatik.wtf>
 <271ab704-e3d2-f04c-4758-2b08c1b3909c@linux.ibm.com>
 <1109071681.181819.1557148869293@privateemail.com>
Date: Tue, 07 May 2019 11:29:29 +1000
Message-ID: <87sgtrvypy.fsf@concordia.ellerman.id.au>
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

Christopher M Riedl <cmr@informatik.wtf> writes:
>> On May 5, 2019 at 9:32 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>> On 6/5/19 8:10 am, Christopher M. Riedl wrote:
>> > Add support for disabling the kernel implemented spectre v2 mitigation
>> > (count cache flush on context switch) via the nospectre_v2 cmdline
>> > option.
>> > 
>> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> > Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
>> >
>> > diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
>> > index b33bafb8fcea..f7c34745cd0f 100644
>> > --- a/arch/powerpc/kernel/security.c
>> > +++ b/arch/powerpc/kernel/security.c
>> > @@ -391,6 +394,13 @@ static void toggle_count_cache_flush(bool enable)
>> >   
>> >   void setup_count_cache_flush(void)
>> >   {
>> > +	if (no_spectrev2) {
>> > +		if (security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED)
>> > +		    || security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED))
>> > +			pr_warn("Spectre v2 mitigations not under software control, can't disable\n");
>> 
>> If one of those ftrs is set, what's the impact of not calling 
>> toggle_count_cache_flush()?
>> 
>
> The patchsite/callsite (kernel/entry_64.S:597) for flush_count_cache
> inside _switch remains a nop.
>
> Disassembly of vmlinux after build:
> c00000000000e260:       00 00 23 f8     std     r1,0(r3)
> c00000000000e264:       00 00 00 60     nop
> c00000000000e268:       00 60 c0 3c     lis     r6,24576
>
> Disassembly (xmon) after boot/during runtime in qemu:
> c00000000000e260  f8230000	std     r1,0(r3)
> c00000000000e264  4bffdb7d	bl      c00000000000bde0	# flush_count_cache+0x0/0x2420
> c00000000000e268  3cc06000	lis     r6,24576
>
> Disassembly (xmon) after boot/during runtime in qemu w/ nospectre_v2:
> c00000000000e260  f8230000	std     r1,0(r3)
> c00000000000e264  60000000	nop
> c00000000000e268  3cc06000	lis     r6,24576

Yes you're right, in this case the initial state is deactivated.

> toggle_count_cache_flush() well uhh "toggles" the patchsite to either
> contain a branch to the flush procedure or a nop.

Sort of. It doesn't actually know the initial state, so calling it at
boot with false will still nop out the nops.

I think I'd probably prefer it if we still call
toggle_count_cache_flush(false) when no_spectrev2 is true. The main
reason being that it means we'll print to dmesg, but it would also avoid
problems if we ever change the initial state of the count cache flush.

cheers
