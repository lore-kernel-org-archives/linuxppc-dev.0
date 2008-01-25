Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D855DE328
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:34 +1100 (EST)
Date: Fri, 25 Jan 2008 22:18:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] [POWERPC] fsl_soc,
	legacy_serial: add support for "soc" compatible matching
Message-ID: <20080125191815.GA22717@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154010.GE23246@localhost.localdomain>
	<9C11FC54-29CF-4027-97C3-FEB1EBA2D78B@kernel.crashing.org>
	<20080125171355.GA9879@localhost.localdomain>
	<479A27AF.5080701@freescale.com>
	<20080125185341.GA13450@localhost.localdomain>
	<479A3280.5070401@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <479A3280.5070401@freescale.com>
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

On Fri, Jan 25, 2008 at 01:03:28PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >$ grep qe@ arch/powerpc/boot/dts/*
> >arch/powerpc/boot/dts/mpc832x_mds.dts:  qe@e0100000 {
> >arch/powerpc/boot/dts/mpc832x_rdb.dts:  qe@e0100000 {
> >arch/powerpc/boot/dts/mpc836x_mds.dts:  qe@e0100000 {
> >arch/powerpc/boot/dts/mpc8568mds.dts:   qe@e0080000 {
> >
> >^^^ if the practice is wrong, then we should fix it, and then
> >-immr would be the good name indeed (just as I've said previously).
> 
> It's wrong, and we should fix it.

Ok, good. I'll fix that for at least new RDK board. Though, fixing
other boards would be not trivial because of backward compatibility
and such. I'll also use -immr for RDK.

> It would make sense if the QE block 
> were relocatable separately from IMMR (but even if it were, the QE 
> compatible should be fsl,xxxx-qe or similar, so no conflict with 
> fsl,xxxx-immr) -- but it isn't, at least on the 8323 and 8360 (I don't 
> have an 8568 manual handy).

Nobody have an MPC8568E manual handy. :-P I've just looked there..
no QE isn't relocatable.

Oh, and I lied regarding CPM being relocatable. It isn't,
at least CPM2 and at least on MPC8555E. What a pity.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
