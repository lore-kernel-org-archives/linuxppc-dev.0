Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9AFFBB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 06:06:12 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id EFFB7DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 06:06:10 +1000 (EST)
Received: by yxe37 with SMTP id 37so3016460yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 13:06:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849D7ED46@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E849D7ED46@ex01.ads.ubidyne.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Jun 2009 14:05:49 -0600
Message-ID: <fa686aa40906251305x4c835064y811cda9a0c717d23@mail.gmail.com>
Subject: Re: Direct MII connection between MPC8313 and VIRTEX FPGA
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 25, 2009 at 9:11 AM, Frank
Prepelica<Frank.Prepelica@ubidyne.com> wrote:
> Hi all,
>
> we removed the ethernet PHYs (MARVELL) from our customized board (based on MPC8313ERDB) and
> connected the CPU Ethernet lines directly to a FPGA which is now emulating the PHY. But the ifconfig
> command cannot find that eth device anymore. Does the emulated PHY needs to provide MDIO
> information that the ETH device can be found again?

No, you just need to make sure that the Ethernet driver is able to
support fixed speed MII links without a PHY.  It's trivial to do, but
not all drivers support it.  Search for "current-speed" in
drivers/net/fec_mpc52xx.c for an example.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
