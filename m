Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE02C25B67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 07:08:38 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1cKRZ/dq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGv045vpkz3cTs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 18:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1cKRZ/dq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGtz529zlz2xgw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 18:07:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A83D6127C;
	Fri, 27 Oct 2023 07:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BD8C433C7;
	Fri, 27 Oct 2023 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698390461;
	bh=wJS+QNrJXp1MsR3/ZUU86Cl8sI9OcARWlPbkBdr/bKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1cKRZ/dqG1UPyK7jGIKlc7d4qyLaGMVNalQpqY5YHNuJmLJssUWMCh6+DxStZzOCx
	 ycijrCqRKHCwG3bBlKXxj6ROCUqVDwp9sptIHEiJoXAY5OMP9E1PBCQQoH3nnqTxU/
	 IxMV/TmCRUpp4AVho4hqjROmuArhRVLTI/EHMcDk=
Date: Fri, 27 Oct 2023 09:07:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
Message-ID: <2023102709-purse-repressed-d8b9@gregkh>
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
 <87o7gld8l4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7gld8l4.fsf@kernel.org>
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Witold Baryluk <witold.baryluk@gmail.com>, pavel@ucw.cz, gregory.greenman@intel.com, stf_xl@wp.pl, linux-staging@lists.linux.dev, ilw@linux.intel.com, geert@linux-m68k.org, kuba@kernel.org, stas.yakovlev@gmail.com, arnd@arndb.de, nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org, arnd@kernel.org, geoff@infradead.org, linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev, johannes@sipsolutions.net, quic_jjohnson@quicinc.com, davem@davemloft.net, Larry.Finger@lwfinger.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 26, 2023 at 12:41:27PM +0300, Kalle Valo wrote:
> For example, I see lots of dead code under '#ifdef NOT_YET' and '#if 0',
> removing those is a good a start. Also converting the ugly debug_level
> procfs file to something more modern would be nice, maybe using just
> dev_dbg() throught the driver is a good option? Or maybe use a module
> parameter instead?

Ick, no new module parameters, this isn't the 1990's, please just use
the netdev debug lines instead :)

thanks,

greg k-h
