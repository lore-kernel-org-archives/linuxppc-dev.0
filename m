Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E24DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Apr 2022 21:29:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KdJlh0D7Sz3bZN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Apr 2022 07:29:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GaLCgYlH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GaLCgYlH; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KdJkz6Qm1z2ymb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2022 07:29:15 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0C39BB82051;
 Tue, 12 Apr 2022 21:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B9CC385A5;
 Tue, 12 Apr 2022 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649798949;
 bh=kpS0EcU/RLQzTaKo85ZEC/dgBcrpXX2fe+n6wE10HoY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GaLCgYlHxpFu6dokBt6GCrmgjotR4ofYQfGcSFBOLeVJbLpcwYNstaIrRFFIghgom
 d4/BYVT4yedX7dhBWKTquSxLJru2kufnM1pSd6adoQdHT5dspvAHMXGF+D7LBSbyGy
 uqwHRxFNdMWVDYxR0VfF+2gKqAXrxjAQgzuLbxkHXicMZ4BZiA4YlOWRDTjH9tpsz+
 lFMd8q2AcF3LrzmBQ/fhVQi3g0E+SpAYkcw2R0hXBqNrKSdDI4R0a0zA/04HGUFz7K
 uaJaecV/iiyppRN+sMAt+0yP/ErIwQTkaBGZvf6wgKDX4lLyfLcopor9Ly3uCGIfYU
 NpNRnUyxLeliQ==
Date: Tue, 12 Apr 2022 14:29:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakob Koschel <jakobkoschel@gmail.com>
Subject: Re: [PATCH net-next v3 14/18] sfc: Remove usage of list iterator
 for list_add() after the loop body
Message-ID: <20220412142905.54489567@kernel.org>
In-Reply-To: <20220412121557.3553555-15-jakobkoschel@gmail.com>
References: <20220412121557.3553555-1-jakobkoschel@gmail.com>
 <20220412121557.3553555-15-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Andrew Lunn <andrew@lunn.ch>, Song Liu <songliubraving@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paul Mackerras <paulus@samba.org>, Ariel Elior <aelior@marvell.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 "Bos, H.J." <h.j.bos@vu.nl>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-arm-kernel@lists.infradead.org, Martin Habets <habetsm.xilinx@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>,
 Bjarni Jonasson <bjarni.jonasson@microchip.com>, Jiri Pirko <jiri@resnulli.us>,
 Arnd Bergmann <arnd@arndb.de>, Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yonghong Song <yhs@fb.com>,
 Di Zhu <zhudi21@huawei.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Colin Ian King <colin.king@intel.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com, Edward Cree <ecree.xilinx@gmail.com>,
 Michael Walle <michael@walle.cc>, Casper Andersson <casper.casan@gmail.com>,
 Xu Wang <vulab@iscas.ac.cn>, Cristiano Giuffrida <c.giuffrida@vu.nl>,
 bpf@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Martin KaFai Lau <kafai@fb.com>,
 Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 12 Apr 2022 14:15:53 +0200 Jakob Koschel wrote:
> -	struct list_head *head = &efx->rss_context.list;
> +	struct list_head *head = *pos = &efx->rss_context.list;

ENOTBUILT, please wait with the reposting. Since you posted two
versions today I guess that's 2x 24h? :)
