Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2FAC3DDE37
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 07:53:20 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901053E8497@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
	<2B407BB2-BBA6-4B13-BF34-DABFB3F8ADEF@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90106443362@EMPBEDEX.empirix.com>
	<21F08FBD-6702-46A2-9592-329D8CF04073@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D901053E8497@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1952BE4-7FE4-4432-8B39-D3D6EF7081D0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: options for root file system for MPC8548
Date: Wed, 31 Jan 2007 14:52:54 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 17:14, Morrison, Tom wrote:

>
> they have full MPC8548 support...and fwiw, the
> standard fedora & debian ppc is incompatible
> with the e500 core (throws floating point
> exceptions - due to different FP instruction set)...
>
> I like their update support...
>
> and fyi, freescale already turns on software emulation
> in their kernel CDS support package by default. We
> intend to turn that OFF very soon!


Why?  Maybe I'm blanking on something obvious, here, but the code  
doesn't hurt you if it's on.  But the slightest mistake in building  
an application could lead to a crash if it's off.  We try to make  
sure our toolchains don't produce classic fp instructions, but you  
can easily use the wrong compiler, or grab a library that left in a  
mtfpscr or something.  If FP emulation is on, that won't really  
affect performance, and it will mean your program doesn't crash at  
random.

And I'd like to reaffirm Stuart's points that you don't have to use  
Busy Box, or the built-in kernel.  The kernel and Root FS should be  
almost entirely independent (breaking user-space is considered a bug).

Andy
