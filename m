Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D73FDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 08:00:49 +1000 (EST)
Message-ID: <49EF938C.9050704@freescale.com>
Date: Wed, 22 Apr 2009 17:00:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8D42.7010104@freescale.com>
	<DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
	<49EF9019.7000102@freescale.com>
In-Reply-To: <49EF9019.7000102@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Kumar Gala wrote:
> 
>> The specific issue I'm talking about is the addition of new nodes that  
>> might break old device trees. 
> 
> New nodes or new properties?  The CPM nodes are not new.  On some device
> trees, the original versions did not have a compatible property for the
> CPM nodes (e.g. commit 0b5cf10691eb2c95a9126bf25f5e084d83d5d743).

As I said earlier, old-style CPM trees are a completely different 
binding.  They are not supported.  They have not been supported for a 
long time.  They were only supported very briefly at the introduction of 
CPM hardware to arch/powerpc, and were full of problems.

> Like I said earlier, if you can demonstrate that *all* of these device
> tree would be broken with the latest kernel anyway, then we don't need
> to worry about backwards compatibility.

That is indeed the case.  A "demonstration" of that for the tree you 
quote is that the "reg" address changed -- if you tried feeding the old 
tree into the new kernel, it would not find the CPM command register. 
There is no code in the kernel that looks for the command-proc property 
anymore.

> I'm tired of debugging customer issues where the kernel is updated but
> the firmware and device tree aren't.  IMHO, Kernel developers are
> generally too lax when it comes to firmware and device tree backwards
> compatibility, and I think that's wrong.

I understand and agree (and it would be easier to get the backwards 
compatibility right if we didn't have the attitude of "we'll fix the dts 
later if we decide we actually care about that aspect of the hardware" 
when adding it in the first place) -- it just isn't an issue in this 
particular case.

-Scott
