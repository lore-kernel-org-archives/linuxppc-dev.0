Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7713DDE3F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 22:42:55 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l54CgoLE437500
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 12:42:50 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l54Cgn9H3776576
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 14:42:49 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l54CgjxR024776
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 14:42:45 +0200
In-Reply-To: <20070531093703.373995b2@freepuppy>
Subject: Re: [PATCH 2/2] ehea: Receive SKB Aggregation
To: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <OF83D042D3.CAC47E54-ONC12572F0.0041526E-C12572F0.0042A414@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 4 Jun 2007 14:09:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Stephen Hemminger  wrote on 31.05.2007 18:37:03:

>
> >
> >
> > +static int try_get_ip_tcp_hdr(struct ehea_cqe *cqe, struct sk_buff
*skb,
> > +               struct iphdr **iph, struct tcphdr **tcph)
> > +{
> > +   int ip_len;
> > +
> > +   /* non tcp/udp packets */
> > +   if (!cqe->header_length)
> > +      return -1;
> > +
> > +   /* non tcp packet */
> > +   *iph = (struct iphdr *)(skb->data);
>
> Why the indirection, copying of headers..
This interacts with the header split function in the hardware.
>
> > +   if ((*iph)->protocol != IPPROTO_TCP)
> > +      return -1;
> > +
> > +   ip_len = (u8)((*iph)->ihl);
> > +   ip_len <<= 2;
> > +   *tcph = (struct tcphdr *)(((u64)*iph) + ip_len);
> > +
> > +   return 0;
> > +}
> > +
> >
>
> This code seems to be duplicating a lot  (but not all) of the TCP/IP
> input path validation checks. This is a security problem if nothing
else...
>
We should only do aggregation in the driver if this really is a TCP header,
otherwise things will get worse.
You're right, we should at least check that tcph is within the received
frame.

> Also, how do you prevent DoS attacks from hostile TCP senders that send
> huge number of back to back frames?

Actually a huge number of back to back frames is what we would want to
receive
at 10 gbit ;-)
How is it possible to figure out if this is what you want or just DoS?
It doesn't change anything compared to a non LRO driver, we process a
certain
maximum amount of frames before waiting for the next interrupt,
the packet filters/DoS should still see all traffic (which is above the
driver).
Any suggestions how to handle this better/different?

>
> --
> Stephen Hemminger

Gruss / Regards
Christoph Raisch
