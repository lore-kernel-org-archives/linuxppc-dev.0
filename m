Return-Path: <SRS0=9Gbk=CC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4576120738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2020 18:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bb0l33CxvzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 04:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Bb0jG52whzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 04:17:52 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 07OIHSLx029771;
 Mon, 24 Aug 2020 13:17:28 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 07OIHQLo029770;
 Mon, 24 Aug 2020 13:17:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 24 Aug 2020 13:17:26 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Guohua Zhong <zhongguohua1@huawei.com>
Subject: Re: =?utf-8?B?UmXvvJpSZQ==?=
 =?utf-8?Q?=3A?= [PATCH] powerpc: Fix a bug in __div64_32 if divisor is zero
Message-ID: <20200824181726.GR28786@gate.crashing.org>
References: <20200823001101.GO28786@gate.crashing.org>
 <20200824115407.55896-1-zhongguohua1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824115407.55896-1-zhongguohua1@huawei.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: wangle6@huawei.com, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 stable@vger.kernel.org, nixiaoming@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 24, 2020 at 07:54:07PM +0800, Guohua Zhong wrote:
> >> Yet, I have noticed that there is no checking of 'base' in these functions.
> >> But I am not sure how to check is better.As we know that the result is 
> >> undefined when divisor is zero. It maybe good to print error and dump stack.
> >>  Let the process to know that the divisor is zero by sending SIGFPE. 
> 
> > That is now what the PowerPC integer divide insns do: they just leave
> > the result undefined (and they can set the overflow flag then, but no
> > one uses that).
> 
> OK ,So just keep the patch as below. If this patch looks good for you, please
> help to review. I will send the new patch later.
> 
> Thanks for your reply.
> 
> diff --git a/arch/powerpc/boot/div64.S b/arch/powerpc/boot/div64.S
> index 4354928ed62e..1d3561cf16fa 100644
> --- a/arch/powerpc/boot/div64.S
> +++ b/arch/powerpc/boot/div64.S
> @@ -13,8 +13,10 @@
> 
>         .globl __div64_32
>         .globl __div64_32
>  __div64_32:
> + cmplwi      r4,0    # check if divisor r4 is zero
>         lwz     r5,0(r3)        # get the dividend into r5/r6
>         lwz     r6,4(r3)
> + beq 5f                      # jump to label 5 if r4(divisor) is zero

Just "beqlr".

This instruction scheduling hurts all CPUs that aren't 8xx, fwiw (but
likely only in the case where r4 *is* zero, so who cares :-) )

So...  What is the *goal* of this patch?  It looks like the routine
would not get into a loop if r4 is 0, just return the wrong result?
But, it *always* will, there *is* no right result?

No caller should call it with zero as divisor ever, so in that sense,
checking for it in the division routine is just pure wasted work.


Segher
