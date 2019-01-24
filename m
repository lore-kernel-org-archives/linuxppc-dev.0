Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA308C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 18:02:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B342184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 18:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B342184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lqkK1v4mzDqLs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 05:02:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=embeddedor.com
 (client-ip=192.185.51.122; helo=gateway24.websitewelcome.com;
 envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=embeddedor.com
X-Greylist: delayed 1323 seconds by postgrey-1.36 at bilbo;
 Fri, 25 Jan 2019 05:00:51 AEDT
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com
 [192.185.51.122])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lqhM11TvzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 05:00:51 +1100 (AEDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id 6F3BA84ADC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 11:38:46 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id mixigdW3k2qH7mixigFLS1; Thu, 24 Jan 2019 11:38:46 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=42898 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gmixi-0007RP-2y; Thu, 24 Jan 2019 11:38:46 -0600
Subject: Re: powerpc/ps3: Use struct_size() in kzalloc()
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <43lSbT1lyfz9sN8@ozlabs.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <36d34731-e072-452b-48b8-9e68773c5425@embeddedor.com>
Date: Thu, 24 Jan 2019 11:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <43lSbT1lyfz9sN8@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmixi-0007RP-2y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:42898
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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



On 1/23/19 9:40 PM, Michael Ellerman wrote:
> On Tue, 2019-01-08 at 21:00:10 UTC, "Gustavo A. R. Silva" wrote:
>> One of the more common cases of allocation size calculations is finding the
>> size of a structure that has a zero-sized array at the end, along with memory
>> for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     void *entry[];
>> };
>>
>> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can now
>> use the new struct_size() helper:
>>
>> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/31367b9a01d6a3f4f77694bd44f547d6
> 

Thanks, Michael.

--
Gustavo
