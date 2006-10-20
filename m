Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57E8A67C42
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 01:19:36 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9KFJUAW001790
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:19:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9KFJUIi149932
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:19:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9KFJUKJ009164
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:19:30 -0400
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4538DACC.5050605@shadowen.org>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<4538DACC.5050605@shadowen.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 10:19:25 -0500
Message-Id: <1161357566.8946.62.camel@farscape>
Mime-Version: 1.0
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	Christoph Lameter <clameter@sgi.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-20-10 at 15:18 +0100, Andy Whitcroft wrote:
> Paul Mackerras wrote:
> > Christoph Lameter writes:
> > 

I got dropped off the CC list somewhere..  :-(     

if something is bouncing, let me know,.. otherwise please dont do
that.. 


> Mel Gorman and I have been poking at this from different ends.  Mel from
> the context of this thread and myself trying to fix a machine which was
> exhibiting on 32MB of ram in node 0 and the rest in node 1.
> 
> I remember that we used to have code to cope with this in the ppc64
> architecture, indeed I remember reviewing it all that time ago.  Looking
> at the current state of the tree it was removed in the two patches below
> in mainline:
> 	"[PATCH] Remove SPAN_OTHER_NODES config definition"
> 	"[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
> 
> These commits:
> 	f62859bb6871c5e4a8e591c60befc8caaf54db8c
> 	a94b3ab7eab4edcc9b2cb474b188f774c331adf7
> 
> I'll follow up to this email with the reversion patch we used in
> testing.  It seems to sort this problem out at least, though now its
> blam'ing in ibmveth, so am retesting with yet another patch.  This patch
> reverts the two patches above and updates the commentry on the Kconfig
> entry.

I've got a couple LPARs that exhibit the problem, so can verify your
patch once I see it.. 

-Will


> 
> -apw
