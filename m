Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 0E256679E9
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 01:34:22 +1000 (EST)
Date: Wed, 4 May 2005 08:34:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050504153419.GV1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <466e699745cf24e660e296530f6e34dc@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 04, 2005 at 07:28:30AM -0400, Dan Malek wrote:
> 
> On May 4, 2005, at 3:05 AM, Paul Mackerras wrote:
> 
> >+cpu-opt-$(CONFIG_6xx)		+= -mcpu=750 -mtune=7450
> 
> What about cores that aren't CONFIG_6xx (8xx, 4xx, e500, etc.)?

There's two choices.  We can either go down the route x86 has of each
CPU family choice defaulting to a cpu-opt-..., or we could do roughly
what we do today and force the default cpu/tune to be whatever the
default is on gcc-3.3.x (which I assume is really gcc-3.x.x, but..).

Since there are folks working on optimizing toolchains on at least some
of the newer CPUs, I'd be inclined to say we should do something like
cpu-opt-y := ... gcc-3.3.x defaults ...
cpu-opt-$(CONFIG_6xx) := -mcpu=750 -mtune=7450
cpu-opt-$(CONFIG_8xx) := -mcpu=800 -mtune=800 # Or whatever it is..

CFLAGS += $(cpu-opt-y)

> How about we create a CONFIG_GCC_CPUOPT and
> CONFIG_AS_OPT, and just get these out of the configuration file?

Ick.  It's possible, but unfun, to go from CONFIG_FOO="string" to
cflags. 

-- 
Tom Rini
http://gate.crashing.org/~trini/
