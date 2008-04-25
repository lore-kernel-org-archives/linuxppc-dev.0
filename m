Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8D92DE1AF
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:48:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3PAjYrE031389
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 06:45:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3PAm8Jl195928
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 04:48:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3PAm8UG008262
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 04:48:08 -0600
Date: Fri, 25 Apr 2008 05:42:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080425054237.44228ddb@zod.rchland.ibm.com>
In-Reply-To: <1209103970.9060.226.camel@pasglop>
References: <20080425053941.GT20457@bakeyournoodle.com>
	<1209103970.9060.226.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Apr 2008 16:12:50 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2008-04-25 at 15:39 +1000, Tony Breeds wrote:
> > Currently we set the start of the .text section to be 4Mb for pSeries.
> > In situations where the zImage is > 8Mb we'll fail to boot (due to
> > overlapping with OF).  Move .text in a pSeries zImage from 4MB to 64MB
> > (well past OF).
> > 
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> > ---
> >  - Compile tested for *_defconfig with only pSeries chaning it's link
> >    address.
> >  - Boot tested on POWER6
> 
> Considering how bad OF can be on some machines, I'd like this to be
> boot-tested on a wider range of machines. Also, it might depend on the
> OF real-base setting as well...
> 
> At least, we should be able to test at ozlabs on cell blades, POWER4
> bare metal (ie "SMP mode"), POWER5 and POWER5+.

And given that all the embedded boards use zImage.lds.S, we should
probably test it there.  I'll try to test on 4xx for both treeImage and
U-Boot today.

josh
