Return-Path: <fubar@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF5A51007F0
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 02:46:07 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5FGXMWm031527
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 12:33:22 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5FGk1YA067644
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 12:46:01 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5FGjp6S012181
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 10:45:52 -0600
From: Jay Vosburgh <fubar@us.ibm.com>
To: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Subject: Re: [PATCH 1/2] ehea: fix delayed packet processing
In-reply-to: <201006151735.17258.ossthema@de.ibm.com>
References: <201006151735.17258.ossthema@de.ibm.com>
Date: Tue, 15 Jun 2010 09:45:47 -0700
Message-ID: <6663.1276620347@death.nxdomain.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tklein@linux.ibm.com,
	Andre Detsch <adetsch@br.ibm.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jan-Bernd Themann <ossthema@de.ibm.com> wrote:

>In the eHEA poll function an rmb() is required. Without that some packets
>on the receive queue are not seen and thus delayed until the next interrupt
>is handled for the same receive queue.
>
>Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

	To add a bit of background, this could manifest during a netperf
TCP_RR or UDP_RR on an otherwise idle network.  TCP would occasionally
retransmit, but then both the original segment and the retransmission
would simultaneously appear at the receiver.  For UDP_RR, message sizes
in excess of the mtu would occasionally "lose" an IP fragment, and
eventually IP reassembly would time out.

	-J

Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>


>---
>Patch created against 2.6.35-rc3
>
> drivers/net/ehea/ehea_main.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
>index f547894..fd890fa 100644
>--- a/drivers/net/ehea/ehea_main.c
>+++ b/drivers/net/ehea/ehea_main.c
>@@ -867,6 +867,7 @@ static int ehea_poll(struct napi_struct *napi, int budget)
> 		ehea_reset_cq_ep(pr->send_cq);
> 		ehea_reset_cq_n1(pr->recv_cq);
> 		ehea_reset_cq_n1(pr->send_cq);
>+		rmb();
> 		cqe = ehea_poll_rq1(pr->qp, &wqe_index);
> 		cqe_skb = ehea_poll_cq(pr->send_cq);
>
>-- 
>1.7.0
>--
>To unsubscribe from this list: send the line "unsubscribe netdev" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
