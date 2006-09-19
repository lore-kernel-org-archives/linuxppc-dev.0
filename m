Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5BC1D67B53
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:44:34 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JJiVO5025003
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 15:44:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8JJiVwg245712
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 13:44:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8JJiUxx004949
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 13:44:31 -0600
Date: Tue, 19 Sep 2006 14:44:25 -0500
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Fw: [PATCH] Remove powerpc specific parts of 3c509 driver
Message-ID: <20060919194425.GO29167@austin.ibm.com>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45103C62.4080003@genesi-usa.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	netdev@vger.kernel.org, jgarzik@pobox.com,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 08:52:18PM +0200, Matt Sealey wrote:
[...]
> 
> Linas Vepstas wrote:
> >On Tue, Sep 19, 2006 at 02:54:33PM +1000, Stephen Rothwell wrote:
> >>On powerpc and ppc, insl_ns and insl are identical as are outsl_ns and
> >>outsl, so remove the conditional use of insl_ns and outsl_ns.
> >
> >The rest of this patch might indeed be correct, but the above comment 
> >bothers me. The "ns" versions of routines are supposed to be
> >non-byte-swapped versions of the insl/outsl routines (which would

Never mind. Silly me don't know my history. 

asm-powerpc/io.h clearly states

 * The *_ns versions below don't do byte-swapping.
 * Neither do the standard versions now, these are just here
 * for older code.

Seems that the byteswapping machanism was changed a while ago, 
and no longer handled in this way any more.

--linas
