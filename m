Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BB61DDEEF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:21:32 +1100 (EST)
Message-Id: <C387A6C8-3FC9-4DD9-A79D-3ADAB1F5A73F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
Date: Tue, 8 Jan 2008 00:20:08 -0600
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<1199650065.7291.81.camel@pasglop>
	<66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
Cc: Liu Yu <Yu.Liu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2008, at 2:44 PM, Dan Malek wrote:

>
> On Jan 6, 2008, at 12:07 PM, Benjamin Herrenschmidt wrote:
>
>> It's nice to see somebody digging in that scary math emu stuff. If  
>> you
>> could also get rid of the warnings, it would be perfect :-)
>
> Yes, it is :-)  I didn't think it would have a life beyond MPC8xx.
>
>> .... that this code was lifted from
>> somewhere else (glibc ? gcc soft-float ?),
>
> It seems like a lifetime ago....  I copied the framework
> from Sparc, and the internals from gcc soft-float.  I didn't
> change any of the internal emulation functions (hence,
> some of the warnings), just the calling interface.
>
> While it's convenient, I still don't think kernel float
> emulation should be a solution.  The tools should
> generate soft-float for the applications and libraries.

If we think this is really true, we could move to using include/math- 
emu/* instead of the files in powerpc/math-emu.

The problem I had was when I tried to recreate the history of the code  
in powerpc/math-emu and how it doesn't really match the glibc code  
base.  There are some differences and I wasn't sure if they were do to  
trying to match PPC HW at a bit level or not.

I was hoping that the work Liu Yu would get as a bit of a testsuite to  
see if there was any harm in moving over to include/math-emu.

- k
