Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E89C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:59:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6D22082E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYg9X80s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6D22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZPjH6R7bzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:59:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="YYg9X80s"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZPgh4HzfzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 11:57:52 +1100 (AEDT)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F278C2082E;
 Thu,  4 Apr 2019 00:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1554339470;
 bh=mJwodE2gRa2C3WW5YdRbgfUkn8szJ9u1XhmMgYBgYBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YYg9X80sINpVkIevZK5YRlzuwm0+NB1xTF+vpBpkMQnI4BlXUVa3ItjY0O9e4GYm6
 t6Q7tRM3rgDP7r6EYRrh/FJ4mrSr1avZZkifdEoeXcKMQxMSwbznEe3lQd/hjJuUy7
 2dByCQhDwXcwg4uZVBI9YgDUAM9WHinBax6BHAU8=
Date: Wed, 3 Apr 2019 20:57:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 5.0 015/262] memblock:
 memblock_phys_alloc_try_nid(): don't panic
Message-ID: <20190404005748.GJ16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-15-sashal@kernel.org>
 <20190328055720.GB14864@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328055720.GB14864@rapoport-lnx>
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
Cc: Rich Felker <dalias@libc.org>, Petr Mladek <pmladek@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Rob Herring <robh@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <ren_guo@c-sky.com>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 28, 2019 at 07:57:21AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Wed, Mar 27, 2019 at 01:57:50PM -0400, Sasha Levin wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> [ Upstream commit 337555744e6e39dd1d87698c6084dd88a606d60a ]
>>
>> The memblock_phys_alloc_try_nid() function tries to allocate memory from
>> the requested node and then falls back to allocation from any node in
>> the system.  The memblock_alloc_base() fallback used by this function
>> panics if the allocation fails.
>>
>> Replace the memblock_alloc_base() fallback with the direct call to
>> memblock_alloc_range_nid() and update the memblock_phys_alloc_try_nid()
>> callers to check the returned value and panic in case of error.
>
>This is a part of memblock refactoring, I don't think it should be applied
>to -stable.

Dropped, thanks!

--
Thanks,
Sasha
