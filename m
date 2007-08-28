Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D119DDF92
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 21:49:12 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l7SBmsHa334082
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:48:54 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7SBmsSH2539674
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 12:48:54 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7SBmb5W002106
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 12:48:38 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: James Chapman <jchapman@katalix.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Tue, 28 Aug 2007 13:48:20 +0200
References: <46D2F301.7050105@katalix.com>
	<20070827.145600.102570576.davem@davemloft.net>
	<46D3E971.4010909@katalix.com>
In-Reply-To: <46D3E971.4010909@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281348.21302.ossthema@de.ibm.com>
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

On Tuesday 28 August 2007 11:22, James Chapman wrote:
> > So in this scheme what runs ->poll() to process incoming packets?
> > The hrtimer?
> 
> No, the regular NAPI networking core calls ->poll() as usual; no timers 
> are involved. This scheme simply delays the napi_complete() from the 
> driver so the device stays in the poll list longer. It means that its 
> ->poll() will be called when there is no work to do for 1-2 jiffies, 
> hence the optimization at the top of ->poll() to efficiently handle that 
> case. The device's ->poll() is called by the NAPI core until it has 
> continuously done no work for 1-2 jiffies, at which point it finally 
> does the netif_rx_complete() and re-enables its interrupts.
> 
I'm not sure if I understand your approach correctly.
This approach may reduce the number of interrupts, but it does so
by blocking the CPU for up to 1 jiffy (that can be quite some time
on some platforms). So no other application / tasklet / softIRQ type
can do anything in between. The CPU utilization does not drop at all, 
and I thought that is one reason why we try to reduce the number of interrupts.

> If people feel that holding the device in the poll list for 1-2 jiffies 
> is too long (because there are too many wasted polls), a counter could 
> be used to to delay the netif_rx_complete() by N polls instead. N would 
> be a value depending on CPU speed. I use the jiffy sampling method 
> because it results in some natural randomization of the actual delay 
> depending on when the jiffy value was sampled in relation to the jiffy tick.
> 

Waiting for N polls seems to make no sense if there are no further network adapters
in that machine. It would take no time to call poll N times in a row when no
new packets arrive. There is no real delay as the net_rx_action function will
do nothing else between the poll calls.

Please correct me if I'm wrong.

Regards,
Jan-Bernd
