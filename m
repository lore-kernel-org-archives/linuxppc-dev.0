Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51AFDDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:04:19 +1000 (EST)
Message-Id: <9B86B565-1A28-46CD-8C30-DECB3EBF0763@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <49F60EC9.2050501@ovro.caltech.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
Date: Mon, 27 Apr 2009 15:02:03 -0500
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>	<49F608B7.9080409@ovro.caltech.edu>	<49F60A3A.4060402@freescale.com>	<49F60BF8.8040404@ovro.caltech.edu>
	<46B638E2-885C-4281-81EA-CB685264E143@kernel.crashing.org>
	<49F60EC9.2050501@ovro.caltech.edu>
Cc: Ira Snyder <iws@ovro.caltech.edu>, Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 3:00 PM, David Hawkins wrote:

>
>>> Can you give me an example of non-PCI memory that would be
>>> non-prefetchable that you'd like us to try? We can see if our
>>> host CPUs have an area like that ... we just need to know
>>> what device to look for first :)
>> You can mark the pci inbound window on the 83xx as non-prefetchable  
>> (assuming 83xx is host). On a x86 host I doubt there is any easy  
>> way to get non-prefetchable memory.
>
> Yep, we were going to do that, but chose to use the
> 1MB region already setup for the IMMRs since its already
> marked as non-prefetchable. We were only doing reads, so
> it wasn't going to hurt anything.
>
> I doubt that marking one of the other BAR regions
> as non-prefetchable will give a different result.
> However, we're more than happy to double-check if
> you'd like.

Its possible you'll get a different result since IMMR is a register  
space internal and thats normally a completely different bus than  
memory would be (internal to the 83xx).  I'd suggest double-checking w/ 
a BAR marked non-prefetch pointing to real memory.

- k
