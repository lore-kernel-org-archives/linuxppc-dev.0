Return-Path: <linuxppc-dev+bounces-3244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AB5D6DDEC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2024 09:12:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqWWX46Jzz2yPS;
	Fri, 15 Nov 2024 20:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ef0:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731661960;
	cv=none; b=f+RVNXhtCJuzC7qVRPuC1Scl4kYJhsx8TSg1IRRwxRu6iuGlgTqiphPqu4Jk3CrNxpfDgiT4q3hwIZ2zNaPyXluTRDnguTB+oZ/320yKOrSggRc4+sFTnr4okFj0ZQ6Mf1GgGGxF1F3jRD5p2F56i9JieTb4atrsiCmvhzLid6q/KTTzkvFOdKy9KXWsaR3asRAu9M1FJe3qHBWd73HY3Vfd3Jr5P94gaoaYfxdVJ9aZqqnzrTHbae+0PZBwASip8touMV4YrJX4nivDXtlj2WQBtr/2O8ixiVltFROFvQcjZpFLSPLt2mUzUX3y8myLowwhnVIetWiKaPe6PMpwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731661960; c=relaxed/relaxed;
	bh=Stjtz6qDnjiC1mkqCjFO1YM17Ev0itGJ8CXdx1KVwAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO+4QW+E1+qjU4GpKu013rVQZ5cg1OH9/Wrm53tvLC7zwuW+DG0JwndxYwzZhKnctzuidb+uyfVedD90g1gYVajxnbqBL4n0CC7GZ1n4DTHei8HDzUQI5Kq2JtgHPHl5uNIABDJy9HwbsnTAmLxhDiBpDGnEl+Hy9pchR/72YfPutHxe/mUCVCjlsJcBbi/0WKK81R3Nxbd45bvWSUSvPj8vDWbOQdchmbw57vNH8vsvMetJ2lEdfhP78VF2GL+Fl5x1HYFNomxEhCDcHE9V0XdzXD2ramBcFFM1u+IURh3alluezIbikLRK6plBEV5kZhZqOvXTSX5byiWSbavViw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout2.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout2.hostsharing.net (client-ip=2a01:37:3000::53df:4ef0:0; helo=bmailout2.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 328 seconds by postgrey-1.37 at boromir; Fri, 15 Nov 2024 20:12:38 AEDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqWWV0gXkz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2024 20:12:38 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1EF162800C917;
	Fri, 15 Nov 2024 10:06:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0844E3641AA; Fri, 15 Nov 2024 10:06:59 +0100 (CET)
Date: Fri, 15 Nov 2024 10:06:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 2/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
Message-ID: <ZzcPMxWqtvDWh3cq@wunner.de>
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-3-xueshuai@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112135419.59491-3-xueshuai@linux.alibaba.com>

On Tue, Nov 12, 2024 at 09:54:19PM +0800, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable.

It would be good if you could mention the relevant commit here:

9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors")

Thanks,

Lukas

