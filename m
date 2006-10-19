Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3677E67B6C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 06:38:31 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9JKcSnl028021
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:38:28 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9JKcStA199528
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:38:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9JKcRu3008076
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 16:38:28 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
	<Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
	<1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 15:38:24 -0500
Message-Id: <1161290304.8946.54.camel@farscape>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-19-10 at 09:16 -0700, Christoph Lameter wrote:
> On Thu, 19 Oct 2006, Paul Mackerras wrote:
> 
> > Get cache descritor
> 
> Attempt to allocate the first descriptor for the first cache.
> 
> > __cache_alloc
> 
> Attempt to allocate from the caches of node 0 (which are empty on 
> bootstrap). We try to replenish the caches of node 0 which should have 
> succeeded. I guess that this failed due to no pages available on 
> node 0. This should not happen!

Is there a hook where we can see what/where the memory is going?  Does
it seem reasonable for all of the memory that is in node 0 to be
consumed? 
Mine appears to have... 
Node 0 MemTotal:       229376 kB
Node 0 MemFree:             0 kB
Node 0 MemUsed:        229376 kB

And one of Paul's earlier notes mentioned about a gig of ram on node0;

-Will
