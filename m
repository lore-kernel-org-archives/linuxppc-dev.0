Return-Path: <SRS0=J0gu=EM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858DEC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:56:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F42520B80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOqu7iq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSG515g5kzDrJl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 20:56:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=iOqu7iq8; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSG2y1BBnzDrH8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2020 20:55:05 +1100 (AEDT)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E42C721734;
 Fri,  6 Nov 2020 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604656503;
 bh=fq0Ui8t6PiSDl63PaQnqQ+wD7V5/mQ8ZBFhNNG3yCok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iOqu7iq8fkqhQinW+HWeXRONm4gVqP0ORpaGzDUMT9zotN8/ZoAt8k4smbdnLkRfA
 gQF4QwYnBsQf3JTygZryT4dYi6nYvqpqKGLuqzS6PEjkhnobvGexT83gHte/RclSzw
 WjuqDzk0ase4qrOZuSmZgJVWNdu/bBS1goiCMzjw=
Date: Fri, 6 Nov 2020 10:54:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/36] Rid W=1 issues from TTY
Message-ID: <20201106095450.GA2660312@kroah.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
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
Cc: Robert Love <rlove@google.com>, Nick Holloway <alfie@dcs.warwick.ac.uk>,
 Russ Gorby <russ.gorby@intel.com>, Kevin Wells <kevin.wells@nxp.com>,
 -- <julian@uhunix.uhcc.hawaii.edu>, Andrew Morton <andrewm@uow.edu.eu>,
 Laxman Dewangan <ldewangan@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 "David A. Hinds" <dahinds@users.sourceforge.net>,
 linux-riscv@lists.infradead.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, Bill Hawes <whawes@star.net>,
 Roland Stigge <stigge@antcom.de>, Rob Herring <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jan Dumon <j.dumon@option.com>,
 Andy Gross <agross@kernel.org>, linux-serial@vger.kernel.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Gerald Baeza <gerald.baeza@st.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Marko Kohtala <Marko.Kohtala@hut.fi>,
 linux-media@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-msm@vger.kernel.org,
 Vladimir Zapolskiy <vz@mleia.com>, linaro-mm-sig@lists.linaro.org,
 Stanislav Voronyi <stas@cnti.uanet.kharkov.ua>,
 "C. Scott Ananian" <cananian@alumni.princeton.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-tegra@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
 processes-Sapan Bhatia <sapan@corewars.org>, Miloslav Trmac <mitr@redhat.com>,
 Mike Hudson <Exoray@isys.ca>, Joseph Barrow <d.barow@option.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 paulkf@microgate.com, Filip Aben <f.aben@option.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Jelinek <jj@ultra.linux.cz>,
 linuxppc-dev@lists.ozlabs.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Russell King <rmk@arm.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 04, 2020 at 07:35:13PM +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Many of these now applied, please update the series against my
tty-testing branch and resend the rest.

thanks,

greg k-h
