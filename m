Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E81C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:51:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6218021479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6218021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TwYx1FJgzF39y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 22:51:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TwWY6GB2zF39g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 22:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TwWY23P5z9s7h;
 Tue,  9 Oct 2018 22:49:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mwb@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mobility: Extend start/stop topology update scope
In-Reply-To: <20181001185603.11373.61650.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181001185603.11373.61650.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
Date: Tue, 09 Oct 2018 22:49:41 +1100
Message-ID: <87lg771gru.fsf@concordia.ellerman.id.au>
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

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
> ---
>  arch/powerpc/kernel/rtas.c                |    4 ----
>  arch/powerpc/mm/numa.c                    |    6 ++++++
>  arch/powerpc/platforms/pseries/mobility.c |    5 +++++
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 8afd146..28d8b57 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -981,8 +981,6 @@ int rtas_ibm_suspend_me(u64 handle)
>  		goto out;
>  	}
>  
> -	stop_topology_update();
> -
>  	/* Call function on all CPUs.  One of us will make the
>  	 * rtas call
>  	 */

This doesn't apply to my next branch, it conflicts with:

  85a88cabad57 ("powerpc/pseries: Disable CPU hotplug across migrations")

Can you please rebase it?

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=next

cheers
