Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9599367B1F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 07:42:13 +1000 (EST)
In-Reply-To: <20050407173821.GQ3396@smtp.west.cox.net>
References: <20050407173821.GQ3396@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f3f5e13e4c8b3cb7b327fb51db84150d@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 7 Apr 2005 16:41:59 -0500
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2005, at 12:38 PM, Tom Rini wrote:

> On Thu, Mar 31, 2005 at 07:47:32PM +0200, Fillod Stephane wrote:
>
> > When CPU has no (classic) FPU, and math emulation is disabled,
>  > fp instructions are not allowed in kernel mode.
>  [snip]
>  > --- linux/arch/ppc/kernel/misc.S=A0=A0=A0=A0=A0 26 Mar 2005 =
03:28:36 -0000
>  > 1.1.1.2
>  > +++ linux/arch/ppc/kernel/misc.S=A0=A0=A0=A0=A0 31 Mar 2005 =
16:33:25 -0000
>  > @@ -1096,7 +1096,8 @@
>  >=A0=A0 * and exceptions as if the cpu had performed the load or =
store.
>  >=A0=A0 */
>  >=A0
> > -#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> > +#if !(defined(CONFIG_4xx) || defined(CONFIG_E500) ||
>  > defined(CONFIG_8xx)) ||=A0 defined(CONFIG_MATH_EMULATION)
> > +#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> >=A0 _GLOBAL(cvt_fd)
> >=A0 =A0=A0=A0=A0 lfs=A0=A0=A0=A0 0,0(r3)
>  >=A0 =A0=A0=A0=A0 stfd=A0=A0=A0 0,0(r4)
>  > @@ -1125,6 +1126,7 @@
>  >=A0 =A0=A0=A0=A0 stfd=A0=A0=A0 0,-4(r5)
>  >=A0 =A0=A0=A0=A0 blr
>  >=A0 #endif
>  > +#endif
>
> The problem here is, HEY! (classic) FP instrs in the kernel.=A0 The
>  question is why?=A0 Or rather, why are these four classic FP instrs
>  (lfs/lfd/stfd/stfs) being done on CONFIG_4xx || E500 when neither has
>  classic FP?=A0 I think the problem here is that on !FPU
> (which is 4xx||E500||8xx, or so), we need to rewrite these two
>  functions (yes, 8xx does emulate them if hit, but that's a tangent).

What is not clear to me is what condition causes these to get hit on an=20=

e500.

- kumar
