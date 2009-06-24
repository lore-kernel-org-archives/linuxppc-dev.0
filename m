Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD8F8B7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 23:15:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CAE3EDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 23:15:38 +1000 (EST)
Message-Id: <D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: kernel mailz <kernelmailz@googlemail.com>
In-Reply-To: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: 85xx Address space query
Date: Wed, 24 Jun 2009 08:15:25 -0500
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 24, 2009, at 4:44 AM, kernel mailz wrote:

> Hi,
>
> I am a newbie, trying to learn but have a few queries, nice if you  
> could respond
> For linux on 85xx systems...
>
> (a) Kernel code runs in PR=0 AS=0 and PID=0, which user space  
> application run in PR=1 AS=0 and PID 1-255.
> Is this correct.

correct.

> (b) I am writing a small program where the application code opens  
> invokes a ioctl call and passes a buffer pointer ( say 0x10000 in  
> user space)
> Now the driver code is using copy_from_user.
> How this works internally ?
>
> 1. User code executes ioctl
> 2. interrupt goes to the kernel

On the interrupt the PR changes from 0 -> 1

> 3. ioctl handler in driver gets invoked
> The buffer pointer still contains 0x10000.
>
> How kernel code running in PR=0 accesses it and does the copy. I am  
> not able to see a address space switch in the asm code of  
> copy_tofrom_user.

There isn't a address space switch.  But address spaces exist at the  
same time.  The user app is given 0..0xc000_0000 and the kernel uses  
0xc000_0000..0xffff_ffff.

- k
