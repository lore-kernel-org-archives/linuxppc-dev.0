Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E6606A33F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 04:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgkvq8fq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbLPF16H7z2xqh;
	Fri, 27 Nov 2026 15:42:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795754545;
	cv=none; b=IFTwC1EcAPi+tGN4TT0v9n3l4kinqIC/WtaWbcxugC4swSJzsv93+jDM8YnSCKF3gFPjbsRMYKBCe4AEQVnx+qM4yjW5LqDlYhNtY0mwe72sAlUrLLIvz+xR74z6hLuQFNtYNIT2vYMBMawkC6Xkz+3Fh0LTu/Pol6pYl4N1PDPykFDTZubsansAqEoLWIjssVC7i70v0DOFW6xaJwRFzkzJEraxDmq/SU53V3b2/Rmg20gD9xXKOfCLq+NN/Rd9jHg9CeK0pUw4a7U8dN7NdQxWN2yslSvqx5d0ltHFYH+GsX0tegdOMMzoDVsoCRe9SOLgchfoFY3kotJWSseO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795754545; c=relaxed/relaxed;
	bh=2r21NtFZutp/tNeLCkdxw3coUtlf6pJI45+P6Sov/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbiVSIpvBygdXxHP+RJR4Sk5u6MGRbHQfbYOhourdOQNUUe4iTJGSFybdyfanqEPRTwlY+Ym6LudkGYDfuHI/Rn/NEF899JkAsuIVIMCVfk2eYeph+L+m+pcQLPrIoKJW0/qPOTmT+I6EJd7pb9BRvJfy85Y0FrSSABoL/H2apz7lmZJEbdAHQA+7NMoxjYgBFxzo0nGkZxK8U1gaJjwliYFTCreF8FrVfnX2A/Ni+MySDF+AbhbDVX5SCT782bnE3+2zd+/GLo++/PMt3lUFKzseM4SSCX/eCMo5AreiBYHOkC/JphMJrsjPfbKQp19Zww9UWVx5vAVinQdOkeAHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgkvq8fq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgkvq8fq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jbLPD2CkLz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 15:42:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 23B1B408EB;
	Fri, 27 Nov 2026 04:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 467E11F00893;
	Fri, 27 Nov 2026 04:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754541;
	bh=2r21NtFZutp/tNeLCkdxw3coUtlf6pJI45+P6Sov/yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgkvq8fqkP+xA1zj8/b/I1DdDLoXTTRaYx2FBzVV+laUoQ9f0ED2nub0ukGbKyWcf
	 HKe/241oXskPPGsjn2UdnmUJ7EEd34wJwCvpdczkuXEmGuTY3ggAg4V8gM764iXgkb
	 I0wBpAy1ubPW7VD7g8zvekIHWDgFA+7ah6nKOCFWlFiAOwrntc65iLUZ+ZPxS5WWeR
	 AzBIAvNEP526ONeFRTKeuC4dpqib1cwYeV9vQ9GHENszoNXTNdEFskaAqSZwWIJZmw
	 2Ue9Smr1mbBVwfV9/uiNk10dy4YUUcgCzKvryyzt7XdPMKCinH+rPQyjy5UujNS/5O
	 8+GUeKtk1Me/g==
Date: Fri, 27 Nov 2026 06:42:17 +0200
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
Subject: Re: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with
 CONFIG_PM_SLEEP=n
Message-ID: <awkKKfv4ZrVYy0Ky@kernel.org>
References: <20261127010124.848125-1-zhouzhouyi@gmail.com>
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
In-Reply-To: <20261127010124.848125-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 01:01:24AM +0000, Zhouyi Zhou wrote:
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
> 

nit: should not have empty line here.

> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 51c7e2add3d2..9840d0ebe6a3 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
> +				tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);

I'd keep these in same line.

>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> @@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver = {
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

Otherwise, it's good.

Br, Jarkko

