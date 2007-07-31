Return-Path: <gallatin@myri.com>
Received: from myri.com (dsl.myri.com [64.172.73.26])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7BF7DDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 23:34:56 +1000 (EST)
Message-ID: <46AF3A6B.2040006@myri.com>
Date: Tue, 31 Jul 2007 09:34:35 -0400
From: Andrew Gallatin <gallatin@myri.com>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 0/4][RFC] lro: Generic Large Receive Offload for TCP
	traffic
References: <200707301724.33865.ossthema@de.ibm.com>
	<46AE4AC9.6060109@myri.com>
	<200707311233.31227.ossthema@de.ibm.com>
In-Reply-To: <200707311233.31227.ossthema@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jan-Bernd Themann wrote:
> On Monday 30 July 2007 22:32, Andrew Gallatin wrote:

>> Second, you still need to set skb->ip_summed = CHECKSUM_UNNECESSARY
>> when modified packets are flushed, else the stack will see bad
>> checksums for packets from CHECKSUM_COMPLETE drivers using the
>> skb interface.  Fixed in the attached patch.
> 
> I thought about it... As we do update the TCP checksum for aggregated
> packets we could add a second ip_summed field in the net_lro_mgr struct 
> used for aggregated packets to support HW that does not have any checksum helper
> functionality. These drivers could set this ip_summed field to CHECKSUM_NONE, 
> and thus leave the checksum check to the stack. I'm not sure if these old devices benefit
> a lot from LRO. So what do you think?

This might be handy, and it would also fix the problem with
CHECKSUM_PARTIAL drivers using the skb interface by allowing them
to set it to CHECKSUM_UNNECESSARY.


>> Fourth, I did some traffic sniffing to try to figure out what's going
>> on above, and saw tcpdump complain about bad checksums.  Have you tried
>> running tcpdump -s 65535 -vvv?  Have you also seen bad checksums?
>> I seem to see this for both page- and skb-based versions of the driver.
>>
> 
> Hmmm, can't confirm that. For our skb-based version I see
> correct checksums for aggregated packets and for the page-based version as well.
> I used: (tcpdump -i ethX -s 0 -w dump.bin) in combination with ethereal.
> Don't see problems as well with your tcpdump command.

I'm still trying to get a handle on this.  It happens both with
page based and skb based receive for me..  I would not be
surprised if I was doing something wrong in myri10ge.  But
I don't see it without LRO, or with my LRO.  I'll let you
know when I figure it out..

In the meantime, in case you have any insight, I've left a
capture of a small "netcat" transfer of a 64KB file full
of zeros at http://www.myri.com/staff/gallatin/lro/netcat_dump.bz2

Drew
