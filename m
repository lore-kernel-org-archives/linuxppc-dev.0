Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F9C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:45:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1DB204EC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1DB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qk0v2RfxzF3BM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:45:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjKG5PS1zF3BM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjKF4NXnz9s8T; Thu,  4 Oct 2018 16:14:41 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8a03e81cb14712f986c5d5fa42a30ff2cbe3237c
In-Reply-To: <20180926122430.13924-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, Haren Myneni <haren@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: consolidate MCE counter increment.
Message-Id: <42QjKF4NXnz9s8T@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:41 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-09-26 at 12:24:30 UTC, Michal Suchanek wrote:
> The code in machine_check_exception excludes 64s hvmode when
> incrementing the MCE counter only to call opal_machine_check to
> increment it specifically for this case.
> 
> Remove the exclusion and special case.
> 
> Fixes: a43c1590426c ("powerpc/pseries: Flush SLB contents on SLB MCE
> 		errors.")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a03e81cb14712f986c5d5fa42a30f

cheers
