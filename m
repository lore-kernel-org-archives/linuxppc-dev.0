Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CBCC432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A792073A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvc8P1N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A792073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47F1Dg2VNtzF54j
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 01:38:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=timur@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vvc8P1N2"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47F17T4RxNzF7Sv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2019 01:33:57 +1100 (AEDT)
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E6E620733;
 Fri, 15 Nov 2019 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573828435;
 bh=mF87Nl6gED2r2qJHxN4WWU1Jb6PLM4yh2d+dwZW5Hk8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Vvc8P1N2l/zeirxvFEhap3H1A3jDhl2uKzyj33rEKW2rwdgj5T8pzOsDy4fw1UWub
 XOWWlOSXPH1wP5r87NRbpax/A2wzVHEpPawa5nMHZ+KwvkJODp0QrvuDT4Y1ONRqcu
 eG/BLYr6FtmyUe4Co3Y8nzyrcQUTocfk9sbUsS/M=
Subject: Re: [PATCH v4 45/47] net/wan/fsl_ucc_hdlc: reject muram offsets above
 64K
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-46-linux@rasmusvillemoes.dk>
 <CAOZdJXUibQ6RM8O4CfkYBdGsg+LMcE2ZoZEQ4txn2yvquUWwCA@mail.gmail.com>
 <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
From: Timur Tabi <timur@kernel.org>
Message-ID: <3db19b28-90a4-f204-07b3-517cfd44010b@kernel.org>
Date: Fri, 15 Nov 2019 08:33:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <79101f00-e3ff-9dd0-7a05-760f8be1ff69@rasmusvillemoes.dk>
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
Cc: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/15/19 1:44 AM, Rasmus Villemoes wrote:
> I can change it, sure, but it's a matter of taste. To me the above asks
> "does the value change when it is truncated to a u16" which makes
> perfect sense when the value is next used with iowrite16be(). Using a
> comparison to U16_MAX takes more brain cycles for me, because I have to
> think whether it should be > or >=, and are there some
> signedness/integer promotion business interfering with that test.

Ok.
