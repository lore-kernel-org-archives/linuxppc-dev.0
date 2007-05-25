Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 01071DDF19
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:45:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 5/7] ps3: Disk Storage Driver
Date: Sat, 26 May 2007 00:45:09 +0200
References: <20070525083607.784351000@sonycom.com>
	<200705252243.41508.arnd@arndb.de>
	<Pine.LNX.4.62.0705252318160.2657@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705252318160.2657@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705260045.09722.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 May 2007, Geert Uytterhoeven wrote:
> On Fri, 25 May 2007, Arnd Bergmann wrote:
>
> > Ok, but why does it call wait_for_completion() then?
> > I thought you could end_that_request_* from the interrupt handler instead.
> 
> Actually I tried that first, but I ran into other problems, like my request
> handler being called continuously and requests gotten stuck. But maybe it was
> just a locking bug on my side.
> 
> I can retry, but a disadvantage will be that there will be less code shared
> with ps3flash and ps3rom.

Not sure how much difference it will make performance-wise, but the context
switch for each bio adds some extra cost at least. Changing it
means you no longer share the ps3stor_read_write_sectors, but can at
the same time simplify the disk driver, so that won't hurt in total.

I don't care much, but I think it's worth trying.

	Arnd <><
