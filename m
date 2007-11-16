Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0C7ADDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 01:59:03 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAGF0QkM015947
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:00:26 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAGEwmiE128296
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 09:58:48 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAGEwlXZ004341
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 09:58:47 -0500
Date: Fri, 16 Nov 2007 08:58:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
Message-ID: <20071116085813.3cebed79@weaponx>
In-Reply-To: <20071116074025.GA4741@lixom.net>
References: <20071116072149.350ADDDDF4@ozlabs.org>
	<20071116074025.GA4741@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 Nov 2007 01:40:25 -0600
Olof Johansson <olof@lixom.net> wrote:

> On Fri, Nov 16, 2007 at 06:21:06PM +1100, Benjamin Herrenschmidt wrote:
> > This removes the old CONFIG_440A which was a pain for multiplatform
> > kernel and wasn't set properly by default and replaces it with a
> > CPU feature. This makes Machine Check reporting work correctly on
> > my Ebony (440GP) board.
> 
> I'm not sure I like this. It introduces another cpu feature flag,
> that we'll soon run out of if it's used to signify version info per
> implementation like this.
> 
> 1) The SET_IVOR could be done from the cpu_setups for 440A instead
> (i.e. introduce one).

Yeah, that might work.  I'm wondering if either method needs to take
arch/ppc into account, as the cputable is shared.

> 2) Please just move the machine check handlers out to individual ones
> instead of using the generic one. That way you don't need runtime checks
> between the two (they don't seem to share much of it as-is anyway).

Anton pinged me about cleaning that up a couple months ago.  I have a
half-baked patch for it somewhere, but I agree having 4xx set a ppc_md
specific handler would be a good idea.

josh
