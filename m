Return-Path: <sonny@kevlar.burdell.org>
Received: from kevlar.burdell.org (kevlar.burdell.org [66.92.73.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96C2567B90
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 14:47:19 +1000 (EST)
Date: Wed, 19 Jul 2006 00:47:11 -0400
From: Sonny Rao <sonny@burdell.org>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: kernel memory map/usage/holes?
Message-ID: <20060719044711.GA21794@kevlar.burdell.org>
References: <44BBEDE1.3040004@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44BBEDE1.3040004@nortel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 17, 2006 at 02:06:57PM -0600, Chris Friesen wrote:
> 
> I've got a Maple board with 4GB of memory running a modified 2.6.10 
> kernel.  When it boots, I see the following in the logs:
> 
> 
> Top of RAM: 0x180000000, Total RAM: 0x100000000
> On node 0 totalpages: 1048576
>    DMA zone: 1048576 pages, LIFO batch:16
>    Normal zone: 0 pages, LIFO batch:1
>    HighMem zone: 0 pages, LIFO batch:1
> 
> 
> Then a bit later, I see:
> 
> 
> Memory: 4006976k/6291456k available (3408k kernel code, 2284124k 
> reserved, 1656k data, 448k bss, 220k init)
> 
> 
> 
> 1048576 pages works out to 4194304kB, so what happened to the 187328kB 
> that is the difference between the "Total RAM" and "Memory:" lines? 
> We've got an app that wants as much memory as possible, so I need to 
> explain where this 183MB of memory is being used.

I think it's part of the "reserved" category, which includes the MMU
hashtable.  I'd guess that's where it is.

Sonny
