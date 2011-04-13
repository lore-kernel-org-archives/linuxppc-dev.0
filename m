Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0325B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 01:15:26 +1000 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3DEsJpM012202
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2011 10:54:21 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 704DA38C8039
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 11:15:13 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3DFFMoT202174
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2011 11:15:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3DFFMMG025030
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2011 11:15:22 -0400
Date: Wed, 13 Apr 2011 08:15:09 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] powerpc: align DTL buffer to AMS boundary
Message-ID: <20110413151509.GA27602@us.ibm.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8ACF4@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ACF4@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.04.2011 [15:59:44 +0100], David Laight wrote:
> > From: 
> > linuxppc-dev-bounces+david.laight=aculab.com@lists.ozlabs.org 
> > [mailto:linuxppc-dev-bounces+david.laight=aculab.com@lists.ozl
> > abs.org] On Behalf Of Nishanth Aravamudan
> > Sent: 13 April 2011 15:53
> > To: Ben Herrenschmidt
> > Cc: linuxppc-dev@ozlabs.org; Paul Mackerras; Anton Blanchard
> > Subject: [PATCH] powerpc: align DTL buffer to AMS boundary
> > 
> > PAPR specifies that DTL buffers can not cross AMS environments (aka
> CMO
> > in the PAPR) and can not cross a memory entitlement granule boundary
> > (4k)....
> 
> How big is the buffer being allocated?
> If it is much less than 4k then it might be worth allocating
> a buffer of the correct size, and only if that crosses a 4k boundary
> allocate the larger buffer.

Currently, DISPATCH_LOG_BYTES is 4k (which I assume was actually in
deference to this requirement).

> Also, if the buffer is ever freed, the actual base address is needed
> for the free.

I didn't see any free patch for this sequence of code -- which make
sense as this allocation occurs under a for_each_possible_cpu loop.

Thanks for the feedback,
Nish
