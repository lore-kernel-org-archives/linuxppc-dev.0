Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D3202DDF4C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:48:25 +1000 (EST)
Date: Mon, 7 Jul 2008 18:48:20 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080707184820.2a14c8a0@lappy.seanm.ca>
In-Reply-To: <20080707100627.4be05488@zod.rchland.ibm.com>
References: <20080701043607.07484DDED7@ozlabs.org>
	<20080707100627.4be05488@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 7 Jul 2008 10:06:27 -0400
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> On Tue, 01 Jul 2008 14:35:42 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> I tried testing this on a Sequoia board this morning.  Kernel boots,
> but then it hangs when starting the init process.  The last message
> seen is:
> 
> INIT: version 2.86
> booting                                                      
> 
> The setup is an tftp'd kernel via U-Boot using cuImage, nfsroot
> filesystem.  Sequoia has an FPU, and CONFIG_PPC_FPU is set.
> 
> I reverted this patch and used the latest powerpc-next branch and it
> boots fine.
> 
> Seems something is wrong here still.  I suspect the DSI handler
> changes, but I have no proof and haven't debugged it yet.  Until we
> get it fixed, I don't feel overly comfortable putting it in the next
> branch.  Which board and setup did you test with?

On a whim, I tired this on the warp platform (440EP) and got the same
result with basically the same setup.

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 156k init
init started: BusyBox v1.9.1 (2008-04-04 14:47:35 EDT)

And then hung. This was against 2.6.26-rc9.

Cheers,
   Sean
