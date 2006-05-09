Return-Path: <info@schihei.de>
Received: from schihei.org (schihei.net [81.169.184.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4225D67A77
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:57:33 +1000 (EST)
In-Reply-To: <20060509164919.GC5063@mellanox.co.il>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com>
	<20060509164919.GC5063@mellanox.co.il>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
Date: Tue, 9 May 2006 20:57:01 +0200
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09.05.2006, at 18:49, Michael S. Tsirkin wrote:

>> The trivial way to do it would be to use the same idea as the current
>> ehca driver: just create a thread for receive CQ events and a thread
>> for send CQ events, and defer CQ polling into those two threads.
>
> For RX, isn't this basically what NAPI is doing?
> Only NAPI seems better, avoiding interrupts completely and avoiding  
> latency hit
> by only getting triggered on high load ...

Does NAPI schedules CQ callbacks to different CPUs or stays the callback
(handling of data, etc.) on the same CPU where the interrupt came in?

Regards,
	Heiko
