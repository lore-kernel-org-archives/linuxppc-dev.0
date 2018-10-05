Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF4CC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:29:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F822084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F822084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RXFs2052zF3RM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 00:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=alexander.h.duyck@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RXCT6bTjzF3RM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:27:33 +1000 (AEST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Oct 2018 07:27:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; d="scan'208";a="89475080"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.252.137.177])
 ([10.252.137.177])
 by orsmga003.jf.intel.com with ESMTP; 05 Oct 2018 07:27:30 -0700
Subject: Re: linux-next: Tree for Oct 4
To: Stephen Rothwell <sfr@canb.auug.org.au>, Guenter Roeck <linux@roeck-us.net>
References: <20181004183449.36bcc93b@canb.auug.org.au>
 <20181004134644.GA9130@roeck-us.net>
 <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
 <20181005094445.4d0b68bc@canb.auug.org.au>
 <01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
 <20181005153905.126a005e@canb.auug.org.au>
From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <72f64b32-20f0-0e9a-a8f6-3e0845abb586@linux.intel.com>
Date: Fri, 5 Oct 2018 07:27:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005153905.126a005e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Linus PPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Linux-Next <linux-next@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/4/2018 10:39 PM, Stephen Rothwell wrote:
> Hi Guenter,
> 
> On Thu, 4 Oct 2018 18:33:02 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Most of the boot failures are hopefully fixed with
>> https://lore.kernel.org/patchwork/patch/995254/
> 
> I have added that commit to linux-next today.
> 

After getting over that I ended up running into an issues with a NULL 
pointer dereference updating static keys/jump labels that was fixed by:
https://lore.kernel.org/patchwork/patch/993864/

Thanks.

- Alex
