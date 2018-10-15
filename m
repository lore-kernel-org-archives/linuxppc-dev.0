Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC33C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:24:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B5020652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B5020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yd105JNGzDqfW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:24:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.ee
 (client-ip=193.40.6.72; helo=mx2.cyber.ee; envelope-from=mroos@linux.ee;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ee
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ycxm1NV9zDq74
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:21:46 +1100 (AEDT)
Subject: Re: 32-bit poweroc compile failure in v4.19-rc7-166-g7ec21823634d
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
 <87tvlnzegi.fsf@concordia.ellerman.id.au>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <7c9c56d8-df58-eac7-e41e-8d2746f1c0d5@linux.ee>
Date: Mon, 15 Oct 2018 15:20:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvlnzegi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>> I tried to test the fix to 32-bit poweroc boot hang but found that current git does not compile on 32bit poweroc at all for me:
> 
> That's GCC 8 I think?

Yes, gcc version 8.2.0 (Debian 8.2.0-7).

> I have seen that but couldn't work out what the hell GCC is thinking.
> 
> I don't think there's an actual bug, the size of the copy is bounded by
> the count parameter, which *doesn't* come from user space, it's hard
> coded.
> 
> I suspect the logic is just to convoluted for GCC.
> 
> We should fix it somehow, but I haven't worked out what's the best option.
> 
> cheers

-- 
Meelis Roos <mroos@linux.ee>
