Return-Path: <sfbest@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EF59B7D57
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 21:49:39 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59Bgx2f014669
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 05:42:59 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59BnWkl146312
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 05:49:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59BnTlW024727
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 05:49:29 -0600
Subject: Re: [PATCH] powerpc: Fix integer constant warning
From: Steve Best <sfbest@us.ibm.com>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <9000.1276002746@redhat.com>
References: <20100607203957.23695.97675.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<9000.1276002746@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Jun 2010 07:50:07 -0400
Message-Id: <1276084207.6135.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 2010-06-08 at 14:12 +0100, David Howells wrote:
> Steve Best <sfbest@us.ibm.com> wrote:
> 
> > -#define KERNELBASE (0xc000000000000000)
> > +#define KERNELBASE (0xc000000000000000ULL)
> 
> Is this the right fix?  The code producing the warning is subtracting
> 0xc000000000000000 from a 32-bit number:

agree this fix needs more work, and can be dropped. Paul has another
patch that removes this file, since it is no longer used. I assume we'll
go with that patch.
> 
> 	naca = ntohl(*((u_int32_t*) &inbuf[0x0C])) - KERNELBASE;
> 
> which seems distinctly odd.
> 
> David

-Steve
