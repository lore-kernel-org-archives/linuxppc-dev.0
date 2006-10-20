Return-Path: <mkravetz@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61C9267C7E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 00:59:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9KExDmY027702
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:59:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9KEwxF6286800
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:58:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9KEwwbm014098
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:58:59 -0400
Date: Fri, 20 Oct 2006 07:59:45 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061020145945.GA5085@monkey.ibm.com>
References: <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<4538DACC.5050605@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4538DACC.5050605@shadowen.org>
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 03:18:52PM +0100, Andy Whitcroft wrote:
> I remember that we used to have code to cope with this in the ppc64
> architecture, indeed I remember reviewing it all that time ago.  Looking
> at the current state of the tree it was removed in the two patches below
> in mainline:
> 	"[PATCH] Remove SPAN_OTHER_NODES config definition"
> 	"[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"

That was me.  Seem to remember some discussion that these were only
needed for DISCONTIGMEM, so I removed them when the DISCONTIGMEM option
for power went away.  But, that is clearly NOT the case.  Appears that
SPARSEMEM and the old slab code covered up the issue.  Sorry about that.

Thanks!
-- 
Mike
