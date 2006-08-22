Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id EEEB3679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:29:10 +1000 (EST)
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
References: <44E7BB7F.7030204@osdl.org> <200608191325.19557.arnd@arndb.de>
	<20060821235244.GJ5427@austin.ibm.com>
	<20060821.165616.107936004.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 21 Aug 2006 17:29:05 -0700
In-Reply-To: <20060821.165616.107936004.davem@davemloft.net> (David Miller's
	message of "Mon, 21 Aug 2006 16:56:16 -0700 (PDT)")
Message-ID: <adaac5x3966.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org, arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com, shemminger@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    David> Don't touch interrupts until both RX and TX queue work is
    David> fullydepleted.  You seem to have this notion that RX and TX
    David> interrupts are seperate.  They aren't, even if your device
    David> can generate those events individually.  Whatever interrupt
    David> you get, you shut down all interrupt sources and schedule
    David> the ->poll().  Then ->poll() does something like:

This is a digression from spidernet, but what if a device is able to
generate separate MSIs for TX and RX?  Some people from IBM have
suggested that it is beneficial for throughput to handle TX work and
RX work for IP-over-InfiniBand in parallel on separate CPUs, and
handling everything through the ->poll() method would defeat this.

 - R.
