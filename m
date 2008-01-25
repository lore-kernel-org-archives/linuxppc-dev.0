Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0CE4BDDE42
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:13:14 +1100 (EST)
Date: Fri, 25 Jan 2008 21:53:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Message-ID: <20080125185341.GA13450@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
	<20080125171355.GA9879@localhost.localdomain>
	<479A27AF.5080701@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <479A27AF.5080701@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 12:17:19PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >Freescale soc register space: "fsl,soc"
> >generic soc device: "soc" (or maybe "linux,soc" better?)
> >
> >I know, Scott Wood is pushing "xxxx-immr" thing forward... but
> >I don't like that name because SOC isn't only device with the
> >Internal Memory Mapped Registers. 
> 
> If you look in the manual for xxxx, you'll find something called 
> "Internal Memory Mapped Registers".  Thus, the name xxxx-immr.

Theory.

> >(Think of QE placed outside of "soc"/"immr" node).
> 
> When is the QE ever placed outside the soc/immr/ccsr node?
> The QE registers are part of the IMMR/CCSR.

Practice.

$ grep qe@ arch/powerpc/boot/dts/*
arch/powerpc/boot/dts/mpc832x_mds.dts:  qe@e0100000 {
arch/powerpc/boot/dts/mpc832x_rdb.dts:  qe@e0100000 {
arch/powerpc/boot/dts/mpc836x_mds.dts:  qe@e0100000 {
arch/powerpc/boot/dts/mpc8568mds.dts:   qe@e0080000 {

^^^ if the practice is wrong, then we should fix it, and then
-immr would be the good name indeed (just as I've said previously).

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
