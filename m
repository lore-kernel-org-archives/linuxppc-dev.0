Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0879EDDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 02:23:56 +1000 (EST)
Date: Tue, 8 Apr 2008 11:24:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Message-ID: <20080408162413.GA2552@loki.buserror.net>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
	<279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
	<20080407162053.GB2688@loki.buserror.net>
	<1207612292.10388.494.camel@pasglop>
	<8C415339-5DB0-42B3-A942-17296DE68267@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8C415339-5DB0-42B3-A942-17296DE68267@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, hollisb@us.ibm.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 09:28:12AM -0500, Kumar Gala wrote:
> On Apr 7, 2008, at 6:51 PM, Benjamin Herrenschmidt wrote:
>> As far as the above is concerned, I'm not too fan of fixed virtual
>> addresses. I'd rather dynamically assign it. But we can do it.
>
> I'm in agreement with Ben here.  On Freescale parts that could mean  
> using up to 16M of virtual address space while in reality we may only  
> need a handful of 4k pages to cover SoC registers that we are truly  
> accessing at runtime.

So make it configurable, and turn it off if you're low on address space. 

Most of the time, I'd think saving TLB0 entries would be more beneficial,
especially with heavy I/O workloads where registers get banged on a lot.

It's the early debugging that I'm really concerned with, though.  It gets
old hacking an early mapping in each time.

-Scott
