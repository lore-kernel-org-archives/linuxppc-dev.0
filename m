Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 862CCB6F0F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jan 2010 14:42:35 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o043gVsh005275
	for <linuxppc-dev@ozlabs.org>; Sun, 3 Jan 2010 20:42:31 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o043lP40011153
	for <linuxppc-dev@ozlabs.org>; Sun, 3 Jan 2010 21:47:26 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: ucc_geth: Fix the wrong the Rx/Tx FIFO size
Date: Mon, 4 Jan 2010 11:42:30 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB120898BDC0E@zch01exm21.fsl.freescale.net>
In-Reply-To: <20091209230015.GA13654@oksana.dev.rtsoft.ru>
References: <1259309803-5474-1-git-send-email-daveliu@freescale.com>
	<20091209230015.GA13654@oksana.dev.rtsoft.ru>
From: "Liu Dave-R63238" <r63238@freescale.com>
To: "David Miller" <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, Nov 27, 2009 at 04:16:43PM +0800, Dave Liu wrote:
> > current the Rx/Tx FIFO size settings cause problem
> > when four UEC ethernets work simultaneously.
> >=20
> > eg: GETH1, UEM-J15, GETH2, UEC-J5 on 8569MDS board
> >=20
> >  $ ifconfig eth0 10.193.20.166
> >  $ ifconfig eth1 10.193.20.167
> >  $ ifconfig eth2 10.193.20.168
> >  then
> >  $ ifconfig eth3 10.193.20.169
> >=20
> > The fourth ethernet will cause all of interface broken,
> > you cann't ping successfully any more.
> > The patch fix this issue for MPC8569 Rev1.0 and Rev2.0
> >=20
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
>=20
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>=20
> Thanks Dave! I see that the new values actually match the QEIWRM
> spec (except UTFS... spec recommends 2048, but it also says that
> it might differ for different memory setups, though that's a
> separate issue).
>=20
> And FWIW, I did some quick netperf tests on MPC8360, and the
> patch doesn't cause any problems.

David,

How about this patch? Please consider to pick it up to your tree.

Thanks, Dave
