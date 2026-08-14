Return-Path: <linuxppc-dev+bounces-25880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0981DC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 22:06:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMGXy1fTZz2y7Y;
	Sat, 15 Aug 2026 08:06:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786745218;
	cv=none; b=D64V1gXkPFlzpjcW30ZSG6+bS9kA9hlbup+1sgHGu9P6zYJdeJC2+kxZB0STTt4JS65BThce+nlWkKhnd/1efBFAwd5B+IrpjZ/+ayUwNVcKqKzs5Oike8hOh5FugPgLUI+pZ0oI/qIKT0Sx6vExck6CVfdmTbrZlVJarfWpFZ3xL62tPpc6AqcDr4X0C+/O0tGIgr1Z3FPMUYuG7HXJb7J/cr2/hMbwPo5i4hpIcTcFTFI2sMXRz1fDSzbvG/RIif0rLteG5bp3/eOxqsOzsDz170pTmR10xwg6GMgQz2Bp+6xccaOBCI317dZ8PebmWRwwZiZjUM6u0pzxu2P1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786745218; c=relaxed/relaxed;
	bh=43EJgsZqDVbV2DjeQ/GksSldFhIpCXxnr2u8QDpaJTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gKsW2EmgUpZ/5e/2DzKvgSJp3y+1KUII7cY7JeYqAGavoxmx+vlNGoMOzi627SuYTfbbWqAZXjtWMSM5jTjQ1NLUYG0mgig/4LqQYW0+5unqd3ZdlJkU3cAi1Gt3X/ogQfJtCJMfmnwDRHNdmCB5Uyh1TV5PC2DGgYpdS0m5zk2TPUByXpt0hnErvrQJyTO8sW1mZWyH2S71QM333rvf95JUW0zVBOwbILMBnZNuL0cJJabEkmau8h3mrGkEPF/dAw9j6tjSqVx7VfCPD+5KWcMqeBRkM06nDhlX4EEYTcCgibn0rC4PgqIXNXRIyvT0FPwfqqLssua/4ZkolgkzIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksZSNSI4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksZSNSI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMGXx26Frz2xyl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 08:06:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 07C3D60008;
	Fri, 14 Aug 2026 22:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C631F000E9;
	Fri, 14 Aug 2026 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786745213;
	bh=43EJgsZqDVbV2DjeQ/GksSldFhIpCXxnr2u8QDpaJTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ksZSNSI4qVp+ZNRnuKGiTDmtvihG+f7HWyfWu2U1CiOA3t/q5PKYI7YJ9NbEq6uRV
	 D1jYBvEV7wqvdR04OkcmBhnYokh+Wu5TslKBH23vlbNwABCAvnmcEfzo0uklmfykB+
	 PSs7TYmstpmM9IplQYRPBEPgX6hwdygvzrMd6QJd99Rgdk96OrMPyzNMEsjcsHp5j4
	 sQZ+o6W51tNRUvvePQpHrg68dzF/4BE0AczHorskc3vcR7bobDUz9yVyUAyA7WjVPb
	 vF8xyU5ge7/TjD7iu9+JC30YEs+cG++044TwKr54O1NJUZ88ghk7jY/fR1y44NNbMB
	 ugxObgm8V7PJA==
Date: Fri, 14 Aug 2026 17:06:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: dmatlack@google.com, Nicholas Piggin <npiggin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sourabhjain@linux.ibm.com,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>, radheys@amd.com,
	skhawaja@google.com, djeffery@redhat.com,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-arm-kernel@lists.infradead.org, souravsgl@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/3] firmware/edd: use kobject_put() on
 edd_device_register() failure
Message-ID: <20260814220652.GA101268@bhelgaas>
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
In-Reply-To: <20260814210057.4102768-3-tarunsahu@google.com>

On Fri, Aug 14, 2026 at 09:00:56PM +0000, Tarun Sahu wrote:
> As per koject_init_and_add() function kernel document, even if this
> function returns error kobject_put must be used instead of kfree.

Thanks for adding this specific pointer.  I wouldn't repost just for
these nits, and wait at least a few days before reposting for any
reason.  But if you do repost:

s/koject_init_and_add/kobject_init_and_add/

Might also add "()" after function names consistently (kobject_put and
kfree above, edd_release below).  Also applies to the other patches.

The current subject lines basically restate the C code; you might
consider more of a focus on the problem.  I ran this through gemini
and I think it did a decent job:

  firmware: edd: Fix kobject reference leak on registration failure

  Per kobject_init_and_add() kernel-doc, calling kfree() directly on
  error bypasses reference counting and skips the kobject's release
  callback, leaking the reference.

  Use kobject_put() instead of kfree() on registration failure to fix
  this.

> When edd_device_register() fails after initializing the kobject with
> kobject_init_and_add(), calling kfree(edev) directly bypasses the
> kobject release callback (edd_release) and leaks the allocated kobject
> resources.
> 
> Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
> registration failure.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  drivers/firmware/edd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
> index f980c5b56858..763e7b16d517 100644
> --- a/drivers/firmware/edd.c
> +++ b/drivers/firmware/edd.c
> @@ -748,7 +748,7 @@ edd_init(void)
>  
>  		rc = edd_device_register(edev, i);
>  		if (rc) {
> -			kfree(edev);
> +			kobject_put(&edev->kobj);
>  			goto out;
>  		}
>  		edd_devices[i] = edev;
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 

