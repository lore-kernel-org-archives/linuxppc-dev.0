Return-Path: <linuxppc-dev+bounces-24566-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD23C44520
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:15:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41FD2zQjz2xFc;
	Tue, 21 Jul 2026 12:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784555170;
	cv=none; b=VST4735TQYBbnqT/90juXO8GLIrrxzd6cdN+wCXxR6//lhWSA9RYAZabVT/aCcjQngtpknZ5KN9KTMQVJYMCejgSeLyUn9G1gUMq0FzyNDPTNsc1hJmIXZRbQPPp8wobx2YCksRVHKQo5oyY1VPZsua6RZrCN+Qiy0fwCwG7mPQj87TXcqPLRiySwbw/Ij7Bmua6u5uwhEIcVaapo/vsqguZbH/LNp3+SxtPvnUuHoEfjX6ecqEj90Y8ouuFq8Z10UXenyG/Z8P+CcMw3uF1zBbFdaTYyJqRlkLooCoNAR0WOcjnNVIEzM2Q24wvuJ36wK0cGni1SmuWaHYLWOMQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784555170; c=relaxed/relaxed;
	bh=CiqM6HQnEYGFM1tqwPiFklMvqyJPy7ipNoK3CEVhAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELeGyGl7tWRxZXTsGejW5Mu3MuLBBdmk0Nm6UTUU8e9b2YdcRwRV0xtVVcWdKMnYq8ipN2lDY5zNDkZswXl1XoZADUGnIjhCNrm9iJWjFHeeuGTg5K/cdXCSopFJVyDswWQmk1WzvYS9bAtmYHT4H09vustXiwBYhmvcikp+cwT0sImMGLCteVJlSzyKNxedqWBfW0/8XuXyY8/ULX3ykWEoS4Ck1cLw1h3nwzrOi1pkCWfWBx/vTYBZ3Bm6UpSI/aI9NsT8T2oxGWpv4kykU+V2qB45chUd48x7IKGgNKUjshvqaRuWHCXY6AAucrDhpbc/Iv3JOOVqZDteiR5QNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Xgi4Qqvn; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Xgi4Qqvn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hcc70sYz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:46:08 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-84a2c90e383so2481801b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784555165; x=1785159965; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CiqM6HQnEYGFM1tqwPiFklMvqyJPy7ipNoK3CEVhAc8=;
        b=Xgi4Qqvna2wcbKTC5cF7TKkCR95IA0jOYqxwPQhZWGMe26czkb/1B25YxDgo7sWIpc
         s4VPvfMqHjyAXqHOF1+n9dVMxlfWmP+guygjQWKZdLNetqEX9Lj78lFpJd+cBrKK6F+n
         6QIsTpb9d1FYGNMT5ToVD+7+DuTsK7PaWAFrpLuo1WO3LxW8OPKJj+Cvc2MMBeoGcc2C
         g4Hf4xYQkbhN3iGkX/egkbE9iofO8Dl438xh5cY1rTFIdKyu5niIl672g+BDX8G/YaPh
         fGhhkFap9qnfawhyUz6uDKgNs6gue+d2b7IE2/oLvzPOrIZE0ja/iGw9tnBGQ/EmKK6m
         q4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555165; x=1785159965;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CiqM6HQnEYGFM1tqwPiFklMvqyJPy7ipNoK3CEVhAc8=;
        b=FQxDxJwhrMVOKMh71+PEG+C4TWHofvCcjryAM02p1faC5mzJUqBYmmXDqF6D+DZqd1
         cDFmhWj+LC7hBcrb2OW63bvvsP//2SATOta4X4qn67ygLetTKb0IIRxSmuxRNd3NAjQq
         dk5QpAk4ygRaBUBQoUsJycUJ8HPPG4sR2EGlrV58mYvUZiYUMQdjTqQ09zFiLhsMUS5F
         IQK6Zzaiqvqihf+Cf+mk6Bz67FuR/JsYzZslg7xUi3BelzJ4QBtLf8Bhx7+pA8VScIBN
         LC+emwY3hjJ03WrHy8cMx21Zji6b0igttTjkV5bjdOFHHY2n0AjgBXYz9xKVjthjXX0Z
         619A==
X-Forwarded-Encrypted: i=1; AHgh+RqfmsvOTpBq+ERSUfNMJgqjkmyig8swkRm4AYqmSFj3aUeW7Q+kNGJPX3yIVNqOd6wXyKIBAvhJM9OLFNQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxUx6bKwOFXluXAcE4EUcXAHS7XVAltFguNuJTsTbvC5yZC79wk
	dAK/XdEP3ZCHTThn47D9B9Yi1Tc6m0q1VSc+fZDz+S18bTFPZlvtzkwB7GhmkyeBDGk=
X-Gm-Gg: AfdE7ckiFAa5CX8Xc6+GU7Dfem4Yi/eCqnJDHIhhBhtx5+OTTH0CZkmvRe0DmOiSWcD
	eSCNMwGIWJ5D5zP72NBtQ0ZIHRPVatpR0TxV3lNfpOscGhP9l/qKv0fMTPk+kAwlSrw/FjRYp7u
	bbpE9nwPYK3Cq1dUC+XrK3jXo3TLFPraJijqcHZ1wbbjgU8/B1FJqnj1RwQ28CYxgm5f6tB8HYr
	V2bBPCAZ96xzfiSmwnLfJA8f5nVgez144Aj50ylncG2sj0EeCMhGRKLYcRr/zF4C13/uAaVUFn/
	Yff6kvXDmMXw5wInpccSrHCoqJkZ9ceUQxEFrI5FJmVgvjFkutBrYOG0H6HHvV2Z1FD1RHOF9/A
	IpSIWkwC4UhdfB/CTE3VW1yK7ajHH01una8ysqyZZajsK4b8tRPNyp4x7gM0OiYZ98KfByQ==
X-Received: by 2002:a05:6a00:1390:b0:848:2f58:e1e9 with SMTP id d2e1a72fcca58-84beb54b717mr19266604b3a.36.1784555165506;
        Mon, 20 Jul 2026 06:46:05 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2e68e7b8sm5439737b3a.35.2026.07.20.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:46:04 -0700 (PDT)
Date: Mon, 20 Jul 2026 06:46:04 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 05/14] net: enetc: use PCI device name
 for debugfs directory
Message-ID: <al4mnM58+65TQnfI@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-6-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-6-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:07AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> enetc_create_debugfs() is called right after register_netdev(), at which
> point ndev->name still holds the format "eth%d" (e.g., eth0) rather than
> the final assigned name (e.g., via udev rules).
> 
> Use pci_name() instead of netdev_name() to name the debugfs directory.
> The PCI device name is unique, stable, and available from the start,
> making it a more reliable identifier for the debugfs entry. Therefore,
> the observable debugfs path from something like
> /sys/kernel/debug/eth0/mac_filter to a PCI BDF-style path such as
> /sys/kernel/debug/0002:00:00.0/mac_filter.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> index 4a769d9e5679..be378bf8f74d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> @@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
>  
>  void enetc_create_debugfs(struct enetc_si *si)
>  {
> -	struct net_device *ndev = si->ndev;
>  	struct dentry *root;
>  
> -	root = debugfs_create_dir(netdev_name(ndev), NULL);
> +	root = debugfs_create_dir(pci_name(si->pdev), NULL);
>  	if (IS_ERR(root))
>  		return;
>  

Reviewed-by: Joe Damato <joe@dama.to>

