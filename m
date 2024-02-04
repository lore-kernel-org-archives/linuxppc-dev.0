Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45393C4828F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Feb 2024 14:39:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XRokyKIJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TSXG86fpYz3cS3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Feb 2024 01:39:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XRokyKIJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TSXFK38fhz3bnB
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2024 01:38:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5F86DCE0966;
	Sun,  4 Feb 2024 14:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1925AC433C7;
	Sun,  4 Feb 2024 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707057512;
	bh=nt/QMLw6lg1n1+RHbp6/VU6M7m38l4egTNOdCoMZaiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRokyKIJHDKNPPt+r8mNyoSlH/xAc/vrIvluI4CiVkz9WAwG1G6amr7yogFjuWBi8
	 9sIP571fk9+ecybV7YDSlZ7D5qutbEaL64pyThdUv1GKamQZ4lUkfBv1V4DZnJnmg1
	 +HXCX9CWd9/SNU8Vu8ysT7DNDHV3tyPg5fgi5He0=
Date: Sun, 4 Feb 2024 06:38:31 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH 0/4] powerpc: struct bus_type cleanup
Message-ID: <2024020426-abrasion-boozy-78d4@gregkh>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Feb 04, 2024 at 11:21:54AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
