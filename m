Return-Path: <giu.lippolis@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqc371H4ZzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:28:03 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id n11so22429750wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 14:28:03 -0700 (PDT)
From: "Giuseppe Lippolis" <giu.lippolis@gmail.com>
To: "'Scott Wood'" <oss@buserror.net>,
	<linuxppc-dev@lists.ozlabs.org>
References: <004201d1b85c$75353ba0$5f9fb2e0$@gmail.com>
 <1464998513.22191.38.camel@buserror.net>
In-Reply-To: <1464998513.22191.38.camel@buserror.net>
Subject: AW: problem with cuImage.mpc834x_mds image
Date: Fri, 24 Mar 2017 22:27:58 +0100
Message-ID: <006101d2a4e5$82bebcd0$883c3670$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, 2016-05-27 at 23:12 +0200, Giuseppe Lippolis wrote:
> > Dear All,
> > I'm trying with buildroot to build the linux-4.4.3 for an iomega =
150d
> > machine mounting the mpc8347E sys.

[...]

> > Finalizing device tree... flat tree at 0x94d120
> >
> >
> > But at this point the process crash and the system is reset.
> > It should be something near the handover between the first kenel =
boot
> > stage and the vmlinux start, but I do not have a jtag to proceed the
> > investigation.

[..]

> > Any suggestion?
>=20
> Check (with serial output) that flow control reaches the very end of =
the
> bootwrapper before it jumps to Linux.  Use the same code that you use =
in
> head.S (with loop added in both cases).  Print the entry address, and =
some
> bytes loaded from that address to confirm the image is there.  Check =
that the
> BATs are set up correctly, etc.
>=20
> -Scott

Hi Scott, thanks for your tips.
I proceed my investigation using now Linux-4.10.4 and I found two issue:

1) the U-Boot 1.1.4 make some mistake when decompress the gzip -9. =
Therefore, as a workaround, I currently modify the wrapper to use the =
uncompressed image.

Nevertheless the image is crashing during the boot.

I modified the  cpu_setup_6xx.S in this way (in order to print debug =
char on the console) :

.equ cnsladdr, 0xe0004500

_GLOBAL(__setup_cpu_603)
        mflr    r5
BEGIN_MMU_FTR_SECTION
        li      r10,0
        mtspr   SPRN_SPRG_603_LRU,r10           /* init SW LRU tracking =
*/
END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)

        lis     r23, cnsladdr@ha
        addi    r23, r23, cnsladdr@l
        li      r25, 'i'
        stb     r25, 0(r23)

BEGIN_FTR_SECTION
        bl      __init_fpu_registers

        lis     r23, cnsladdr@ha
        addi    r23, r23, cnsladdr@l
        li      r25, 'l'
        stb     r25, 0(r23)

END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
        bl      setup_common_caches

        lis     r23, cnsladdr@ha
        addi    r23, r23, cnsladdr@l
        li      r25, 'm'
        stb     r25, 0(r23)

        mtlr    r5

        lis     r23, cnsladdr@ha
        addi    r23, r23, cnsladdr@l
        li      r25, 'm'
        stb     r25, 0(r23)
        trap

        blr

and now I get:

Finalizing device tree... flat tree at 0xbdb960
Il

Therefore the code crash during the call in:
        bl      setup_common_caches


I'm using the iomega_150d based on the MPC8347.

Do you have some tips about the setup_common_caches?

Thanks.
Bye.
