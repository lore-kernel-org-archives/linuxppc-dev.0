Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3FFC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 19:14:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A4220874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 19:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bFzF4BdVzDq8V
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 06:14:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mentor.com
 (client-ip=192.94.38.131; helo=relay1.mentorg.com;
 envelope-from=joseph_myers@mentor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codesourcery.com
X-Greylist: delayed 3717 seconds by postgrey-1.36 at bilbo;
 Fri, 11 Jan 2019 06:12:26 AEDT
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bFxQ6jD7zDqyl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 06:12:26 +1100 (AEDT)
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=svr-ies-mbx-01.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1ghemP-0006ih-QG from joseph_myers@mentor.com ;
 Thu, 10 Jan 2019 10:10:09 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 10 Jan 2019 18:10:06 +0000
Received: from jsm28 (helo=localhost)
 by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
 (envelope-from <joseph@codesourcery.com>)
 id 1ghemL-0001MG-Lx; Thu, 10 Jan 2019 18:10:05 +0000
Date: Thu, 10 Jan 2019 18:10:05 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation
 for y2038
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
References: <20190110162435.309262-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, linux@dominikbrodowski.net,
 linux-mips@vger.kernel.org, jcmvbkbc@gmail.com, deepa.kernel@gmail.com,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 dave@stgolabs.net, y2038@lists.linaro.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 will.deacon@arm.com, linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 10 Jan 2019, Arnd Bergmann wrote:

> - Add system calls that have not yet been integrated into all
>   architectures but that we definitely want there.

glibc has a note that alpha lacks statfs64, any plans for that?

-- 
Joseph S. Myers
joseph@codesourcery.com
