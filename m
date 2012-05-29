Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 20BBEB6FA3
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 04:29:59 +1000 (EST)
In-Reply-To: <4FC511C1.4050007@mindchasers.com>
References: <OF00FC5182.FED0E75C-ONC1257A0D.003AA532-C1257A0D.0041F687@transmode.se>
 <4FC511C1.4050007@mindchasers.com>
Subject: Re: MSR loses DE bit in 3.3, BDI2000 cant handle breakpoints?
To: Bob Cochran <ppc@mindchasers.com>
Message-ID: <OF5076A83F.4EC6EBD3-ONC1257A0D.0064D589-C1257A0D.00659D47@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 May 2012 20:29:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bob Cochran <ppc@mindchasers.com> wrote on 2012/05/29 20:13:21:
>
> On 05/29/2012 08:00 AM, Joakim Tjernlund wrote:
> >
> > I cannot make simple break points using BDI2000 work in 3.3, abatro suggests that it
> > depends on MSR[DE] is cleared by the kernel. With the emulator I can see that
> > MSR[DE] is off quite often by just stopping at random times and looking at MSR so
> > it seems like the kernel is turning MSR[DE] off most of the time.
> > Anyone else having success debugging 3.3 with BDI2000?
> >
> > This is on a P2010(E500/BOOKE) CPU.
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
>
> I debug using Freescale CodeWarrior and a USB tap, which also rely on
> MSR[DE] being set.  I develop from the mainline & have a patch set that
> I just recently re-tweaked to support kernel debugging.
>
> If you want, I'll send you my set of patches for the kernel.  They might
> be useful (not sure since I don't use BDI).

Thanks, that could be useful, however I just figured something out.
Changing
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 500fe1d..0cb259b 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -37,7 +37,7 @@
 #define MSR_KERNEL     (MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER       (MSR_KERNEL|MSR_PR|MSR_EE)
 #else
-#define MSR_KERNEL     (MSR_ME|MSR_RI|MSR_CE)
+#define MSR_KERNEL     (MSR_ME|MSR_RI|MSR_CE|MSR_DE)
 #define MSR_USER       (MSR_KERNEL|MSR_PR|MSR_EE)
 #endif

Made it work(possible one should change MSR_USER too?)

Question now is why MSR_DE is not on by default? Especially since
BDI2000 is supported by the kernel(CONFIG_BDI_SWITCH=y) is on in my kernel?

 Jocke
