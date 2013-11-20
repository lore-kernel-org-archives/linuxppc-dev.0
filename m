Return-Path: <scottwood@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DAF92C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 09:03:29 +1100 (EST)
Message-ID: <1384984996.1403.430.camel@snotra.buserror.net>
Subject: Re: [RFC][PATCH] powerpc/CoreNet64: compile with
 CONFIG_E{5,6}500_CPU well
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 20 Nov 2013 16:03:16 -0600
In-Reply-To: <CC3170D1-8CF3-4A84-B585-BC753023DE6E@kernel.crashing.org>
References: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
 <1384965671.1403.414.camel@snotra.buserror.net>
 <CC3170D1-8CF3-4A84-B585-BC753023DE6E@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 12:47 -0600, Kumar Gala wrote:
> On Nov 20, 2013, at 10:41 AM, Scott Wood <scottwood@freescale.com> wrot=
e:
>=20
> > On Wed, 2013-11-20 at 16:35 +0800, Tiejun Chen wrote:
> >> CONFIG_ALTIVEC is always enabled for CoreNet64.
> >=20
> > In the defconfig perhaps, but this isn't a generally true statement.
> >=20
> >> And if we select CONFIG_E{5,6}500_CPU this may introduce -mcpu=3De50=
0mc64
> >> into $CFLAGS. But Altivec and Spe options not allowed with
> >> e500mc64, so :
> >=20
> > Sigh.
> >=20
> >>  CC      arch/powerpc/lib/xor_vmx.o
> >> arch/powerpc/lib/xor_vmx.c:1:0: error: AltiVec not supported in this=
 target
> >> make[1]: *** [arch/powerpc/lib/xor_vmx.o] Error 1
> >> make: *** [arch/powerpc/lib] Error 2
> >>=20
> >> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> >> ---
> >> arch/powerpc/lib/Makefile |    3 +++
> >> 1 file changed, 3 insertions(+)
> >>=20
> >> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> >> index 95a20e1..641a77d 100644
> >> --- a/arch/powerpc/lib/Makefile
> >> +++ b/arch/powerpc/lib/Makefile
> >> @@ -40,5 +40,8 @@ obj-y			+=3D code-patching.o
> >> obj-y			+=3D feature-fixups.o
> >> obj-$(CONFIG_FTR_FIXUP_SELFTEST) +=3D feature-fixups-test.o
> >>=20
> >> +# Altivec and Spe options not allowed with e500mc64 in GCC.
> >> +ifeq ($(call cc-option-yn,-mcpu=3De500mc64),n)
> >> obj-$(CONFIG_ALTIVEC)	+=3D xor_vmx.o
> >> CFLAGS_xor_vmx.o +=3D -maltivec -mabi=3Daltivec
> >> +endif
> >=20
> > This does not seem like the right fix.  What if GCC supports both
> > -mcpu=3De500mc64 and -mcpu=3De6500, and we're using the latter?  Or f=
or that
> > matter, if we're using -mcpu=3Dwhatever-ibm-chip-has-this?
> >=20
> > Plus, wouldn't you need to do something to prevent code in that file
> > from being called?
> >=20
> > -Scott
>=20
> Why does -mcpu=3De500mc64 get you spe enabled?  It shouldn=E2=80=99t as=
 no e500mc or greater part has spe.  Can you try using -mno-spe -maltivec=
?

I don't think SPE is relevant.  The problem is that GCC refuses to allow
-maltivec to be combined with -mcpu=3De500mc64.  -mno-spe doesn't make a
difference.

-Scott
