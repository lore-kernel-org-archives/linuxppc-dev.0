Return-Path: <MELGOR@ie.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B94BB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 22:51:29 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate4.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n8NCp4iH094352
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 12:51:09 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n8NCos4D3002434
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 13:50:54 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n8NCorUU012935
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 13:50:54 +0100
In-Reply-To: <1253653702.7103.244.camel@pasglop>
References: <20090922025235.GD31801@kryten>	
	<OFE590BAE9.6FD7FAB3-ON80257639.0050F8A6-80257639.00514A5E@ie.ibm.com>
	<1253653702.7103.244.camel@pasglop>
Subject: Re: powerpc: Move 64bit heap above 1TB on machines with 1TB segments
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF8645CAEF.1B168C2A-ON8025763A.00391DF9-8025763A.00469310@ie.ibm.com>
From: Mel Gorman <MELGOR@ie.ibm.com>
Date: Wed, 23 Sep 2009 13:50:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 22/09/2009
22:08:22:

> > Unfortunately, I am not sensitive to issues surrounding 1TB segments or
how
> > they are currently being used. However, as this clearly helps
performance
> > for large amounts of memory, is it worth providing an option to
> > libhugetlbfs to locate 16MB pages above 1TB when they are otherwise
being
> > unused?
>
> AFAIK, that is already the case, at least the kernel will hand out pages
> above 1T preferentially iirc.
>
> There were talks about making huge pages below 1T not even come up
> untily you ask for them with MAP_FIXED, dunno where that went.
>

Confirmed, huge pages are already being placed above the 1TB mark. I hadn't
given thought previously to where hugepages were being placed except within
segment boundaries. The patch works as advertised and doesn't appear to
collide with huge pages in any obvious way as far as I can tell.
