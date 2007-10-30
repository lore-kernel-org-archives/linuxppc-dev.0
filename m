Return-Path: <fubar@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9ECB5DE2D7
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 06:07:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9UJ7FIJ005519
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:07:15 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9UJ77hS104358
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 13:07:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9UJ76xF012254
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 13:07:07 -0600
To: "Demke Torsten-atd012" <torsten.demke@motorola.com>
Subject: Re: Gianfar skb panic when bonding a VLAN interface 
In-reply-to: <67194FEE6056B947B4EF756C9E497A2E01DB237A@zuk35exm60.ds.mot.com> 
References: <67194FEE6056B947B4EF756C9E497A2E01DB237A@zuk35exm60.ds.mot.com>
Date: Tue, 30 Oct 2007 12:07:04 -0700
Message-ID: <28345.1193771224@death>
From: Jay Vosburgh <fubar@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Demke Torsten-atd012 <torsten.demke@motorola.com> wrote:

>I tried to ping over a bonded VLAN tagged interface.
>(e.g  -> ifenslave bond0 eth3.24)
[...]
>It seems that the skb headroom is to small. How can I solve this?
>I could insert skb_realloc_headroom() call, but where it's the best
>place then?
>What about alignement?

	What kernel are you using?  There was a fix applied to the
bonding driver about a year ago to resolve this problem with gianfar:

commit 54ef313714070b397d3857289f0fd099b7643631
Author: Jay Vosburgh <fubar@us.ibm.com>
Date:   Fri Sep 22 21:53:39 2006 -0700

    [PATCH] bonding: Handle large hard_header_len
    
    The bonding driver fails to adjust its hard_header_len when enslaving
    interfaces.  Whenever an interface with a hard_header_len greater than the
    ETH_HLEN default is enslaved, the potential for an oops exists, and if the
    oops happens while responding to an arp request, for example, the system
    panics.  GIANFAR devices may use an extended hard_header for VLAN or
    hardware checksumming.  Enslaving such a device and then transmitting over
    it causes a kernel panic.
    
    Patch modified from submitter's original, but submitter agreed with this
    patch in private email.
    
    Signed-off-by: Mark Huth <mhuth@mvista.com>
    Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
