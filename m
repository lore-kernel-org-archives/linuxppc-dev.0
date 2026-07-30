Return-Path: <linuxppc-dev+bounces-25077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D14AC54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:52:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fyv4vZBz2yjq;
	Thu, 30 Jul 2026 16:52:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785394359;
	cv=none; b=cmRw5E6rmCfcwZQyKLKodo4FxiZJSVgUOHU7PFd2qfkHkXI8IsLaXdhZVkeLIihhXldf9h8RIsLDr5BVt8mn7jI6/oQieiaIjwQJmZPVtGpDJH/zPQViahmXvY7SRo6C0kleXciO70WDZ2RvcSwIMIP5ewwIMybga1P4FO2xnwY4fJBb0Y2FiSgQIL94v8kfPEL/2SrFwoK3fhzsedt++B3bUeI8ciPycBcvbaqTV9ZvQbQyCFdENg5aGRJ0WuJX6MgRacZvLQzkljTirhsxTR+8LBxU8NdJRm5Ps9DBMtMQBweifYo+fgwzEW09vTMto4KZhZZyUGs1T2w+ZEDiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785394359; c=relaxed/relaxed;
	bh=DIzlyLGIgLntyw3CrG+39XGZ5HDv4kdQBAGZpZAJ76c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA9BmMESnfR5l8ON6TnZ9VJDgsHH/sPogcj8baRwo/fyFt17den9z99VAb01pFK6Q6U54KN45C+ZlR1tEHM8f1kYQG9/M1cAEwILNzZ070hteImxa5bsBe98HE1vQUYRPpDU/cFC1XZiuA+uQt0RxI8HHhcLwaZWGIGSLIz3+SOLx7bJp1f+4+9dbMjCPfCe0xIPtmT7zB3Cn7psclQwP+Vhumbzs+14yxWGLkpVjkG3Le+yfgfs2yxStdYiNt3+xMVlRzXwlaqA8eUIe2Nv7Qa6kH2TOoxcX5vbq1itjRgAUePhVd/mnY27aVLWkOHgr54NKjFGAI3WzQGxAf3Slg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ja8NO9XJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ja8NO9XJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fyt6BY5z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:52:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E5EEF402BD;
	Thu, 30 Jul 2026 06:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0396E1F000E9;
	Thu, 30 Jul 2026 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394354;
	bh=DIzlyLGIgLntyw3CrG+39XGZ5HDv4kdQBAGZpZAJ76c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ja8NO9XJFJPoyIJBvhr8EuKaZta2ji9kUPRFZjANJsKe5hVkeKadLwHyrAmmi6SSX
	 ArgCj9fiDhB58+mMWtmazPg7JEW9KM5FOMfiLus4uFvIMdUfSXZX8KD7Fc4au8mXmR
	 vIp9F9TrRSjXAd8H53RBjdDivrZeYPdsA01HGcduCqTcFrSO1BAAy3nFStsCsJ9uXp
	 F17HqkSmImG11ft8qKo0CBTCAbbMN504JD/oYZA1Ws3GDhFG/ZSPiHb73897f1Rr6b
	 nBEtgtpb0g7xJantazPb567u3QI6uCOFB4dvaZOZlpH3p4VCLpIZ3QIuMva/ZEzFVd
	 hyNq0VNlNUw/w==
Date: Wed, 29 Jul 2026 23:52:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, brking@linux.ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH v2 25/33] ibmvfc: process NVMe/FC rports in work thread
Message-ID: <20260730065226.GA1879117@ax162>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
 <20260723000149.969416-26-tyreld@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723000149.969416-26-tyreld@linux.ibm.com>

Hi Tyrel,

On Wed, Jul 22, 2026 at 05:01:41PM -0700, Tyrel Datwyler wrote:
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> index 81d9229bf388..ffb579816e84 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> @@ -6073,6 +6119,30 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
>  			}
>  		}
>  
> +		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
> +			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
> +				tgt_dbg(tgt, "Deleteing NVMe rport\n");
> +				nvme_rport = tgt->nvme_remote_port;
> +				list_del(&tgt->queue);
> +				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);
> +				spin_unlock_irqrestore(vhost->host->host_lock, flags);
> +				if (nvme_rport)
> +					ibmvfc_nvme_unregister_remoteport(tgt);
> +				timer_delete_sync(&tgt->timer);
> +				kref_put(&tgt->kref, ibmvfc_release_tgt);
> +				return;
> +			} else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
> +				tgt_dbg(tgt, "Deleting NVMe rport with outstanding I/O\n");
> +				nvme_rport = tgt->nvme_remote_port;
> +				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_LOGOUT_DELETED_RPORT);
> +				tgt->init_retries = 0;
> +				spin_unlock_irqrestore(vhost->host->host_lock, flags);
> +				if (nvme_rport)
> +					ibmvfc_nvme_unregister_remoteport(tgt);
> +				return;
> +			}
> +		}
> +
>  		if (vhost->state == IBMVFC_INITIALIZING) {
>  			if (vhost->action == IBMVFC_HOST_ACTION_TGT_DEL_FAILED) {
>  				if (vhost->reinit) {

There is a warning from clang after this change landed in -next as
commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work
thread"), breaking the build when -Werror is enabled:

  drivers/scsi/ibmvscsi/ibmvfc-core.c:6154:15: error: variable 'rport' is uninitialized when used here [-Werror,-Wuninitialized]
   6154 |                         } else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
        |                                    ^~~~~

Sashiko appears to point this out as well:

  https://lore.kernel.org/20260723005006.C7EE21F00A3A@smtp.kernel.org/

But I am not sure that its suggestion to use nvme_rport is correct given
the context of this code, hence just the report from my end.

-- 
Cheers,
Nathan

