Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BAC3BDDF06
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 19:47:20 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l7R9lF3U201538
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 09:47:15 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7R9lFiU3027132
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 10:47:15 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7R9l8cM027060
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 10:47:08 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Mon, 27 Aug 2007 11:47:01 +0200
References: <46CF127D.1090609@katalix.com> <46D1D634.7060007@katalix.com>
	<20070826.185815.93042514.davem@davemloft.net>
In-Reply-To: <20070826.185815.93042514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708271147.01890.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007 03:58, David Miller wrote:
> From: James Chapman <jchapman@katalix.com>
> Date: Sun, 26 Aug 2007 20:36:20 +0100
> 
> > David Miller wrote:
> > > From: James Chapman <jchapman@katalix.com>
> > > Date: Fri, 24 Aug 2007 18:16:45 +0100
> > > 
> > >> Does hardware interrupt mitigation really interact well with NAPI?
> > > 
> > > It interacts quite excellently.
> > 
> > If NAPI disables interrupts and keeps them disabled while there are more 
> > packets arriving or more transmits being completed, why do hardware 
> > interrupt mitigation / coalescing features of the network silicon help?
> 
> Because if your packet rate is low enough such that the cpu can
> process the interrupt fast enough and thus only one packet gets
> processed per NAPI poll, the cost of going into and out of NAPI mode
> dominates the packet processing costs.

As far as I understand your argumentation, NAPI is supposed to work well only
for HW with coalescing features (concerning dropping the interrupt rate).
NAPI itself does not provide a reliable functionality to reduce the
number of interrupts, especially not for systems with only 1 NIC. 
NAPI will only wait for some time when the budget is exceeded
and the softIRQs don't call net_rx_action again. This seems to be the case
after 10 rounds. That means NAPI really waits after 300 x 10 packets 
have been processed in a row (worst case).

As a matter of fact there is HW that does not have this feature. There seems
to be HW which does not work well with plain NAPI.
This HW performs well if the operation system supports HP timers 
(and when they are used either in the device driver or polling engine).

So the question is simply: Do we want drivers that need (benefit from)
a timer based polling support to implement their own timers each, 
or should there be a generic support? 

Thanks,
Jan-Bernd
