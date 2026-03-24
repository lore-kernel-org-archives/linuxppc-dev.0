Return-Path: <linuxppc-dev+bounces-18711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B391F532EC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 08:10:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fg2lC5MG6z3cgy;
	Tue, 24 Mar 2026 19:09:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774339799;
	cv=none; b=WVN6XacneahHFpCPeP/aB8oVrHYJghEe/cbsTviXq5hIZBdRdb5fNG9zQi2OONjiEDOlnT+myZimGgPoo84SDJpgD5jVein0nD2TsJjsPi9gUU92oa/kZ6ROnJtlIMZVWQ1zB2LeLk/SbJUSNJpUEhzKYRcba8YyIzaGzv35+dMQA10m0Bz4RjPAxc5qhlytBT83dBjM4zZuenrOdILUGrTX9LaqxqA6YMSBbAnOfApUyX7J3YX0uR3Sqso0Xhilt3sMWslLGsYu8ak+lOOEzXAQyGnQLISqi0Yz0Aahd8wimpbCNuGRDY76VHHT+IWnBXVc5E1ui93XvWSjXhhrog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774339799; c=relaxed/relaxed;
	bh=cWnoCSv8w8q7/YUh5T2kDAJaf06iTTxggP6FxI8TNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCeAbu+jlk+7vuJRWJPO8lH1d8HnRDay3H9MOTy41qE5akbRo0WknvtPmy6jaI0BJSkmRm9bqlvFSiMJWZzceaLcpVFgyTj4dNlKte4B691obOFFw3AunC9c3XS6OtJJe4TLadLQymKU6YG/3Zh4oWjlDK/2/+uWnGnIUDgnpgZyJ1ZR22BUwFiH4/hZ8963xad3cUSXATiz1g5ZDcGMhhM8nDvr10wJTkJwzcejApNK+lrqzLpq9TCwQ0Jh/063jFda8ZkbGn8lpesDg74fbQok+OyHylcD4qb2glGzgYNMYhJUDw50wSyhnWzAcfif6dnlO6AnUXHrkV232RbXQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0L8IR6Pk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0L8IR6Pk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fg2lB6twMz3cJy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 19:09:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BAB3600C4;
	Tue, 24 Mar 2026 08:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B8C19424;
	Tue, 24 Mar 2026 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774339795;
	bh=IKKPJZ+MZDaoxP4vPPsLme6gW/n7DEGEiTEMcgMuYp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0L8IR6Pk68bAp9++dR6ItzOnWZf2MgvBLl2UV5zaHXNUbsVb9RAc04NnLuD2YNf+G
	 GmqZcQvouuvrdE0xPt4YHI6OTcY19NxN8kIn1pWJKzLM1zFnqP+nevgcl7t5hQ7vTE
	 9EDRgh/2RJsqQNRl7woh8a9xc4H6xKdllWSA+5ec=
Date: Tue, 24 Mar 2026 09:09:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/12] driver core: remove driver_set_override()
Message-ID: <2026032412-finally-lubricant-7fe2@gregkh>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-13-dakr@kernel.org>
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
In-Reply-To: <20260324005919.2408620-13-dakr@kernel.org>

On Tue, Mar 24, 2026 at 01:59:16AM +0100, Danilo Krummrich wrote:
> All buses have been converted from driver_set_override() to the generic
> driver_override infrastructure introduced in commit cb3d1049f4ea
> ("driver core: generalize driver_override in struct device").
> 
> Buses now either opt into the generic sysfs callbacks via the
> bus_type::driver_override flag, or use device_set_driver_override() /
> __device_set_driver_override() directly.
> 
> Thus, remove the now-unused driver_set_override() helper.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/base/driver.c         | 75 -----------------------------------
>  include/linux/device/driver.h |  2 -
>  2 files changed, 77 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

