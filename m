Return-Path: <flar@cynthia.pants.nu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3128CB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jul 2009 04:21:40 +1000 (EST)
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id B7EB3DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2009 04:21:39 +1000 (EST)
Date: Fri, 3 Jul 2009 10:40:31 -0700
From: Brad Boyer <flar@allandria.com>
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline assembly queries [2]
Message-ID: <20090703174031.GA12410@cynthia.pants.nu>
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 03, 2009 at 12:14:41PM +0530, kernel mailz wrote:
> Thanks for responding to my previous mail. A few more queries
> 
> a. What is the use of adding format specifiers in inline assembly
> like
> asm volatile("ld%U1%X1 %0,%1":"=r"(ret) : "m"(*ptr) : "memory");

The format specifiers limit which registers or addressing modes will
be chosen to access that parameter. For example, if you're using an
instruction that treats r0 as a literal 0 value, you can't use the
"r" specifier for that or you may see problems if it happens to allocate
r0 for that particular argument. For memory access, the "m" lets you
use any of the normal load/store patterns (which is why this particular
choice also requires the "%U1%X1" part to allow changing the instruction).
The system was setup for an older style chip like x86 or 68k with many
restrictions on which registers can be used where and large numbers of
different addressing modes for accessing memory. It's a little clumsy
for ppc by comparison to most other chips, but it's a fundamental part
of inline assembly processing in gcc.

> b. using m or Z  with a memory address. I tried replacing m/Z but no change
> Is there some guideline ?
> gcc documentation says Z is obsolete. Is m/Z replaceable ?

No idea. I don't remember ever seeing 'Z' used in anything. Maybe somebody
else remembers what it used to mean.

	Brad Boyer
	flar@allandria.com
