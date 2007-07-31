Return-Path: <Leonid.Grossman@neterion.com>
Received: from owa.neterion.com (mx.neterion.com [72.1.205.142])
	by ozlabs.org (Postfix) with ESMTP id 7A394DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 14:08:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
Date: Mon, 30 Jul 2007 23:58:07 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD7701F7A5DB@nekter>
In-Reply-To: <46AE232F.3080409@myri.com>
References: <200707301724.33865.ossthema@de.ibm.com>
	<20070730170038.GA4884@austin.ibm.com> <46AE232F.3080409@myri.com>
From: "Leonid Grossman" <Leonid.Grossman@neterion.com>
To: "Andrew Gallatin" <gallatin@myri.com>,
	"Linas Vepstas" <linas@austin.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Andrew Gallatin
> Sent: Monday, July 30, 2007 10:43 AM
> To: Linas Vepstas
> Cc: Jan-Bernd Themann; netdev; Thomas Klein; Jeff Garzik; Jan-Bernd
> Themann; linux-kernel; linux-ppc; Christoph Raisch; Marcus Eder;
Stefan
> Roscher; David Miller
> Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for
> TCP traffic
>=20
>=20
> Here is a quick reply before something more official can
> be written up:
>=20
> Linas Vepstas wrote:
>=20
>  > -- what is LRO?
>=20
> Large Receive Offload
>=20
>  > -- Basic principles of operation?
>=20
> LRO is analogous to a receive side version of TSO.  The NIC (or
> driver) merges several consecutive segments from the same connection,
> fixing up checksums, etc.  Rather than up to 45 separate 1500 byte
> frames (meaning up to 45 trips through the network stack), the driver
> merges them into one 65212 byte frame.  It currently works only
> with TCP over IPv4.
>=20
> LRO was, AFAIK, first though of by Neterion.  They had a paper about
> it at OLS2005.
> http://www.linuxinsight.com/files/ols2005/grossman-reprint.pdf
>=20
>  > -- Can I use it in my driver?
>=20
> Yes, it can be used in any driver.
>=20
>  > -- Does my hardware have to have some special feature before I can
> use it?
>=20
> No.

Ditto. LRO hw assists (or full LRO offload, meaning that the merge
happens in the ASIC but the merge criteria are set by the host) are
quite beneficial, especially as the number of LRO connections gets very
large (Neterion has IP around fw/hw LRO and will release full hw LRO
offload in the next ASIC), but as Andrew indicated sw-only LRO
implementation can be done for any NIC and provides good results -
especially for non-jumbo workloads.=20

>=20
>  > -- What sort of performance improvement does it provide?
Throughput?
>  >    Latency? CPU usage? How does it affect DMA allocation? Does it
>  >    improve only a certain type of traffic (large/small packets,
> etc.)
>=20
> The benefit is directly proportional to the packet rate.
>=20
> See my reply to the previous RFC for performance information.  The
> executive summary is that for the myri10ge 10GbE driver on low end
> hardware with 1500b frames, I've seen it increase throughput by a
> factor of nearly 2.5x, while at the same time reducing CPU utilization
> by 17%.  The affect for jumbo frames is less dramatic, but still
> impressive (1.10x, 14% CPU reduction)
>=20
> You can achieve better speedups if your driver receives into
> high-order pages.
>=20
>  > -- Example code? What's the API? How should my driver use it?
>=20
> The 3/4 in this patch showed an example of converting a driver
> to use LRO for skb based receive buffers.   I'm working on
> a patch for myri10ge that shows how you would use it in a driver
> which receives into pages.
>=20
> Cheers,
>=20
> Drew
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
