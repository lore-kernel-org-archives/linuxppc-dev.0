Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5AC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 17:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE03D20578
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejGwBCRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE03D20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fvDF5vYZzDqnD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 04:22:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ejGwBCRo"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fvBS5R7dzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 04:21:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HjB4WyTG0y963TSzDm2EKwD/+zJ5pPanwxddC7G0mTw=; b=ejGwBCRoKP4jizHf4jljpbq8Ge
 ocCCBkkxl47KYLXCdgdiSlP1dPQ4T+/v7X9oPIF96L33/f6dIitqjyFlq0jNCV2n7uDwd9bcp5gcu
 1CmaOIU+Hz15IHxd+zAJc4JWyEOQzUJCFr64ukBPVoMOvn6B66p3jrlLgYdx/Fs7TMSMvTAbH1827
 TQL888u1TxkBcoqcj5Mc8C6ZQSSiwIo2pynIwahqkRuXq6a6lUs2+czBg+iHGFb5nxpvsV93YVz8D
 2KRhJFDorEc5PSVa7knXcLCqEkAap6W/kCR7dyMgPqJ808vj9ZJ79fmvbIeyLjncdF18CEl1YnEcb
 y+oADF8A==;
Received: from [199.233.58.37] (helo=[10.83.93.157])
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjosL-0002gO-7t; Wed, 16 Jan 2019 17:21:13 +0000
Subject: Re: [PATCH] powerpc/ps3: Use struct_size() in kzalloc()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190108210010.GA980@embeddedor>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <595f7b4b-9e26-ae72-de5f-270dce677c65@infradead.org>
Date: Wed, 16 Jan 2019 09:21:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108210010.GA980@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Gustavo,

On 1/8/19 1:00 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/powerpc/platforms/ps3/device-init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
> index e7075aaff1bb..59587b75493d 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -354,9 +354,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
>  		 repo->dev_index, repo->dev_type, port, blk_size, num_blocks,
>  		 num_regions);
>  
> -	p = kzalloc(sizeof(struct ps3_storage_device) +
> -		    num_regions * sizeof(struct ps3_storage_region),
> -		    GFP_KERNEL);
> +	p = kzalloc(struct_size(p, regions, num_regions), GFP_KERNEL);
>  	if (!p) {
>  		result = -ENOMEM;
>  		goto fail_malloc;
It seems to me the motivation for this change is just to have a
code change.  As I've said for other similar patches, I'm reluctant
to accept such trivial changes to the PS3 code because it makes
it harder for me to maintain the code in the long term.  When I
need to do a git bisect to track down a problem I generally have
a set of debugging patches that I apply on top of the bisect.  A
change to the code like this creates the potential for a patch
conflict that I then need to manually edit to resolve.

If this change was for relatively new code, or better, for a patch
that was submitted but not yet merged, then my feelings would be
different.  I think it would be really useful to have something
that scans patches in patchwork.

-Geoff
