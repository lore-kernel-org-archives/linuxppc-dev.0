Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18365.638.273636.570276@cargo.ozlabs.ibm.com>
Date: Thu, 21 Feb 2008 15:47:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: Question about PPC_NATIVE/hash_native_64.c
In-Reply-To: <20080220115713.193460@gmx.net>
References: <20080220115713.193460@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Pircher writes:

> I'm a little bit confused about the hash_native_64.c file, which is compiled
> in the kernel, if PPC_NATIVE is defined. PPC_NATIVE seems to be defined also
> for 32bit platforms (CHRP, PREP, etc.), but the name of the hash_native_64.c
> file and the Makefile suggest that it is for 64bit platforms only.
> What is hash_native_64.c actually good for on 32bit platforms and which cpus
> can make use of it?

It's not included on 32-bit platforms.  Here are the relevant lines
from arch/powerpc/mm/Makefile:

hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
				   slb_low.o slb.o stab.o mmap.o $(hash-y)

Note that the first line sets hash-y not obj-y, and $(hash-y) is only
used on 64-bit machines.

Paul.
