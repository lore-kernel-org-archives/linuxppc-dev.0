Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18466.38047.531381.157886@cargo.ozlabs.ibm.com>
Date: Thu, 8 May 2008 15:50:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: nick.spence@freescale.com
Subject: Re: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM non-cached.
In-Reply-To: <1210224392246-git-send-email-nick.spence@freescale.com>
References: <1210224392246-git-send-email-nick.spence@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

nick.spence@freescale.com writes:

> This patch re-introduces the O_SYNC flag to make DRAM non-cached, which is the default behavior
> for non PowerPC architectures in /drivers/char/mem.c

This says nothing about why you want to do this---what bad things
arise from the present code, or what good things would happen if the
change was made.  It needs to.

The change isn't acceptable as it is, because IBM machines with a
hypervisor don't allow system memory to be mapped uncacheable.  It
would at least have to have some platform-specific check in there.

On other powerpc platforms, this would introduce possible cache
paradoxes, where a page is mapped cacheable at one address (via the
linear mapping) and uncacheable at another address (via /dev/mem).  If
you really really want to do this, you'll need to add code to bust up
the large pages (or TLB entries) used for the linear mapping so that
the corresponding pages of the linear mapping can be unmapped, or
mapped cacheable.  Plus you'll need to add the appropriate cache
flushing code to make sure there aren't any cache lines for the page
in cache.  Further, you'll need to arrange somehow to make sure that
the kernel stack has a resident TLB entry during the unrecoverable
parts of the exception entry and exit paths.

Paul.
