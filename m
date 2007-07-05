Return-Path: <ossthema@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B4AFDDF2B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 00:49:49 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l65Enj3J945130
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 14:49:45 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l65Enjg32072678
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 16:49:45 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l65Enixv012715
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jul 2007 16:49:45 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/2] eHEA: Receive SKB Aggregation,
	generic LRO helper functions
Date: Thu, 5 Jul 2007 16:24:46 +0200
References: <200707050926.30468.ossthema@de.ibm.com>
	<20070705082056.GA358@2ka.mipt.ru>
In-Reply-To: <20070705082056.GA358@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Message-Id: <200707051624.46887.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, 

thanks for your comment. 

Jan-Bernd

On Thursday 05 July 2007 10:20, you wrote:
> Hi Jan-Bernd.
> 
> [ Dropped spambot/i.e. unrelated mail lists ]
> 
> On Thu, Jul 05, 2007 at 09:26:30AM +0200, Jan-Bernd Themann (ossthema@de.ibm.com) wrote:
> > This patch enables the receive side processing to aggregate TCP packets within
> > the HEA device driver. It analyses the packets already received after an
> > interrupt arrived and forwards these as chains of SKBs for the same TCP
> > connection with modified header field. We have seen a lower CPU load and
> > improved throughput for small numbers of parallel TCP connections.
> > As this feature is considered as experimental it is switched off by default
> > and can be activated via a module parameter.
> 
> I've couple of comments on the driver, but mainly the fact of decreased
> CPU usage itself - what was the magnitude of the win with this driver,
> it looks like because of per-packet receive code path invocation is the
> place of the latency...
> Your implementation looks generic enough to be used by any driver, don't
> you want to push it separately from eHEA driver?
> 

We can try to come up with a generic file with these helperfunctions.
What do you think about putting them into /net/ipv4/inet_lro.c and 
/include/linux/inet_lro.h ?

Latency: We didn't measure it so far, but it leads to a significant improvement
concerning the throughput. Our LRO algorithm only handles X packets a time
(depends on MTU and budget), so the upper bound delay is X*processing a single
packet from driver perspective. 

> 
> > +static int lro_tcp_check(struct iphdr *iph, struct tcphdr *tcph,
> > +			 int tcp_data_len, struct ehea_lro *lro)
> > +{
> > +	if (tcp_data_len == 0)
> > +		return -1;
> > +
> > +	if (iph->ihl != IPH_LEN_WO_OPTIONS)
> > +		return -1;
> > +
> > +	if (tcph->cwr || tcph->ece || tcph->urg || !tcph->ack || tcph->psh
> > +	    || tcph->rst || tcph->syn || tcph->fin)
> > +		return -1;
> > +
> > +	if (INET_ECN_is_ce(ipv4_get_dsfield(iph)))
> > +		return -1;
> > +
> > +	if (tcph->doff != TCPH_LEN_WO_OPTIONS
> > +	    && tcph->doff != TCPH_LEN_W_TIMESTAMP)
> > +		return -1;
> > +
> > +	/* check tcp options (only timestamp allowed) */
> > +	if (tcph->doff == TCPH_LEN_W_TIMESTAMP) {
> > +		u32 *topt = (u32 *)(tcph + 1);
> > +
> > +		if (*topt != htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16)
> > +				   | (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP))
> > +			return -1;
> > +
> > +		/* timestamp should be in right order */
> > +		topt++;
> > +		if (lro && (ntohl(lro->tcp_rcv_tsval) > ntohl(*topt)))
> > +			return -1;
> 
> This should use before/after technique like PAWS in TCP code or there will be a
> problem with wrapper timestamps.
> 

good point, will look into this

> > +
> > +		/* timestamp reply should not be zero */
> > +		topt++;
> > +		if (*topt == 0)
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void update_tcp_ip_header(struct ehea_lro *lro)
> > +{
> > +	struct iphdr *iph = lro->iph;
> > +	struct tcphdr *tcph = lro->tcph;
> > +	u32 *p;
> > +
> > +	tcph->ack_seq = lro->tcp_ack;
> > +	tcph->window = lro->tcp_window;
> > +
> > +	if (lro->tcp_saw_tstamp) {
> > +		p = (u32 *)(tcph + 1);
> > +		*(p+2) = lro->tcp_rcv_tsecr;
> > +	}
> > +
> > +	iph->tot_len = htons(lro->ip_tot_len);
> > +	iph->check = 0;
> > +	iph->check = ip_fast_csum((u8 *)lro->iph, iph->ihl);
> > +}
> > +
> > +static void init_lro_desc(struct ehea_lro *lro, struct ehea_cqe *cqe,
> > +			  struct sk_buff *skb, struct iphdr *iph,
> > +			  struct tcphdr *tcph, u32 tcp_data_len)
> > +{
> > +	u32 *ptr;
> > +
> > +	lro->parent = skb;
> > +	lro->iph = iph;
> > +	lro->tcph = tcph;
> > +	lro->tcp_next_seq = ntohl(tcph->seq) + tcp_data_len;
> > +	lro->tcp_ack = ntohl(tcph->ack_seq);
> 
> How do you handle misordering or duplicate acks or resends?
> 

we just forward these packets and leave it to the network stack to
handle them. As soon as we get a packet which does not match we
just flush the LRO session and the current packet 
(forward to stack as separate SKBs)

> > +	lro->skb_sg_cnt = 1;
> > +	lro->ip_tot_len = ntohs(iph->tot_len);
> > +
> > +	if (tcph->doff == 8) {
> > +		ptr = (u32 *)(tcph+1);
> > +		lro->tcp_saw_tstamp = 1;
> > +		lro->tcp_rcv_tsval = *(ptr+1);
> > +		lro->tcp_rcv_tsecr = *(ptr+2);
> > +	}
> > +
> > +	if (cqe->status & EHEA_CQE_VLAN_TAG_XTRACT) {
> > +		lro->vlan_packet = 1;
> > +		lro->vlan_tag = cqe->vlan_tag;
> > +	}
> > +
> > +	lro->active = 1;
> > +}
> 
