Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0045ADDFAE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:23:00 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200806051045.42966.sr@denx.de>
References: <200806041706.21557.sr@denx.de> <200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<200806051045.42966.sr@denx.de>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:17:37 +1000
Message-Id: <1212725857.12464.16.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 10:45 +0200, Stefan Roese wrote:
> Full ack from me. So I suggest to use "cell-index" if available and
> otherwise 
> use an incremented number, same as the FSL i2c driver does now:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
> 
> If nobody objects I'll send a patch to add the cell-index to all 4xx
> dts files 
> in a short while.

No, don't use cell-index. If you have a setup with 2 SOCs in
SMP or something like the Axon bridge on cell where you can have
multiple Axons in a system, cell-index will not be unique. They
will give you the index -within-a-chip- as it is used, as I
said in a separate mail, for things like power or clock control
bits & pieces. It will not be system-wide unique.

Ben.
