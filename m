Return-Path: <linuxppc-dev+bounces-17868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90E7EA8536
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Mar 2026 16:19:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTQM14Rmbz3c4d;
	Mon, 09 Mar 2026 03:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772986749;
	cv=none; b=g87BpA/eO6x2T/l/iPA3vWCCeuN09PRdRxxhJDjYX0tUKa++QWpiFLcqPpbhqSbwzwRHVjPrq1QgfwNxCauPlLNwn1bbg3g0DhcnUzX1UcCQUn71mvRlzHMTVToOUDGrOL/rK4+cKwxh9i2Mmxjqk5dKACCLl6y5QQURSGykHGrKuA14tVoLq93B7XrIDtn67UsT3BDl8KB7ySZ8d8Ihm+ZEcfS27hVCN5Gd0PfMDkHAaOzjOrZZgV2rL/LnS+qp1fp4Y1FKG9WLlgRQ4/1S/miO+8eeqU+9656cFzkFJ/87lrOKZFYxIOoqaZkEWlYdqw+wbdCJk2THt1dn+tggmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772986749; c=relaxed/relaxed;
	bh=/cKN/6iawKgnQRyKbEQ45nAUplK//qLG3DIQMuxFFfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nawxAEBCCFb/1y9saK7VPlXJ3kS2P+9o4nJqHHceiG+ecFsFcJlX3MMngA1ys3JQRSl9XJFwpJ7zNYsutrBnN+Rw2u0bz/Bj2Pkm98ZYd9GfHPQt7DFtcFDWgRVnj7mNqrK6ff9dBeyYjTf6BMqvIPRh09bVSlBVui0DENJDAj7UHcoQd635FjcDJ3X8EBG3rZs1PNSmUZLGoXj7brLVcpet9V2YwDVLuqbdL971PCIQEtKixQwQ5EJ7CWQh5xZTSs3gma6DMxOEr+7X3oOZTtoHZ8UuGU8+KMS+4eArnybiLr6HXL6yheaxyciw5fAJr/7zxZo083iLGCvR4FuJ+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G4HbTHjQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=G4HbTHjQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTQLz6H64z3bTf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 03:19:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B5D344017;
	Sun,  8 Mar 2026 16:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB29FC116C6;
	Sun,  8 Mar 2026 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772986744;
	bh=mhOJ6fEZ8X0Mwa2WasBbeUv/CXeY4qF0R4tBJHye2OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4HbTHjQVrcJJ6MmoKSjkmlkE5C9Z7PKNVAmY/+PF3RzjK8gO1CGzgM51yiggS00M
	 xsWMRZlNLTbgm84itqKuxe2ITlcTL5s/1XUwAVdw4OTAcPtci1Z98ZdvtgvGDs0WOg
	 VWfYd5u1SmxQfQAoiaqOSk9wnNZnu6P2M0Zvpn5I=
Date: Sun, 8 Mar 2026 17:19:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>, Haren Myneni <haren@linux.ibm.com>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: vas-api: constify dynamic struct class in
 coproc api register
Message-ID: <2026030846-wince-recess-c338@gregkh>
References: <20260308123917.1013607-1-jkoolstra@xs4all.nl>
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
In-Reply-To: <20260308123917.1013607-1-jkoolstra@xs4all.nl>

On Sun, Mar 08, 2026 at 01:39:12PM +0100, Jori Koolstra wrote:
> diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
> index 9f093176b8db..34403582c895 100644
> --- a/arch/powerpc/platforms/powernv/vas-window.c
> +++ b/arch/powerpc/platforms/powernv/vas-window.c
> @@ -1459,7 +1459,6 @@ static const struct vas_user_win_ops vops =  {
>  int vas_register_api_powernv(struct module *mod, enum vas_cop_type cop_type,
>  			     const char *name)
>  {
> -
>  	return vas_register_coproc_api(mod, cop_type, name, &vops);
>  }
>  EXPORT_SYMBOL_GPL(vas_register_api_powernv);
> 

This change wasn't needed here :(

thanks,

greg k-h

