Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1D606A32A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HHs3PO6J
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWDmS5lglz2xpt;
	Fri, 20 Nov 2026 23:14:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795176888;
	cv=none; b=LhStGp4Xlsvr06PBTIQ0rlDIS4LoM+T3lrvs9SDmT6k/sgytPVwMeJiZO/zm6L09Dk5t/onaixLGwPOs9sD+82lQkOOeMPKsvF/HUQ/Fnx5x1f4coK1PatOPjFaV6ZuQMx/DlYQYSY/f1tdtCp3/yyXFBMQnGInsJSKKJ6fa5b/QBGX57mwUcw9JiTWCiiYBE3tYivgTm2UeQ/feKXNJWGNdsi/X5vxQKIK5RIFcL7S4OaIlj5s4DxmKUB3mE0pr9uz/03A8PRpmpHvzd4exXFz0kdzNXfTcj7pl8zbipytIJZ0c4DiGuCKXxj8ihxO/k+aL2GxkQEBd0IdfS83VLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795176888; c=relaxed/relaxed;
	bh=yfVhfgGK1OedUEyPydQHT3KhIaYnblF9DmvN6Za45Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5yQzEp3M+Q+oc/eR3NZyp9N3KpJhGqXNlx9A2AZW8COOIFHYVOji0JETsUfzDG0Q+4CkJD9ArgdqygyV/TfwKL2I23VTNSgKD+AMTO4kWEBlrTESyEaqw/sK/5g74zjTO8ANpPitMQh4zpbXMiGN3LTlWCKIcFmQOvZSUADB3elq99uqOsojFpJvqY2kTdPJ2+c0pjLzyMmL0o7dpSuDiqYe6u8wXcp+kigReA8fL1sKwnya23AvfYtwvv/fHhlwSujBljkBTLm2Myln4jGfFmxRZQPBZkxyCy+he/ABz/29MUUMZbiLGDkZ5D/jPKFUsbYO+Rdm8kY6So+py1qRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HHs3PO6J; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HHs3PO6J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWDmS0FWKz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 23:14:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E40DD400C7;
	Fri, 20 Nov 2026 12:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291D31F000D2;
	Fri, 20 Nov 2026 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795176884;
	bh=yfVhfgGK1OedUEyPydQHT3KhIaYnblF9DmvN6Za45Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HHs3PO6JY+pilipPqKehSJcCqz7dbnMnVi0GVGnI54PrcUo6xTaYUmBoy+5kqpcrq
	 E5CGl1dRRPoDGUlDobGCK9K7SHCipGokU4zf4La70QAuDGF0Da1ETWVpNvAwA+u8l6
	 7m2ngaNuV9rMuvkwZ8IDC8L1Nm9Zx5+G/b/OwLn8=
Date: Fri, 20 Nov 2026 13:14:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: gadget: fsl_udc: validate pipe index in
 ch9getstatus()
Message-ID: <2026112032-cotton-hardly-d8db@gregkh>
References: <20260917123133.3760392-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20260917123133.3760392-1-liuc63@xiaopeng.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 17, 2026 at 08:31:33PM +0800, Liu Chao wrote:
> ch9getstatus() uses get_pipe_by_windex() to compute a pipe index from
> the host-supplied wIndex field and then passes it to get_ep_by_pipe()
> to index the udc->eps[] array.  get_pipe_by_windex() can return up to
> 31, but udc->eps[] is allocated with udc->max_ep entries (typically
> 8-16 depending on the hardware).
> 
> The SET/CLEAR_FEATURE handler in the same function already checks
> 'pipe >= udc->max_ep' (line 1431) before indexing, but the GET_STATUS
> path omits this check, allowing an out-of-bounds access.
> 
> Add the same pipe >= max_ep guard to the GET_STATUS endpoint path,
> matching the existing check in the feature handler.
> 
> Fixes: b504882df105 ("USB: add Freescale high-speed USB SOC device controller driver")

Not a valid git id :(

