Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E2C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:37:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4604F20813
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="20951c/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4604F20813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fgZk2p18zF1Cr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 04:37:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="20951c/k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="20951c/k"; 
 dkim-atps=neutral
X-Greylist: delayed 1574 seconds by postgrey-1.36 at bilbo;
 Wed, 24 Oct 2018 04:35:20 AEDT
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fgWr1MSWzDrNS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 04:35:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=2bIrNvKh7bjquz0DJ1T5Mr69pIZHirhTC+mxsRFsqP0=; 
 b=20951c/kj0IIn1B1uR8TXeUNluUYpe0874G2iVSalMYN3G/bXnbln/1di7zWaWxthc346JuTgEEIjnOjApDsydabUrpywTxXMXFCOq+5sPVckQiXfhKv9Q+DOOTZztmjrykmjibem1ZijIXuPpSqptvpjG2vb2LDkZ5p2WGi8/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gF0Ao-00087F-Vk; Tue, 23 Oct 2018 19:08:54 +0200
Date: Tue, 23 Oct 2018 19:08:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: ethernet "bus" number in DTS ?
Message-ID: <20181023170854.GW26497@lunn.ch>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 23, 2018 at 04:49:59PM +0000, Joakim Tjernlund wrote:
> SPI (and others) has a way to define bus number in a aliases:
> 	aliases {
> 		ethernet4 = &enet4;
> 		ethernet0 = &enet0;
> 		ethernet1 = &enet1;
> 		ethernet2 = &enet2;
> 		ethernet3 = &enet3;
> 		spi0 = &spi0
> 	};
> The 0 in the spi0 alias will translate to bus num 0 so one can control the /dev nodes, like /dev/spidev0
> I am looking for the same for ethernet devices:
>  ethernet4 = &enet4;  /* should become eth4 */
>  ethernet0 = &enet0;  /* should become eth0 */
> but I cannot find something like that for eth devices.
> 
> Could such functionality be added?

Hi Jocke

This has been discussed before. Take a look at
arch/arm/boot/dts/armada-38x.dtsi

                        /*
                         * As a special exception to the "order by
                         * register address" rule, the eth0 node is
                         * placed here to ensure that it gets
                         * registered as the first interface, since
                         * the network subsystem doesn't allow naming
                         * interfaces using DT aliases. Without this,
                         * the ordering of interfaces is different
                         * from the one used in U-Boot and the
                         * labeling of interfaces on the boards, which
                         * is very confusing for users.
                         */

You should be able to find the discuss about this, and why aliases
cannot be used.

       Andrew
