Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7214DECAD
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 02:03:26 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l7RG3MWq054714
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 16:03:22 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7RG3LaP2490488
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 17:03:21 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7RG35MY015306
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 17:03:05 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: James Chapman <jchapman@katalix.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Mon, 27 Aug 2007 18:02:47 +0200
References: <46CF127D.1090609@katalix.com>
	<20070826.185815.93042514.davem@davemloft.net>
	<46D2F301.7050105@katalix.com>
In-Reply-To: <46D2F301.7050105@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708271802.48691.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, akepner@sgi.com,
	meder@de.ibm.com, shemminger@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007 17:51, James Chapman wrote:

> In the second half of my previous reply (which seems to have been 
> deleted), I suggest a way to avoid this problem without using hardware 
> interrupt mitigation / coalescing. Original text is quoted below.
> 
>  >> I've seen the same and I'm suggesting that the NAPI driver keeps
>  >> itself in polled mode for N polls or M jiffies after it sees
>  >> workdone=0. This has always worked for me in packet forwarding
>  >> scenarios to maximize packets/sec and minimize latency.
> 
> To implement this, there's no need for timers, hrtimers or generic NAPI 
> support that others have suggested. A driver's poll() would set an 
> internal flag and record the current jiffies value when finding 
> workdone=0 rather than doing an immediate napi_complete(). Early in 
> poll() it would test this flag and if set, do a low-cost test to see if 
> it had any work to do. If no work, it would check the saved jiffies 
> value and do the napi_complete() only if no work has been done for a 
> configurable number of jiffies. This keeps interrupts disabled longer at 
> the expense of many more calls to poll() where no work is done. So 
> critical to this scheme is modifying the driver's poll() to fastpath the 
> case of having no work to do while waiting for its local jiffy count to 
> expire.
> 

The problem I see with this approach is that the time that passes between
two jiffies might be too long for 10G ethernet adapters. (I tried to implement
a timer based approach with usual timers and the result was a disaster).
HW interrupts / or HP timer avoid the jiffy problem as they activate softIRQs
as soon as you call netif_rx_schedule. 
