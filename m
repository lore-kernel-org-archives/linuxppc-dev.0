Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
In-reply-to: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
Date: Fri, 07 Dec 2012 16:54:12 +1100
Message-ID: <22874.1354859652@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> commit 279c0615917b959a652e81f4ad0d886e2d426d85
> Author: Jimi Xenidis <jimix@pobox.com>
> Date:   Wed Dec 5 13:43:22 2012 -0500
> 
>     powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
>     
>     This enables kernel support for the QPX extention and is intended for
>     processors that support it, usually an IBM Blue Gene processor.
>     Turning it on does not effect other processors but it does add code
>     and will quadruple the per thread save and restore area for the FPU
>     (hense the name).  If you have enabled VSX it will only double the
>     space.
>     
>     Signed-off-by: Jimi Xenidis <jimix@pobox.com>

Can you give a diagram of how the QPX registers are layed out.

+#if defined(CONFIG_PPC_QPX)
+#define TS_FPRWIDTH 4
+#elif defined(CONFIG_VSX)

Are they 256 bits wide?


+#define QVLFDXA(QRT,RA,RB)	\
+	.long (0x7c00048f | ((QRT) << 21) | ((RA) << 16) | ((RB) << 11))

Put this in ppc-opcode.h.

+#if defined(CONFIG_VSX) || defined(CONFIG_PPC_QPX)
+	/* they are the same MSR bit */

OMG!


+BEGIN_FTR_SECTION							\
+	SAVE_32VSRS(n,c,base);						\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+BEGIN_FTR_SECTION							\
+	SAVE_32QRS(n,c,base);						\
+END_FTR_SECTION_IFSET(CPU_FTR_QPX);	

I don't think we want to do this.  We are going to end up with 64
NOPS here somewhere.

I'd like to see this patch broken into different parts.

Also, have you boot tested this change on a VSX enabled box?

Mikey
