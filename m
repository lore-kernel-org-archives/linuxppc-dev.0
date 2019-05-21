Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB28C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 11:40:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C70620862
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 11:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C70620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457Yhr6qFZzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 21:39:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457YgF0G6KzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 21:38:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 457YgD4n4Pz9s55;
 Tue, 21 May 2019 21:38:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org
Subject: Re: [PATCH] powerpc/mm/hash: Improve address limit checks
In-Reply-To: <455jHY5Y1zz9sBp@ozlabs.org>
References: <455jHY5Y1zz9sBp@ozlabs.org>
Date: Tue, 21 May 2019 21:38:30 +1000
Message-ID: <87v9y46nrd.fsf@concordia.ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Thu, 2019-05-16 at 11:50:54 UTC, "Aneesh Kumar K.V" wrote:
>> Different parts of the code do the limit check by ignoring the top nibble
>> of EA. ie. we do checks like
>> 
>> 	if ((ea & EA_MASK)  >= H_PGTABLE_RANGE)
>> 	   	error
>> 
>> This patch makes sure we don't insert SLB entries for addresses whose top nibble
>> doesn't match the ignored bits.
>> 
>> With an address like 0x4000000008000000, we can result in wrong slb entries like
>> 
>> 13 4000000008000000 400ea1b217000510   1T ESID=   400000 VSID=   ea1b217000 LLP:110
>> 
>> without this patch we will map that EA with LINEAR_MAP_REGION_ID and further
>> those addr limit check will return false.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/c179976cf4cbd2e65f29741d5bc07ccf

Actually this patch was superseeded. This should have been a reply to:

  https://lore.kernel.org/linuxppc-dev/20190517132958.22299-1-mpe@ellerman.id.au/

cheers
