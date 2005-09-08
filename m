Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <0C620F0B-92B0-4EBF-BC0C-49FD4D3D4323@freescale.com>
References: <0C620F0B-92B0-4EBF-BC0C-49FD4D3D4323@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <ac556638e1f4b4f9786c30ed0debc4a8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 8 Sep 2005 19:01:18 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: r13 is non-volatile?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Was looking at merging some code between ppc32 & ppc64 and noticed 
> that in ppc32 we consider r13 to be part of the non-volatile register 
> set.  Is this really correct?

I believe so, yes.

> r13 is suppose to be sdata pointer in ppc32

sdata pointer is non-volatile by definition...

> and system thread id in ppc64.

The 64-bit kernel uses GPR13 as the PACA pointer, so it handles
it specially -- it treats the userland values of the register
as non-volatile, though.

> So I'm wondering should we really be considering it NV on ppc32?

Yeah.  I'm sure there is some way to make the macro's identical
between 32- and 64-bit, though.


Segher
