Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19215.15368.477999.332414@drongo.ozlabs.ibm.com>
Date: Fri, 27 Nov 2009 13:40:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] powerpc/mm: honor O_SYNC flag for memory mapping
In-Reply-To: <1259222529-27645-1-git-send-email-leoli@freescale.com>
References: <1259222529-27645-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang writes:

> There was no way to set mapped memory as cacheable if the memory
> is not managed by Linux kernel.  It's not rare in real system to
> allocate some dedicated memory to a certain application which is not
> managed by kernel and then mmap'ed the memory to the application.
> The memory should be cacheable but we can't map it to be cacheable
> due to the intelligent setting of cacheability.
> 
> The patch makes the cacheability depend on O_SYNC flag of the file
> mapped for non-kernel managed memory.  Also prints a deprecation
> warning for mmap users without using O_SYNC.

NAK, since it is an incompatible change to the kernel ABI.

What sort of memory is this that you want to map as cacheable?  Is it
normal system RAM that your platform code reserves, or is it some
other kind of memory?

If it's the normal system RAM, you could make phys_mem_access_prot()
smart enough to recognize that (by looking in the lmb array or the
device tree).

If it's another kind of memory, it should be described in the device
tree, and you could have a platform-specific phys_mem_access_prot
function for your platform that looks in the device tree to see if the
memory being mapped is this special sort of memory.

Paul.
