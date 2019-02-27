Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 11:31:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C0E2084D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 11:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C0E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448YRs0KhYzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 22:31:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448YPg5qqnzDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 22:29:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 448YPg3cY8z9s21;
 Wed, 27 Feb 2019 22:29:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V7 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of
 CMA region
In-Reply-To: <87mumhtxxx.fsf@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
 <20190226155324.e99d5200cc6293138ac5c6fa@linux-foundation.org>
 <87mumhtxxx.fsf@linux.ibm.com>
Date: Wed, 27 Feb 2019 22:29:59 +1100
Message-ID: <878sy1h3k8.fsf@concordia.ellerman.id.au>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> [patch 1/4]: OK.  I guess.  Was this worth consuming our last PF_ flag?
>
> That was done based on request from Andrea and it also helps in avoiding
> allocating pages from CMA region where we know we are anyway going to
> migrate them out. So yes, this helps. 
>
>> [patch 2/4]: unreviewed
>> [patch 3/4]: unreviewed, mpe still unhappy, I expect?
>
> I did reply to that email. I guess mpe is ok with that?

It would be nice to fold your explanation about DAX into the change log,
so it's there for people to see.

And I think my comment about initialising ret still stands.

cheers
