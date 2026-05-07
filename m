Return-Path: <linuxppc-dev+bounces-20573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF7ECD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 15:35:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBGXf0R2yz2xQC;
	Fri, 08 May 2026 01:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778168113;
	cv=none; b=dqxiRsOXSgMQB1iuXLC/99C9EdVVEcPZfbwU6DCRrRutHQlfdZogQu0L25z02V/rUuQ8UdHBah/kXjH6kdEm1ETI/RVWU8hsg8GUeGCx2UrNwzTmYWWcwzoLGjmqP/Hmw4UvDs+t1Ji+Z811IChgG+1+u7hqoM9UwvqyCz0Lf9QbGI7L77r9CAPrIBoLILdJcAc7d3Vj2gtVyufI8lMGFTM3wU+Q6X3B9MF/777bz7vVD3woq2uZUkeA04UHyeqTVcHwdep0kkNCJeJhWxo4YMc/dZRmZw4Vvz4okWgj/X1UbGF2NVaR6gUcRUZA9GuY8pIZgwO/EX/mrthy4AVmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778168113; c=relaxed/relaxed;
	bh=8CP/y3oVn3N78iCMTniq89jeAR5Rqn/G5wxZXvBJrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRJBG+fF2SPnHfWhERVl5TryzAzkjmGaADbkhaMbbJs8Q9bo8Wdym2CoUrUddNXzBnXl0YdynULJFCthxc+v6DmpNMw061HRkbOj7+YauxxFbg2X5wYe8UdE+2Pw38IuDwMUckiYn798yyVU29xz3ynT1YVbdLf7IBYcg23IQzAK6r8ABQHkUx5rOUX8lG3gN8JGp/OgbsZ5zGX9JubjXnF5Ydtzzb0t6Wfxz5TTEuwZOOrAe1SbtxTz/tzAt0HoFPsf6MvkmG+GSyFQ2FHBHDnZ25xUNA2RE0G/a8dMPyqqH5DLVm1F+PVwr4UgMQhawwpxzB5HBLHey29lWf88lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WcWBKvcp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WcWBKvcp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBGXd1z8nz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 01:35:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 64EAD43242;
	Thu,  7 May 2026 15:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A07C2BCB2;
	Thu,  7 May 2026 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778168110;
	bh=rzn+mXwuxuGBqeL9f0zlEdgdDoITVl3qMXqi0a/HbI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcWBKvcpSgYbkBNyr6JNT1JrlsNQNjuDcOrxP9Q04JR7iG1SGc53yJH9QuWx5bU6x
	 V3bLy879FPuVi32guDbf+7BM6eD2rG0QsVrSlIBxJHWhd6nwvx/fOu6yjzWxUC7lsf
	 ppTsFMDsQK6dNf9+DRUSOd4udu7qMWEQZ7ICQIc9NUqxdGbHEgFSC35l5T9xjZTsNS
	 l4W6WgDn9gxuCsAeA9SdmMeOdmR8pfwnBXaWyeo3hLoxjnlKlKKRQE58NzxMwvsLRV
	 OBQl58iKhbpDNK1WmaUAz0L0ER1vrXEEI+o6c88vRJ1twtcyZiK8t6jU3Do5lOnVhB
	 ZNuiPLuNt/Row==
Date: Thu, 7 May 2026 08:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
 <chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260507083508.681108f1@kernel.org>
In-Reply-To: <AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
	<20260506161629.5488a643@kernel.org>
	<AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 15:07:35 +0000 Holger Brunck wrote:
> > On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:  
> > > When the device is removed all allocated resources should be freed.
> > > In uhdlc_memclean the netdev transmit queue was already stopped. But
> > > at this point we may have pending skb in the transmit queue which must
> > > be freed. Therefore iterate over the tx_skbuff pointers and free all
> > > pending skb. The issue was discovered by sashiko.  
> > 
> > And you tested this how?
> > 
> > Given the questionable v1 I'm highly hesitant to accept patches from you if you
> > can't test them.  
> 
> I tested the patch on a ls1043a board running HDLC in busmode on kernel 6.12

Please add this to the commit message, as previously requested.

