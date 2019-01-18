Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D4C5AE5E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:10:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E5A2086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 00:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blastwave.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hJ9H1LhHzDrL1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 11:10:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=blastwave.org
 (client-ip=209.17.115.119; helo=atl4mhfb03.myregisteredsite.com;
 envelope-from=dclarke@blastwave.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=blastwave.org
X-Greylist: delayed 379 seconds by postgrey-1.36 at bilbo;
 Sat, 19 Jan 2019 04:03:52 AEDT
Received: from atl4mhfb03.myregisteredsite.com
 (atl4mhfb03.myregisteredsite.com [209.17.115.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h6jN1mcPzDr6t
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 04:03:51 +1100 (AEDT)
Received: from atl4mhob22.registeredsite.com (atl4mhob22.registeredsite.com
 [209.17.115.116])
 by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 x0IGvbab012154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:57:37 -0500
Received: from mailpod.hostingplatform.com
 (atl4qobmail01pod2.registeredsite.com [10.30.77.35])
 by atl4mhob22.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IGvRa9136394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:57:27 -0500
Received: (qmail 46093 invoked by uid 0); 18 Jan 2019 16:57:27 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?)
 (dclarke@blastwave.org@174.118.245.214)
 by 0 with ESMTPA; 18 Jan 2019 16:57:26 -0000
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20190118161835.2259170-1-arnd@arndb.de>
From: Dennis Clarke <dclarke@blastwave.org>
Message-ID: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
Date: Fri, 18 Jan 2019 11:57:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 19 Jan 2019 11:08:47 +1100
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
Cc: linux-m68k@vger.kernel.org, dalias@libc.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, catalin.marinas@arm.com, heiko.carstens@de.ibm.com,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 will.deacon@arm.com, linux-fsdevel@vger.kernel.org, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> This is a minor update of the patches I posted last week, I
> would like to add this into linux-next now, but would still do
> changes if there are concerns about the contents. The first
> version did not see a lot of replies, which could mean that
> either everyone is happy with it, or that it was largely ignored.
> 
> See also the article at https://lwn.net/Articles/776435/.

I would be happy to read "Approaching the kernel year-2038 end game"
however it is behind a pay wall.  Perhaps it may be best to just
host interesting articles about open source idea elsewhere.

Dennis Clarke

