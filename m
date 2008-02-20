Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62DFEDE20C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 05:09:21 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1KI94xI018261
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 13:09:04 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1KI9EPH211254
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:09:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1KI9E6J019172
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:09:14 -0700
Date: Wed, 20 Feb 2008 12:08:02 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix Haleakala PCIe compatibility problem
	in dts
Message-ID: <20080220120802.1657d34e@zod.rchland.ibm.com>
In-Reply-To: <200802201416.54004.sr@denx.de>
References: <1203504358-21331-1-git-send-email-sr@denx.de>
	<20080220070119.27dc250d@zod.rchland.ibm.com>
	<200802201416.54004.sr@denx.de>
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

On Wed, 20 Feb 2008 14:16:53 +0100
Stefan Roese <sr@denx.de> wrote:

> > > The 405EX and 405EXr are identical exept that the 2nd PCIe and the
> > > 2nd EMAC interfaces are missing.
> >
> > Does ppc405ex_pciex_core_init need to grow some logic to detect 405ex
> > from 405exr and return the correct number of ports then?  It
> > unconditionally returns 2 today.
> 
> Yes, this could be done. Right now it works because the 405EXr board 
> (Haleakala) only instantiates one PCIe device in the dts.
> 
> A simple solution would be to just do a PVR check. Would this be acceptable?

Looking more at the code, it seems like it's really not needed.
Essentially the only thing that is "wrong" is that we allocate an extra
structure that goes unused.

As long as the DTS file doesn't list a second bogus port, things work
fine.  So I'm inclined to take your patch as-is.

josh
