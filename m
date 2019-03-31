Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2151C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 09:56:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFFA20872
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 09:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFFA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44X9q73KFYzDqRr
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 20:56:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44X9nL4lFWzDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 20:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44X9nL3lDLz9sRm; Sun, 31 Mar 2019 20:55:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44X9nL1jKFz9sRW;
 Sun, 31 Mar 2019 20:55:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC PATCH 1/3] powernv/mce: reduce mce console logs to lesser
 lines.
In-Reply-To: <cdfb484e-0468-edb3-3d8f-306c50ddceca@linux.vnet.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
 <87bm1uo7iw.fsf@concordia.ellerman.id.au>
 <cdfb484e-0468-edb3-3d8f-306c50ddceca@linux.vnet.ibm.com>
Date: Sun, 31 Mar 2019 20:55:05 +1100
Message-ID: <87sgv3l66e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> On 3/29/19 5:50 AM, Michael Ellerman wrote:
>> Hi Mahesh,
>> 
>> Thanks for doing this series.
>> 
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> Also add cpu number while displaying mce log. This will help cleaner logs
>>> when mce hits on multiple cpus simultaneously.
>> 
>> Can you include some examples of the output before and after, so it's
>> easier to compare what the changes are.
...
>> 
>> I also think it'd be clearer to print the NIP on the 2nd line in all
>> cases, rather than the first.
>
> Sure, and I will then put "machine check" on 1st line like below ?
>
> printk("%sMCE: CPU%d: machine check (%s) %s %s %s %s[%s]\n",

Yes that would be good. Thanks.

cheers
