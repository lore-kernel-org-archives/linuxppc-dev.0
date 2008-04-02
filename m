Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18418.55835.338209.611273@cargo.ozlabs.ibm.com>
Date: Wed, 2 Apr 2008 11:58:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
In-Reply-To: <5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Hmm, need to think about that.  But my initial reaction is two fold.   
> One I don't think this information would be around and two don't we  
> already have this problem with a kdump kernel?

I'm just concerned that we have two things that have to match up - the
compiled-in physical address that the kernel assumes it is running at,
and the physical address where it is actually loaded.  While those two
things were both always 0 for embedded processors, there wasn't a
problem, but now we can have a situation where a kernel binary has to
be loaded at some nonzero address to work correctly, but there is no
way to work out what that address is for an existing vmlinux binary.
Or have I missed something?

For a kdump kernel, at least for 64-bit, the physical address has to
be 32MB.  There is no other choice, so there is no possibility of
confusion.

For 85xx, would it be possible to have the kernel figure out what
physical address it has been loaded at, and use that as the base
address, rather than having the base address set at compile time?
That would solve my objection since it would mean that there would no
longer be two things that had to be kept in sync.  You could pass any
value to wrapper/mkimage (subject to constraints such as it has to be
a multiple of 256M) and it would work.  That value could even come
from a config option in the case where wrapper is invoked as part of
the kernel build, but that config option shouldn't affect anything at
all in the vmlinux.

Paul.
