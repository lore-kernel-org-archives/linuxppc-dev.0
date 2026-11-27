Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4792606A324
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itVam21t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbWyZ2m6Wz2yMP;
	Fri, 27 Nov 2026 22:53:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795780406;
	cv=none; b=ImQI1U2ToIdzzDSIDpF5p5/2lwEyzg8C6j6bmsziK9V7UGGflP5GjCZpR92q+/IwHKH6kDQ3xjj3X4yhM58GSgdBbGOSnurj+5UZKdtNvEMDDko3KspxLUhiUcxjzrXJHN73lJZfft/3QghkGzQJQPp+9GpT84ER8/aWUcSP83pUMSMQF5ofEo2r3MH5Wcmol53llQTByjpKxEnZcOIodOaK86U75JgLrtlcavb3HDeVx7WlHw2aNaq8ahXUW2DAxYZJmKaje1Ye2RGzw6FQqCINo3+dfiZbKrVbDdrm2QWJUWEY4ewsVqtKZxhnCaC9QKv/24xkuqcIbE9v1aGP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795780406; c=relaxed/relaxed;
	bh=rByPEfNf4XLcPucHVrwkNxEV0dJQaoEcaC2v04KImDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK/2iDip09aafkryB/SZYnuXO5RRVbjy6YtPt4BYlatZiLkGb3Lkgx43wd9jtV6mtjjWwDJNavXZ4bebkNTZzwYVIBpnJKeXq4NYaHJEmehQX7hv9lN/8GvDdrdLLm+eW9jlLqNszSNTssnZ01dxf4y/HSzPJOj0uqU2gtBKnaPdk6Vij72lzGOOoV8Dg9uvh1e+2hhmnwoklG3A6WjzTDu4bmeqP4vxTp3VvAmvfdzVsEyNNZoNsFaq+WE50phy1vS+2mUG7xKSKF0YLZTV2uEIc14PkasXbdquKRu/Y8CKnS21P5NvYKZ3CLp8OuRtVTBklfLCBxPY4UL+bthoPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itVam21t; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itVam21t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jbWyX4vSPz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 22:53:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 3258B42A2A;
	Fri, 27 Nov 2026 11:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8862A1F000C1;
	Fri, 27 Nov 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780402;
	bh=rByPEfNf4XLcPucHVrwkNxEV0dJQaoEcaC2v04KImDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=itVam21tTHvEcaE5VJdWfQ/tgPSDAV6CDG2GMzdzyoN/mxuMlbjCKvTu2FworV8ko
	 U7OM/C/AREEZstZ1VU3BDDwN/goi5NSVpHgyhlDjXS6qgi2nf64jSnYSLll7UVpryS
	 WLdIPBh/exuiD/BBUBW5FXh68SNsHV4YssiLRrvITYGhcBKAd5wLXwjx7yGh5od1O1
	 8hMFBo2DQVo3yX8N1qNr+U/E5QyfOPsa03nsb5nl21/an5e2Oegt8L8t1cEqRNbZkM
	 efMDAmVRNTrhYS5cwidxYxi5Ge/AO1veZfDec67oehMQtdy9nU4FznwC7zn99d+vx+
	 UcvATeB77jmlA==
Date: Fri, 27 Nov 2026 13:53:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: peterhuewe@gmx.de, lance@osuosl.org, rcu@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, Li Jun <lijun01@kylinos.cn>
Subject: Re: [PATCH v2] tpm: ibmvtpm: Fix unused suspend callback with
 CONFIG_PM_SLEEP=n
Message-ID: <awlvLjQT17DBZKpN@kernel.org>
References: <20261127051359.852628-1-zhouzhouyi@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127051359.852628-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 05:13:59AM +0000, Zhouyi Zhou wrote:
> Discovered in the Open Source Lab of Oregon State University when running
> RCU torture.sh on a ppc64le VM.
> 
> With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
> omits the references to the system sleep callbacks. This leaves
> tpm_ibmvtpm_suspend() unused and produces the following warning:
> 
>   warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]
> 
> Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
> sees the callback references and can discard the unused PM code when
> system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
> called directly from tpm_ibmvtpm_send().
> 
> Tested on PPC VM of the Open Source Lab
> of Oregon State University.
> 
> Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Changes in v2:
> - Remove the blank line between Fixes: and Signed-off-by:.
> - Keep DEFINE_SIMPLE_DEV_PM_OPS() and its arguments on one line.
>   Both changes address Jarkko Sakkinen's review comments.
> 
> Only a targeted compile check was performed; the full RCU torture test
> was not run because it takes too long.
> 
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 51c7e2add3d2..dd577f075c57 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,7 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> @@ -714,7 +714,7 @@ static struct vio_driver ibmvtpm_driver = {
>  	.remove		 = tpm_ibmvtpm_remove,
>  	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
>  	.name		 = tpm_ibmvtpm_driver_name,
> -	.pm		 = &tpm_ibmvtpm_pm_ops,
> +	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
>  };
>  
>  /**
> 
> base-commit: 5f22fb20497f4983094131f00a734362300d22d2

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

