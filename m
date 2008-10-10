Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] remove bogus ppc_select syscall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18671.1955.407703.974646@cargo.ozlabs.ibm.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop> <200809240823.12484.arnd@arndb.de>
	<200809240839.14902.arnd@arndb.de> <1223612981.8157.146.camel@pasglop>
	<18671.1955.407703.974646@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 11 Oct 2008 10:17:52 +1100
Message-Id: <1223680673.8157.166.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-10 at 18:43 +1100, Paul Mackerras wrote:
> > It's me or the patch is whitespaces damaged ?
> 
> Please don't apply Arnd's patch.  As I said, all we need is this
> one-line change in arch/powerpc/include/asm/systbl.h:
> 
> -SYSX_SPU(sys_select,ppc32_select,ppc_select)
> +SYSX_SPU(sys_select,ppc32_select,sys_select)

Ok, so you want to keep compat with the old stuff. Note that we still
have this weird thing that on 64-bit kernels, we don't provide this.

Ben.
