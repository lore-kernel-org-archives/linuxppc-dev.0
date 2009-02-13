Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-133.bluehost.com (outbound-mail-133.bluehost.com
	[67.222.39.23]) by ozlabs.org (Postfix) with SMTP id 5B8E7DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 08:20:32 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] pci/msi: Use #ifdefs instead of weak functions
Date: Fri, 13 Feb 2009 13:13:47 -0800
References: <d1c931db79adf22f3506aa0343aec5361600b37e.1232325038.git.michael@ellerman.id.au>
In-Reply-To: <d1c931db79adf22f3506aa0343aec5361600b37e.1232325038.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902131313.48615.jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@redhat.com,
	hpa@zytor.com, linux-pci@atrey.karlin.mff.cuni.cz, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday, January 18, 2009 4:31 pm Michael Ellerman wrote:
> Weak functions aren't all they're cracked up to be. They lead to
> incorrect binaries with some toolchains, they require us to have empty
> functions we otherwise wouldn't, and the unused code is not elided
> (as of gcc 4.3.2 anyway).
>
> So replace the weak MSI arch hooks with the #define foo foo idiom. We no
> longer need empty versions of arch_setup/teardown_msi_irq().
>
> This is less source (by 1 line!), and results in smaller binaries too:
>
>    text	   data	    bss	    dec	    hex	filename
> 9354300	1693916	 678424	11726640 b2ef30	build/powerpc/vmlinux-before
> 9354052	1693852	 678424	11726328 b2edf8	build/powerpc/vmlinux-after
>
> Also smaller on x86_64 and arm (iop13xx).
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Applied to my linux-next branch, thanks Michael.


-- 
Jesse Barnes, Intel Open Source Technology Center
