Return-Path: <martin.roth@motorolasolutions.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A4F41A004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 00:02:27 +1100 (AEDT)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 4842E1402D7
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 00:02:25 +1100 (AEDT)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 3E32A1AC8FDC
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2015 04:49:21 -0800 (PST)
Date: Tue, 24 Nov 2015 05:19:51 -0700 (MST)
From: Martin Roth <martin.roth@motorolasolutions.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1448367591225-101297.post@n7.nabble.com>
Subject: FCC driver for Motorola MPC82xx - an error found
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I was looking for an error on MPC8270 processor 100 Mbps Ethernet FCC port.  
The port may become locked if it is set to AUTO, while the peer is forced to
100 Mbs full duplex (non AUTO).
I was looking for an error in the area of collision handling of the driver.
It looks like I found the problem.

The error is at line 555:
http://lxr.free-electrons.com/source/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c#L555

The problem is that the last descriptor address is not calculated correctly.

Instead of
   last_tx_bd = fep->tx_bd_base + (fpi->tx_ring * sizeof(cbd_t)); 
The fix should be:
   last_tx_bd = fep->tx_bd_base + ((fpi->tx_ring-1)* sizeof(cbd_t));

Is it a bug? 
Thanks,
Martin Roth



--
View this message in context: http://linuxppc.10917.n7.nabble.com/FCC-driver-for-Motorola-MPC82xx-an-error-found-tp101297.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
