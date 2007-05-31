Return-Path: <shemminger@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [207.189.120.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B410DE016
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 02:48:38 +1000 (EST)
Date: Thu, 31 May 2007 09:37:03 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 2/2] ehea: Receive SKB Aggregation
Message-ID: <20070531093703.373995b2@freepuppy>
In-Reply-To: <200705311354.56979.osstklei@de.ibm.com>
References: <200705311354.56979.osstklei@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Stefan,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Roscher <ossrosch@linux.vnet.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
>  
> +static int try_get_ip_tcp_hdr(struct ehea_cqe *cqe, struct sk_buff *skb,
> +			      struct iphdr **iph, struct tcphdr **tcph)
> +{
> +	int ip_len;
> +
> +	/* non tcp/udp packets */
> +	if (!cqe->header_length)
> +		return -1;
> +
> +	/* non tcp packet */
> +	*iph = (struct iphdr *)(skb->data);

Why the indirection, copying of headers..

> +	if ((*iph)->protocol != IPPROTO_TCP)
> +		return -1;
> +
> +	ip_len = (u8)((*iph)->ihl);
> +	ip_len <<= 2;
> +	*tcph = (struct tcphdr *)(((u64)*iph) + ip_len);
> +
> +	return 0;
> +}
> +
> 

This code seems to be duplicating a lot  (but not all) of the TCP/IP
input path validation checks. This is a security problem if nothing else...

Also, how do you prevent DoS attacks from hostile TCP senders that send
huge number of back to back frames?

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
