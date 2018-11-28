Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A3C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 20:05:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E112081C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 20:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="UaMkYPJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E112081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434s8c5yxDzDr0k
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 07:05:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="UaMkYPJC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::5; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="UaMkYPJC"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434s5g5DykzDr09
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 07:03:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543435374;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=IAnc86Mm74e3jfu9BA5jYDElkumimEEMJY+DeZ1NOtY=;
 b=UaMkYPJCIDIjIU5hTuVu93SxJrfc1/ft9RdS4FXSbRztcrbFkiq7SggoEEnRhzw2L8
 bXrKwgJC197Qswq4OW7Bmw3A1uUwTmGk3h6FqMZFhzKKiAceZY3MM48SAVRc7rmoSjQd
 lRWGnLMthg9KQxp+gl1Woxg1zmrc22LIVCrx9ysfRG8k7qowvgH6u7eWzA7KfM9YZ4pV
 9W8qDoFDn12TqZOok12yyp+ZwCvAOmImpxXV4fWunbH7BsUWepiKj+otJK9lBqvCkhgJ
 /8opPUfCWmGSlp4Knea9d7wzmr37Nu0ivl8XkxcIvoDJk/aifYSrL3/tJxm0HquB9OEo
 ceUQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpixq1SAU6WYzmze+IMPjvAQ8O/7g=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:bce9:f264:6445:f38f]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uASK2q8Eg
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 28 Nov 2018 21:02:52 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date: Wed, 28 Nov 2018 21:02:51 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B91760F-AFC3-4C8C-9B9F-FA0E9AD76B0C@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I will compile and test the kernel from the following Git on my PowerPC mach=
ines.

http://git.infradead.org/users/hch/misc.git

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.

