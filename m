Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D3C8ADDF9D
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 05:33:15 +1100 (EST)
In-Reply-To: <20090102140842.GA24775@in.ibm.com>
References: <20090102140842.GA24775@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b9c5b5d9e58e64de3b8459f477acacc5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] ppc64: Support for relocatable kernel in kexec-tools
Date: Fri, 2 Jan 2009 12:39:50 -0600
To: mohan@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 2, 2009, at 8:08 AM, M. Mohan Kumar wrote:

> Support for relocatable kernel in kexec-tools
>
> This patch is based on the  patch sent by Milton Miller with the 
> subject [PATCH 1/2
>  kexec-tools] ppc64: new relocatble kernel activation ABI
>
> http://patchwork.ozlabs.org/patch/5378/
>
> Even with the above patch, the relocatable kernel always move to 
> physical
> address 0 (ie PHYSICAL_START). Following patch fixes this problem by 
> marking
> a local variable to 1 in purgatory during kdump kernel load time 
> (kexec -p).
> After a crash, purgatory sets __run_at_load variable location in the 
> kernel
> to 1 if the local variable is set to 1. So that the kernel will be 
> running
> as a relocatable kernel.
>
> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
> Signed-off-by: Milton Miller <miltonm@bga.com>

your sign-off should have been after mine as you were making changes to 
my patch.

I actually completed my own testing last night with a slightly 
different version:

(1) I unconditionally store the purgatory value to the kernel (less 
maintence if we decide to define further flags in the future).

(2) I use less registers in asm (no need for r18)

(3) I renamed the variable in the c code to be my_run_at_load to be 
more consistent  with the other names.

Also, I have some cleanup patches on top of this one.  I'm in the 
process of setting up a new email client to send my patches, so it will 
be a few hours yet until I get them posted.  But I would appreciate 
waiting for my series so I don't have to rediff the later patches.

thanks,
milton
