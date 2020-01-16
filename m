Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF2C32771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 02:31:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107D6222C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 02:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/mwWmJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107D6222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47yp9b4hcFzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=timur@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=f/mwWmJ7; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47yp795PjCzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 13:29:40 +1100 (AEDT)
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9868C222C3;
 Thu, 16 Jan 2020 02:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579141778;
 bh=alIOUYVHdATcAf6GTLL9eHbvKsMvNUDDLbL0hXLRV5w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=f/mwWmJ7Jjuw3huV4w4I+C3qjNOo4j0IUikg3B3hn/RG23NLdouX0Wn4MuEgzmZfj
 l16cxDP3iWl4awwRGNjSksi97fXw9028c0gbYK2wyuxuvotYIkPkowr+AWm6D7WksP
 0byvYgAWEbijbsScnjDgtpGvSkvnhfYwia1kpnBU=
Subject: Re: [PATCH] evh_bytechan: fix out of bounds accesses
To: Scott Wood <swood@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200109183912.5fcb52aa@canb.auug.org.au>
 <CAOZdJXXiKgz=hOoiaTrxgbnwzyvp1Zfn3aCz+0__i17vyFngRg@mail.gmail.com>
 <20200114072522.3cd57195@canb.auug.org.au>
 <6ec4bc30-0526-672c-4261-3ad2cf69dd94@kernel.org>
 <20200114173141.29564b25@canb.auug.org.au>
 <1d8f8ee6-65ac-de6c-0e0b-c9bb499c0e02@kernel.org>
 <20200116064234.7a139623@canb.auug.org.au>
 <9f3311d12d418b87832ba5de1372bb76ffccbd45.camel@redhat.com>
From: Timur Tabi <timur@kernel.org>
Message-ID: <68944006-eb89-fa6d-7373-dcf0abdbda84@kernel.org>
Date: Wed, 15 Jan 2020 20:29:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9f3311d12d418b87832ba5de1372bb76ffccbd45.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 york sun <york.sun@nxp.com>, Jiri Slaby <jslaby@suse.com>,
 PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>, b08248@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/15/20 2:01 PM, Scott Wood wrote:
> FWIW I'd rather see the original patch,
> that keeps the raw asm hcall stuff as simple wrappers in one place.

I can live with that.
