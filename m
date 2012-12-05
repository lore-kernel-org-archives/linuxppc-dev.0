Return-Path: <anton@samba.org>
Date: Wed, 5 Dec 2012 11:07:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc: Relocate prom_init.c on 64bit
Message-ID: <20121205110723.68839261@kryten>
In-Reply-To: <1353993743.2179.28.camel@pasglop>
References: <20121127143903.4b5cab17@kryten> <1353993743.2179.28.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

> My only potential objection was that it might have been cleaner to
> actually build prom_init.c as a separate binary alltogether and piggy
> back it...

Yeah, I went through a number of options before settling on this one.


Move prom_init.c into arch/powerpc/boot

Pros:
- 32 bit environment fits well with 32 bit OF interface
- Clear separation enforced between prom_init.c and rest of kernel
- Can build boot wrapper -mrelocatable, similar to ppc32 kernel

Cons:
- tools that assume we can boot a vmlinux will break.
  - distro bootloader tools
  - provisioning and test environments 
- profiling and debugging tools that currently use a vmlinux will break
  - oprofile, perf
- Places more pressure on already fragile early memory map
  - have to uncompress the zImage somewhere in the RMO
- prom_init.c needs to pull in quite a lot of kernel headers
  - seemed difficult to force them to build 32 bit
- Increased simulator boot times due to uncompress stage


Build prom_init.c 32 bit and attach the vmlinux as a binary blob.

This means a vmlinux will be bootable, but profiling tools still wont
work.


Build prom_init.c 32 bit, tack it onto the end of the vmlinux and
add a trampoline at the start of the vmlinux.

This means a vmlinux will be bootable and profiling tools will work
against it. Even so it feels gross to me.

Anton
