Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7BB43DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 20:29:36 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1S9TSdt094788
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:29:28 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1S9TSEd1437870
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:29:28 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1S9TRgH001817
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 09:29:28 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 2/2] ehea: NAPI multi queue TX/RX path for SMP
Date: Wed, 28 Feb 2007 10:23:16 +0100
References: <200702271732.51829.ossthema@de.ibm.com>
	<45E46208.3000003@trash.net>
In-Reply-To: <45E46208.3000003@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702281023.17591.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> >  
> > +static inline int ehea_hash_skb(struct sk_buff *skb, int num_qps)
> > +{
> > +	u32 tmp;
> > +	if ((skb->nh.iph->protocol == IPPROTO_TCP)
> > +	    && skb->protocol == ETH_P_IP) {
> 
> skb->protocol has network byte order. The ETH_P_IP test should also
> logically come before checking the IP protocol.
> 

fixed.

> > +		tmp = (skb->h.th->source + (skb->h.th->dest << 16)) % 31;
> 
> Only locally generated packets have a valid h.th pointer.
> 
good point. I'll fix that.

I'll send a new patch set later today

Thanks,
Jan-Bernd
