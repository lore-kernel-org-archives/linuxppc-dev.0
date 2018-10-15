Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B202C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:17:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27A920652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27A920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQC75VXlzDrPt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:17:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPqx4710zF13h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPqx34z3z9sj2; Mon, 15 Oct 2018 15:01:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: dfd718a2ed1f678e66749ffe41bdeafedf3f4314
In-Reply-To: <1538390439-17072-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/rtas: Fix a potential race between CPU-Offline &
 Migration
Message-Id: <42YPqx34z3z9sj2@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:01 +1100 (AEDT)
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-01 at 10:40:39 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Live Partition Migrations require all the present CPUs to execute the
> H_JOIN call, and hence rtas_ibm_suspend_me() onlines any offline CPUs
> before initiating the migration for this purpose.
> 
> The commit 85a88cabad57
> ("powerpc/pseries: Disable CPU hotplug across migrations")
> disables any CPU-hotplug operations once all the offline CPUs are
> brought online to prevent any further state change. Once the
> CPU-Hotplug operation is disabled, the code assumes that all the CPUs
> are online.
> 
> However, there is a minor window in rtas_ibm_suspend_me() between
> onlining the offline CPUs and disabling CPU-Hotplug when a concurrent
> CPU-offline operations initiated by the userspace can succeed thereby
> nullifying the the aformentioned assumption. In this unlikely case
> these offlined CPUs will not call H_JOIN, resulting in a system hang.
> 
> Fix this by verifying that all the present CPUs are actually online
> after CPU-Hotplug has been disabled, failing which we restore the
> state of the offline CPUs in rtas_ibm_suspend_me() and return an
> -EBUSY.
> 
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dfd718a2ed1f678e66749ffe41bdea

cheers
