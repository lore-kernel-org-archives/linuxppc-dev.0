Return-Path: <rick.jones2@hp.com>
Received: from palrel13.hp.com (palrel13.hp.com [156.153.255.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "palrel13.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 9E0E467B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:20:43 +1000 (EST)
Message-ID: <44E3A572.20600@hp.com>
Date: Wed, 16 Aug 2006 16:08:34 -0700
From: Rick Jones <rick.jones2@hp.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
References: <44E34825.2020105@garzik.org>
	<44E38157.4070805@garzik.org>	<20060816.134640.115912460.davem@davemloft.net>	<200608162324.47235.arnd@arndb.de>
	<20060816225558.GM20551@austin.ibm.com>
In-Reply-To: <20060816225558.GM20551@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, jeff@garzik.org,
	netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Wed, Aug 16, 2006 at 11:24:46PM +0200, Arnd Bergmann wrote:
> 
>>it only
>>seems to be hard to make it go fast using any of them. 
> 
> 
> Last round of measurements seemed linear for packet sizes between
> 60 and 600 bytes, suggesting that the hardware can handle a 
> maximum of 120K descriptors/second, independent of packet size.
> I don't know why this is.

DMA overhead perhaps?  If it takes so many micro/nanoseconds to get a 
DMA going....  That used to be a reason the Tigon2 had such low PPS 
rates and issues with multiple buffer packets and a 1500 byte MTU - it 
had rather high DMA setup latency, and then if you put it into a system 
with highish DMA read/write latency... well that didn't make it any 
better :)

rick jones
