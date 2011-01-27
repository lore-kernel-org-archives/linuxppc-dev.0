Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13E55B711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 07:04:40 +1100 (EST)
Date: Thu, 27 Jan 2011 14:04:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/7] PowerPC: add unlikely() to BUG_ON()
Message-ID: <20110127140420.2c727f36@udp111988uds.am.freescale.net>
In-Reply-To: <4D41B213.4070606@caviumnetworks.com>
References: <1296130356-29896-1-git-send-email-bosong.ly@taobao.com>
	<1296130356-29896-3-git-send-email-bosong.ly@taobao.com>
	<4D41B213.4070606@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Coly Li <bosong.ly@taobao.com>,
	linux-kernel@vger.kernel.org, Yong Zhang <yong.zhang0@gmail.com>,
	Wang Cong <xiyou.wangcong@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Jan 2011 09:57:39 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> On 01/27/2011 04:12 AM, Coly Li wrote:
> > diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> > index 065c590..10889a6 100644
> > --- a/arch/powerpc/include/asm/bug.h
> > +++ b/arch/powerpc/include/asm/bug.h
> > @@ -2,6 +2,7 @@
> >   #define _ASM_POWERPC_BUG_H
> >   #ifdef __KERNEL__
> >
> > +#include<linux/compiler.h>
> >   #include<asm/asm-compat.h>
> >
> >   /*
> > @@ -71,7 +72,7 @@
> >   	unreachable();						\
> >   } while (0)
> >
> > -#define BUG_ON(x) do {						\
> > +#define __BUG_ON(x) do {					\
> >   	if (__builtin_constant_p(x)) {				\
> >   		if (x)						\
> >   			BUG();					\
> > @@ -85,6 +86,8 @@
> >   	}							\
> >   } while (0)
> >
> > +#define BUG_ON(x) __BUG_ON(unlikely(x))
> > +
> 
> This is the same type of frobbing you were trying to do to MIPS.
> 
> I will let the powerpc maintainers weigh in on it, but my opinion is 
> that, as with MIPS, BUG_ON() is expanded to a single machine 
> instruction, and this unlikely() business will not change the generated 
> code in any useful way.  It is thus gratuitous code churn and 
> complexification.

What about just doing this:

#define BUG() __builtin_trap()

#define BUG_ON(x) do {	\
	if (x) \
		BUG(); \
} while (0)

GCC should produce better code than forcing it into twnei.  A simple
BUG_ON(x != y) currently generates something like this (GCC 4.3):

xor     r0,r11,r0
addic   r10,r0,-1
subfe   r9,r10,r0
twnei   r9,0

Or this (GCC 4.5):

xor     r0,r11,r0
cntlzw	r0,r0
srwi	r0,r0,5
xori	r0,r0,1
twnei   r0,0

Instead of:

twne	r0,r11

And if GCC doesn't treat code paths that lead to __builtin_trap() as
unlikely (which could make a difference with complex expressions,
even with a conditional trap instruction), that's something that could
and should be fixed in GCC.

The downside is that GCC says, "The mechanism used may vary from
release to release so you should not rely on any particular
implementation."  However, some architectures (sparc, m68k, ia64)
already use __builtin_trap() for this, it seems unlikely that future GCC
versions would switch away from using the trap instruction[1], and there
doesn't seem to be a better-defined way to make GCC generate trap
instructions intelligently.

-Scott

[1] A more likely possibility is that an older compiler just generates a
call to abort() or similar, and later versions implemented trap -- need
to check what the oldest supported GCC does.
