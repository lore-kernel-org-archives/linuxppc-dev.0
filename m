Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2296CB7D9B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 11:05:29 +1000 (EST)
Date: Wed, 16 Jun 2010 18:05:40 -0700 (PDT)
Message-Id: <20100616.180540.116379677.davem@davemloft.net>
To: fubar@us.ibm.com
Subject: Re: [PATCH 1/2] ehea: fix delayed packet processing
From: David Miller <davem@davemloft.net>
In-Reply-To: <6663.1276620347@death.nxdomain.ibm.com>
References: <201006151735.17258.ossthema@de.ibm.com>
	<6663.1276620347@death.nxdomain.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com,
	tklein@linux.ibm.com, adetsch@br.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jay Vosburgh <fubar@us.ibm.com>
Date: Tue, 15 Jun 2010 09:45:47 -0700

> Jan-Bernd Themann <ossthema@de.ibm.com> wrote:
> 
>>In the eHEA poll function an rmb() is required. Without that some packets
>>on the receive queue are not seen and thus delayed until the next interrupt
>>is handled for the same receive queue.
>>
>>Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 	To add a bit of background, this could manifest during a netperf
> TCP_RR or UDP_RR on an otherwise idle network.  TCP would occasionally
> retransmit, but then both the original segment and the retransmission
> would simultaneously appear at the receiver.  For UDP_RR, message sizes
> in excess of the mtu would occasionally "lose" an IP fragment, and
> eventually IP reassembly would time out.
> 
> 	-J
> 
> Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>

Applied.
