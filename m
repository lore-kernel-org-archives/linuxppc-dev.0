Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7D740679E6
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 00:31:05 +1100 (EST)
Date: Fri, 10 Mar 2006 14:31:01 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org,debian-powerpc@lists.debian.org
MIME-Version: 1.0
References: <31042.1141997321@www088.gmx.net>
Subject: Re: Unmapping pages from the linear addressing without HIGHMEM	support
Message-ID: <7457.1141997461@www088.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Dan Malek <dan@embeddedalley.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> Kopie: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org, Benjamin
> Herrenschmidt <benh@kernel.crashing.org>
> Betreff: Re: Unmapping pages from the linear addressing without
> HIGHMEM support
> Datum: Fri, 10 Mar 2006 07:59:33 -0500
> 
> On Mar 10, 2006, at 4:09 AM, Gerhard Pircher wrote:
> 
> > That would mean I cannot reuse the code in dma-mapping.c, right?
> 
> Sure you can.  All you need to do is turn of BAT mapping, which
> is as easy as using the 'nobats' command line parameter and
> all of this code should just work for you.
Yes, that was the solution I would have used. The other solution is to
reserve a physical memory area for DMA operations that is not mapped by the
BATs (AFAIU nor by any page tables setup by the kernel). Therefore I doubt
that I can simply reuse the dma-mapping.c code for the latter approach!? Do
I mix something up here?

> > ...   but I guess I have to setup my own page table for the reserved
> > DMA memory area and implement my own alloc_pages() function!?
> 
> No, that's already done for you behind all of these functions.
But only, if the whole BAT mapping is killed, right?

Thanks!

Gerhard

-- 
"Feel free" mit GMX FreeMail!
Monat für Monat 10 FreeSMS inklusive! http://www.gmx.net
