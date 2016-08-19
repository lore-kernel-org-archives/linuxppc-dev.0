Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sGDv81bGCzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 06:23:47 +1000 (AEST)
Date: Fri, 19 Aug 2016 15:23:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: TM Bad Thing exception easily raised from userspace
Message-ID: <20160819202331.GA18558@gate.crashing.org>
References: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Completely off-topic, but...

On Fri, Aug 19, 2016 at 07:21:44PM +0200, Laurent Dufour wrote:
>     asm __volatile__(
> 	"li		3,1		;"
> 	"tbegin.			;"
> 	"beq		1f		;"
> 	"li		3,0		;"
> 	"tsuspend.			;"
> 	"1:				;"
> 	"std		3, %[ret]	;"
> 	: [ret]"=m"(ret)
> 	:
> 	: "memory", "3");

This asm clobbers CR0, so you should add a "cc" or "cr0" clobber here.
When you use "m" you need "%X" as well, i.e.
	std%X[ret] 3,%[ret]

(Nowadays you only need "%U" if you use "m<>", but you still need "%X".
Come to think of it, the kernel supports really old GCC, right?  So you
need "std%U[ret]%X[ret] 3,%[ret]").

>     asm __volatile__(
> 	"tbegin.			;"
> 	"beq		1f		;"
> 	"li		3,0		;"
> 	"std		3,0(3)		;" /* Oups ! */
> 	"1:				;"
> 	"tend.				;"
> 	);

Here "cc" (or "cr0"), too.


Segher
