Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0080.outbound.protection.outlook.com [104.47.1.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCJZK59szzDvJb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 03:59:20 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>, "ppc@mindchasers.com"
 <ppc@mindchasers.com>, "joe@perches.com" <joe@perches.com>,
 "pebolle@tiscali.nl" <pebolle@tiscali.nl>
Subject: RE: [PATCH net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Mon, 7 Nov 2016 16:59:14 +0000
Message-ID: <AM4PR04MB16042515F3D8DD0EF54219A9ECA70@AM4PR04MB1604.eurprd04.prod.outlook.com>
References: <AM4PR04MB16049FF6E433DA445828A855ECA70@AM4PR04MB1604.eurprd04.prod.outlook.com>
 <20161107.105500.43380129278294700.davem@davemloft.net>
 <AM4PR04MB1604B2393D5CE6607204800EECA70@AM4PR04MB1604.eurprd04.prod.outlook.com>
 <20161107.113941.669208733868640796.davem@davemloft.net>
In-Reply-To: <20161107.113941.669208733868640796.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, November 07, 2016 6:40 PM
>=20
> From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
> Date: Mon, 7 Nov 2016 16:32:16 +0000
>=20
> >> From: David Miller [mailto:davem@davemloft.net]
> >> Sent: Monday, November 07, 2016 5:55 PM
> >>
> >> From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
> >> Date: Mon, 7 Nov 2016 15:43:26 +0000
> >>
> >> >> From: David Miller [mailto:davem@davemloft.net]
> >> >> Sent: Thursday, November 03, 2016 9:58 PM
> >> >>
> >> >> Why?  By clearing this, you disallow an important fundamental way t=
o
> >> >> do performane testing, via pktgen.
> >> >
> >> > The Tx path in DPAA requires one to insert a back-pointer to the skb
> >> > into
> >> > the Tx buffer. On the Tx confirmation path the back-pointer in the
> >> > buffer
> >> > is used to release the skb. If Tx buffer is shared we'd alter the
> >> > back-pointer
> >> > and leak/double free skbs. See also
> >>
> >> Then have your software state store an array of SKB pointers, one for
> each
> >> TX ring entry, just like every other driver does.
> >
> > There is no Tx ring in DPAA. Frames are send out on QMan HW queues
> > towards the FMan for Tx and then received back on Tx confirmation queue=
s
> > for cleanup.
> > Array traversal would for sure cost more than using the back-pointer.
> > Also, we can now process confirmations on a different core than the one
> > doing Tx,
> > we'd have to keep the arrays percpu and force the Tx conf on the same
> > core. Or add locks.
>=20
> Report back an integer index, like every scsi driver out there which
> completes tagged queued block I/O operations asynchronously.  You can
> associate the array with a specific TX confirmation queue.

>From HW? It only gives you back the buffer start address (plus length, etc)=
.
"buff_2_skb()" needs to be solved in SW, expensively using array (lists? As
the number of frames in flight can be large/variable) or cheaply with the b=
ack
pointer. The back-pointer approach has its tradeoffs: no shared skbs, impos=
ed
non-zero needed_headroom.
