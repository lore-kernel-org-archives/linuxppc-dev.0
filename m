Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3327EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:41:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97CA218B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97CA218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449NGL6qyHzDqNR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449NDQ37dFzDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 06:39:48 +1100 (AEDT)
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79B78ADD0;
 Thu, 28 Feb 2019 19:39:46 +0000 (UTC)
Date: Thu, 28 Feb 2019 11:39:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH V5 0/5] NestMMU pte upgrade workaround for mprotect
Message-Id: <20190228113945.9d268b76bae26707e569681b@linux-foundation.org>
In-Reply-To: <87k1hltxoc.fsf@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190226153733.2552bb48dd195ae3bd46c3ef@linux-foundation.org>
 <87k1hltxoc.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: x86@kernel.org, npiggin@gmail.com, linux-mm@kvack.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 Feb 2019 14:28:43 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > [patch 1/5]: unreviewed and has unaddressed comments from mpe.
> > [patch 2/5]: ditto
> > [patch 3/5]: ditto
> > [patch 4/5]: seems ready
> > [patch 5/5]: reviewed by mpe, but appears to need more work
> 
> That was mostly variable naming preferences. I like the christmas
> tree style not the inverted christmas tree. There is one detail about
> commit message, which indicate the change may be required by other
> architecture too. Was not sure whether that needed a commit message
> update.
> 
> I didn't send an updated series because after replying to most of them I
> didn't find a strong request to get the required changes in. If you want
> me update the series with this variable name ordering and commit message
> update I can send a new series today.
> 

OK, minor stuff.

The patches have been in -next for a month, which is good but we really
should get some review of the first three.

