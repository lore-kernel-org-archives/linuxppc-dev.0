Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BDAC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:32:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D341720644
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 00:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VsP25pDkzF1Ph
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 11:32:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VsLt2QG8zF10b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 11:30:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42VsLt0t29z9s9J; Thu, 11 Oct 2018 11:30:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42VsLs62xkz9sB7;
 Thu, 11 Oct 2018 11:30:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 3/4] powerpc: Add -Wvla to arch CFLAGS
In-Reply-To: <CAGXu5jKUP573d2PFnGchT_uE=YmO83sdBUWOyAR-1UfskE5m9A@mail.gmail.com>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-3-mpe@ellerman.id.au>
 <CAGXu5jKUP573d2PFnGchT_uE=YmO83sdBUWOyAR-1UfskE5m9A@mail.gmail.com>
Date: Thu, 11 Oct 2018 11:30:27 +1100
Message-ID: <877eip2ul8.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kees Cook <keescook@chromium.org> writes:
> On Tue, Oct 9, 2018 at 10:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Upstream has declared that Variable Length Array's (VLAs) are a bad
>> idea, and eventually -Wvla will be added to the top-level Makefile. We
>> can go one better and make sure we don't introduce any more by adding
>> it to the arch Makefile.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/Kbuild | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
>> index 1625a06802ca..86b261d6bde5 100644
>> --- a/arch/powerpc/Kbuild
>> +++ b/arch/powerpc/Kbuild
>> @@ -1,4 +1,5 @@
>> -subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>> +subdir-ccflags-y := $(call cc-option, -Wvla)
>> +subdir-ccflags-$(CONFIG_PPC_WERROR) += -Werror
>>
>>  obj-y += kernel/
>>  obj-y += mm/
>
> -Wvla will be going into the top-level Makefile in the merge window
> (see linux-next), so this will be redundant.

Thanks, yeah I saw that after I posted. Will drop this one.

cheers
