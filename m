Return-Path: <martin.roth@motorolasolutions.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C2BE1A004B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:57:26 +1100 (AEDT)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id B0C131402D4
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2015 18:57:24 +1100 (AEDT)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 19E181AC4154
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 23:38:24 -0800 (PST)
Date: Tue, 24 Nov 2015 00:08:54 -0700 (MST)
From: Martin Roth <martin.roth@motorolasolutions.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1448348934144-101274.post@n7.nabble.com>
In-Reply-To: <4BFDC6EC.9090804@elphinstone.net>
References: <4BFDC6EC.9090804@elphinstone.net>
Subject: Re: [PATCH] fs_enet: Adjust BDs after tx error
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

Hi,

I have reviewed the code and in my opinion the  line 

                     last_tx_bd = fep->tx_bd_base + (fpi->tx_ring *
sizeof(cbd_t)); 

should be replaced with
              
                     last_tx_bd = fep->tx_bd_base + ((fpi->tx_ring-1) *
sizeof(cbd_t));  

In  the original code  the last_tx_bd  points to location after the last
base descriptor end.
In the code fix that I propose, the  last_tx_bd points to the last
descriptor.  

Am I missing something ?

Thanks,
Martin  



--
View this message in context: http://linuxppc.10917.n7.nabble.com/PATCH-fs-enet-Adjust-BDs-after-tx-error-tp37529p101274.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
