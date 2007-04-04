Return-Path: <scottm@somanetworks.com>
Received: from mail.somanetworks.com (mailhost.somanetworks.com
	[216.126.67.42])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.somanetworks.com",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A0A4DDEFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 06:16:36 +1000 (EST)
Date: Wed, 4 Apr 2007 16:09:16 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
To: Clint Thomas <cthomas@Soneticom.com>
Subject: Re: MPC8555CDS ELDK build issue
In-Reply-To: <3C02138692C13C4BB675FE7EA2409529327F9A@bluefin.Soneticom.local>
Message-ID: <Pine.LNX.4.64.0704041550170.10014@rancor.yyz.somanetworks.com>
References: <3C02138692C13C4BB675FE7EA2409529327F9A@bluefin.Soneticom.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 4 Apr 2007, Clint Thomas wrote:

> Hey,
> 
> Using the ELDK 4.1, I am trying to compile the linux sources for the
> MPC8555CDS. I installed the source tree provided with ELDK 4.1 (2.6.19)
> and the associated crosstools. The only factors I changed in the kernel
> config were to set the processor arch to e500 and the platform to
> 8555CDS. When I run make, this is where it fails.
> 
> CC      arch/ppc/syslib/mpc85xx_devices.o
> arch/ppc/syslib/mpc85xx_devices.c:99: error: 'F1_RXCLK' undeclared here
> (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:99: error: 'F1_TXCLK' undeclared here
> (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:117: error: 'F2_RXCLK' undeclared here
> (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:117: error: 'F2_TXCLK' undeclared here
> (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:135: error: 'F3_RXCLK' undeclared here
> (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:135: error: 'F3_TXCLK' undeclared here
> (not in a function)
> make[1]: *** [arch/ppc/syslib/mpc85xx_devices.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
>
> This is the exact same build error I get when compiling with the same
> cross-tools, using several other version of the Linux kernel. Any of the
> Freescale guys know why this is? Thanks

I saw this, but forgot to report it, oops.  Adding a:

#include <platforms/85xx/mpc85xx_ads_common.h>

at the top of the file gets it to compile, and seemed to result in a 
working image on our MPC8555CDS, but it didn't seem like an overly clean 
fix to me.  On 2.6.19, I also needed this fix:

--- 1.18/include/asm-ppc/cpm2.h 2006-08-19 17:44:31 -04:00
+++ 1.18.1.1/include/asm-ppc/cpm2.h     2006-12-04 18:42:00 -05:00
@@ -1186,7 +1186,7 @@
 #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
 #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
-#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
+#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */

This typo is fixed in newer kernels.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com
