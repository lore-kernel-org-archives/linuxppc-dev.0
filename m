Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0385DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 11:51:00 +1100 (EST)
Message-ID: <479A3280.5070401@freescale.com>
Date: Fri, 25 Jan 2008 13:03:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc, legacy_serial: add support for
	"soc" compatible matching
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
	<20080125171355.GA9879@localhost.localdomain>
	<479A27AF.5080701@freescale.com>
	<20080125185341.GA13450@localhost.localdomain>
In-Reply-To: <20080125185341.GA13450@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> $ grep qe@ arch/powerpc/boot/dts/*
> arch/powerpc/boot/dts/mpc832x_mds.dts:  qe@e0100000 {
> arch/powerpc/boot/dts/mpc832x_rdb.dts:  qe@e0100000 {
> arch/powerpc/boot/dts/mpc836x_mds.dts:  qe@e0100000 {
> arch/powerpc/boot/dts/mpc8568mds.dts:   qe@e0080000 {
> 
> ^^^ if the practice is wrong, then we should fix it, and then
> -immr would be the good name indeed (just as I've said previously).

It's wrong, and we should fix it.  It would make sense if the QE block 
were relocatable separately from IMMR (but even if it were, the QE 
compatible should be fsl,xxxx-qe or similar, so no conflict with 
fsl,xxxx-immr) -- but it isn't, at least on the 8323 and 8360 (I don't 
have an 8568 manual handy).

-Scott
