Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0056C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCED2087E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1sUJKS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCED2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h3qN6V62zDr2K
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 01:53:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="g1sUJKS6"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h3mY29dwzDr1R
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 01:51:24 +1100 (AEDT)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 892272087E;
 Fri, 18 Jan 2019 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547823082;
 bh=Rw+m4yJtrlD3cwwvxwZ9Zp1JRHY6n22ytWCHiVdppnE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g1sUJKS65n9Bo9sFa6YNg1zxcefe349qEg1XyMDUigmlmTuA0I9HT4NTQWaRDNR4u
 7MDdKYpGqwXfwFjn7J0bNnNgKY0L3sHP2qEVBOdZbDBBhmBlEL9MvoopsRWkE111cr
 4vw+fmVxTq0gdaHACBaUL8sdnHh/zhVIFWlNDHs4=
Date: Fri, 18 Jan 2019 09:51:21 -0500
From: Sasha Levin <sashal@kernel.org>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM
Message-ID: <20190118145121.GE202535@sasha-vm>
References: <1547039805-7979-1-git-send-email-leitao@debian.org>
 <20190116133600.BA78B2086D@mail.kernel.org>
 <bc20e375-09a0-1672-f61c-f90375c31a61@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bc20e375-09a0-1672-f61c-f90375c31a61@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 09:49:05AM -0200, Breno Leitao wrote:
>hi Sasha,
>
>On 1/16/19 11:35 AM, Sasha Levin wrote:
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: e1c3743e1a20 powerpc/tm: Set MSR[TS] just prior to recheckpoint.
>>
>> The bot has tested the following trees: v4.20.2, v4.19.15, v4.14.93, v4.9.150.
>>
>> v4.20.2: Failed to apply! Possible dependencies:
>>     Unable to calculate
>>
>> v4.19.15: Failed to apply! Possible dependencies:
>>     Unable to calculate
>>
>> v4.14.93: Failed to apply! Possible dependencies:
>>     0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
>>     67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
>>     6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
>>     b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
>>     bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
>>     f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")
>>
>> v4.9.150: Failed to apply! Possible dependencies:
>>     0d60619e1c0c ("powerpc: Add missing prototype for sys_debug_setcontext()")
>>     67b464a89c21 ("powerpc/32: Mark both tmp variables as unused")
>>     6f5b9f018f4c ("powerpc/tm: Unset MSR[TS] if not recheckpointing")
>>     b53875c4b4f2 ("powerpc: Add missing prototypes for sys_sigreturn() & sys_rt_sigreturn()")
>>     bf7fb32dd5fc ("powerpc: Add missing prototypes for ppc_select() & ppc_fadvise64_64()")
>>     f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch to SYSCALL_DEFINE")
>>
>>
>> How should we proceed with this patch?
>
>I understand that the commit that this patch fixes is not integrated into
>stable tree.
>
>I think it does not need to make stable at this moment, thus.

The commit it fixes (e1c3743e1a20) exists in all 4.9+ stable trees as it
itself was tagged for stable.

--
Thanks,
Sasha
