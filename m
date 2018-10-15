Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D80C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:28:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C347A2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C347A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQRJ4dwczF116
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:28:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPr33nBbzF35r
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPr26NJYz9sDX; Mon, 15 Oct 2018 15:01:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 65b9fdadfc4d87e2577b791fb3495cd39c93d8c0
In-Reply-To: <20181009195504.22636.20595.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mwb@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v02] powerpc/mobility: Extend start/stop topology update scope
Message-Id: <42YPr26NJYz9sDX@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:06 +1100 (AEDT)
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-09 at 20:12:14 UTC, Michael Bringmann wrote:
> The PPC mobility code may receive RTAS requests to perform PRRN
> topology changes at any time, including during LPAR migration
> operations.  In some configurations where the affinity of CPUs
> or memory is being changed on that platform, the PRRN requests
> may apply or refer to outdated information prior to the complete
> update of the device-tree.  This patch changes the duration for
> which topology updates are suppressed during LPAR migrations from
> just the rtas_ibm_suspend_me / 'ibm,suspend-me' call(s) to cover
> the entire 'migration_store' operation to allow all changes to
> the device-tree to be applied prior to accepting and applying any
> PRRN requests.
> 
> For tracking purposes, pr_info notices are added to the functions
> start_topology_update() and stop_topology_update() of 'numa.c'.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/65b9fdadfc4d87e2577b791fb3495c

cheers
