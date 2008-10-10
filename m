Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18671.1955.407703.974646@cargo.ozlabs.ibm.com>
Date: Fri, 10 Oct 2008 18:43:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] remove bogus ppc_select syscall
In-Reply-To: <1223612981.8157.146.camel@pasglop>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop>
	<200809240823.12484.arnd@arndb.de>
	<200809240839.14902.arnd@arndb.de>
	<1223612981.8157.146.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> On Wed, 2008-09-24 at 08:39 +0200, Arnd Bergmann wrote:
> > The ppc_select function was introduced in linux-2.3.48 in order to support
> > code confusing the legacy select() calling convention with the standard one.
> > Even 11 years ago, all correctly built code should not have done this and
> > could have easily been phased out. Nothing that was compiled later should
> > actually try to use the old_select interface, and it would have been broken
> > already on all ppc64 kernels with the syscall emulation layer.
> > 
> > This patch brings the 32 bit compat ABI and the native 32 bit ABI for
> > powerpc into a consistent state, by removing support for both the
> > old_select system call number and the handler for it.
> 
>  .../...
> 
> It's me or the patch is whitespaces damaged ?

Please don't apply Arnd's patch.  As I said, all we need is this
one-line change in arch/powerpc/include/asm/systbl.h:

-SYSX_SPU(sys_select,ppc32_select,ppc_select)
+SYSX_SPU(sys_select,ppc32_select,sys_select)

Paul.
