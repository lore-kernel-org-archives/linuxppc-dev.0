Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11E3F2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 11:01:51 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 19:01:47 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BA3CC6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 21:01:39 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7A11iLX178688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:01:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7A11hp5003228
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 21:01:44 -0400
Date: Fri, 9 Aug 2013 18:01:19 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build errors on mainline kernel
Message-ID: <20130810010119.GA29407@us.ibm.com>
References: <20130809182446.GA26711@us.ibm.com>
 <EA801718-CA2E-4F85-AF6B-29119911038E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EA801718-CA2E-4F85-AF6B-29119911038E@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala [galak@kernel.crashing.org] wrote:
|=20
| >=20
| > The pre-processor output for the first WARN_ON() is:
| >=20
| > ---
| > ({ int __ret_warn_on =3D !!(nr < 0 || nr >=3D 32); if (__builtin_consta=
nt_p(__ret_warn_on)) { if (__ret_warn_on) do { __asm__ __volatile__( "1:   =
 twi 31,0,0\n" ".section __bug_table,\"a\"\n" "2:\t" ".llong" " " "1b, %0\n=
" "\t.short %1, %2\n" ".org 2b+%3\n" ".previous\n" : : "i" ("/root/tmp/linu=
x.git/arch/powerpc/platforms/85xx/smp.c"), "i" (154), "i" (((1 << 0) | ((9)=
 << 8))), "i" (sizeof(struct bug_entry))); } while (0); } else { __asm__ __=
volatile__( "1:      ""tdnei" " ""   %4,0\n" ".section __bug_table,\"a\"\n"=
 "2:\t" ".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previo=
us\n" : : "i" ("/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"), "i=
" (154), "i" (((1 << 0) | ((9) << 8))), "i" (sizeof(struct bug_entry)), "r"=
 (__ret_warn_on)); } __builtin_expect(!!(__ret_warn_on), 0); });
| >=20
| > ---
| >=20
| >=20
| > Should I be doing something different to build with these configs ?
| >=20
|=20
| Hmm, that is odd.
|=20
| How about doing:
|=20
| $ make V=3D1
|=20
| so we can see what compiler flags are being passed around.

Sure.=20

make -f /root/tmp/linux.git/scripts/Makefile.build obj=3Darch/powerpc/platf=
orms/85xx arch/powerpc/platforms/85xx/smp.o
  gcc -m64 -Wp,-MD,arch/powerpc/platforms/85xx/.smp.o.d  -nostdinc -isystem=
 /usr/lib/gcc/ppc64-redhat-linux/4.4.6/include -I/root/tmp/linux.git/arch/p=
owerpc/include -Iarch/powerpc/include/generated  -I/root/tmp/linux.git/incl=
ude -Iinclude -I/root/tmp/linux.git/arch/powerpc/include/uapi -Iarch/powerp=
c/include/generated/uapi -I/root/tmp/linux.git/include/uapi -Iinclude/gener=
ated/uapi -include /root/tmp/linux.git/include/linux/kconfig.h  -I/root/tmp=
/linux.git/arch/powerpc/platforms/85xx -Iarch/powerpc/platforms/85xx -D__KE=
RNEL__  -I/root/tmp/linux.git/arch/powerpc -Iarch/powerpc -Wall -Wundef -Ws=
trict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-im=
plicit-function-declaration -Wno-format-security -fno-delete-null-pointer-c=
hecks -O2 -msoft-float -pipe  -I/root/tmp/linux.git/arch/powerpc -Iarch/pow=
erpc -mtraceback=3Dno -mcall-aixdesc -mcmodel=3Dmedium -mtune=3Dpower7 -mno=
-altivec -mno-vsx -mno-spe -mspe=3Dno -funit-at-a-time -fno-dwarf2-cfi-asm =
-mno-string -Wa,-me500 -Wframe-larger-than=3D2048 -fno-stack-protector -Wno=
-unused-but-set-variable -fomit-frame-pointer -Wdeclaration-after-statement=
 -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO=
    -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DKBUILD_STR(smp)"  -D"KBUILD=
_MODNAME=3DKBUILD_STR(smp)" -c -o arch/powerpc/platforms/85xx/.tmp_smp.o /r=
oot/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c
{standard input}: Assembler messages:
{standard input}:244: Error: junk at end of line: `1'
make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2
make: *** [sub-make] Error 2
