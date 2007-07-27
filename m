Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81AEEDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 22:47:26 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6RClLsp147254
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 12:47:21 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6RClLa21392818
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 14:47:21 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6RClEW5009173
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 14:47:15 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Andrew Gallatin <gallatin@myri.com>
Subject: Re: [RFC 0/1] lro: Generic Large Receive Offload for TCP traffic
Date: Fri, 27 Jul 2007 14:18:48 +0200
References: <200707201741.45079.ossthema@de.ibm.com>
	<46A785C2.9090708@myri.com>
In-Reply-To: <46A785C2.9090708@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707271418.49781.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Drew,

thanks a lot for your good feedback. See comments below.
I'll try to provide an updated version next week. It would
be nice if you could post a patch for your driver once
we have addressed the issues you mentioned. Then we would
have the eHEA driver for the SKB interface, and your driver
for the "receive in pages" interface.

Thanks,
Jan-Bernd

On Wednesday 25 July 2007 19:17, Andrew Gallatin wrote:
> Code review / comments:
> ===================
> 
> 1) Checksum information for CHECKSUM_COMPLETE drivers.
> 
> Our NIC passes partial checksums to our driver.  In the current code,
> it seems impossible for page based CHECKSUM_COMPLETE drivers to behave
> correctly in the case of "rejected" frames.  Eg, there is no way
> to pass the partial checksum to the LRO module so that it gets
> set in the skb header and passed up the stack.
> 
> Further, there seems to be no (easy) way to use CHECKSUM_COMPLETE
> on an aggregated packet at LRO flush time.  By the time a packet
> is aggregated, the partial checksum from the first segment is
> out of date.
> 
> I think it would make sense to require that a CHECKSUM_COMPLETE style
> driver verify the checksum in its get_frag_header / get_skb_header
> callback.  This allows the LRO code to unconditionally set
> CHECKSUM_UNNECESSARY.

I agree

> 2) Non-accelerated VLAN tags
> 
> Our firmware currently does not do vlan tag insertion
> and removal.  This causes a problem in __lro_proc_segment()
> where the tcp and ip headers are setup to point into the
> newly created skb.  A frame containing an unstripped vlan
> tag will cause the headers to be garbage.
> 
> The attached patch modifies __lro_proc_segment() to offset
> those pointers by VLAN_HLEN when required.
> 

The modifications you propose are not sufficient to work with HW
which actually extracts the VLAN IDs but does not change the 
eth protocol. Thus we have to add an additional field in
lro_mgr indicating how to interpret the eth protocol regarding
the VLAN header.

> 3) Padded frames.
> 
> I may be missing something, but I don't see where you
> either strip padding from frames or reject padded frames.
> (see the pskb_trim_rcsum() in net/ipv4/ip_input.c:ip_rcv()
> 
I think I missed something :-) Will fix that.
In lro_tcp_ip_check we check for the "SKB aggregation interface"
the skb->len against ip->tot_len. This catches padded frames as
eth_type_trans(skb, dev) reduces the length of the SKB.
However, the possible VLAN header is not taken into account. 
And for the "receive in pages" interface a wrong length is passed
as argument as well. 

I'd suggest to reject padded frames for aggregation as we do now
(when bugs are fixed) and thus keep the code simple.
I guess that padded frames don't occur too often in high load 
situations. If we detect a real performance issue we can still
change that later.

> I did not add such a feature as I was confused about the intended
> use of len/true_size.
len: number of bytes received
true_size: used to fill the "truesize" field in the SKB. Thus this reflects
           the amount of memory that is actually used by that SKB. If you
           receive into pages und you have some space between packets, you
           should take this into account. Example: you use 1 page for each
           packet, then you pass 4096 as argument.

> 
> Also, trimming is a pain when dealing with pure frags (without a
> containing skb).  We have code in our out-of-kernel driver to deal
> with it which you are welcome to use.
> 
> 

> 4) LRO_MIN_PG_HLEN (== 80)
> 
> This confuses me.  Can you please explain what you're trying to do?
> Because of this, I kept getting crashes in the skb_pull() done by
> eth_type_trans() because I was passing segments which were 60 bytes
> and the skb->data_len of the skb constructed by lro_gen_skb() was -20.
> I added my own code to bump the length to a magic 80 bytes, and the
> panics disappeared.  This may cause data corruption because of
> #3 above!
Yes, I see the point... I'm not sure in how far there are any requirements
that a certain amount of data (header) for other types of traffic
has to be in the skb->data field and not in frags. Maybe someone
can comment on this?
I suggest to remove LRO_MIN_PG_HLEN for tcp/ip packets that are aggregated,
but should we use a minimal length for other traffic (depending on the
number of received bytes)? Is that necessary?

> 
> 5) NAPI/non-NAPI
> 
> The LRO code assumes the underlying driver uses NAPI, and calls
> netif_receive_skb() rather than netif_rx().  Perhaps there should be a
> field in the lro_mgr struct to specify napi / non-napi.
> 
Yes, if someone intends to use it without napi, we can add this.

> 6) The checks for when to stop aggregating and flush in
>     __lro_proc_{segment|skb} need some improvement.
> 
> The skb variant currently uses a pure count (max_aggr).  In order to
> keep the resulting aggregated frame below 64KB, the underlying driver
> computes max_aggr as 0xffff / MTU.  This reduces the effectiveness of
> LRO on mixed MTU networks.  Eg, this causes packets coming from a
> source with a 1500b MTU to be aggregated after 7 frames when using a
> 9000b MTU on the receiver, rather than after 43 frames.  As you can
> see from the differences in inet_lro's performance in the table
> above, this is a real problem.
> 
> I believe that a hybrid byte / max_aggr model should be used.  The
> __lro_proc_segment takes this approach.  Note that there is a subtle
> bug in that the maximum aggregated bytes should not be be 0xffff.
> Rather, one must leave room for the next frame to arrive by setting
> the max aggregated bytes to 0xffff - dev->mtu.  This is masked
> by the driver computing max_aggr as above.

This suggestions sounds good. Will add it.
