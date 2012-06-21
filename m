Return-Path: <michael@ellerman.id.au>
Message-ID: <1340264307.1998.20.camel@concordia>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc related)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Jun 2012 17:38:27 +1000
In-Reply-To: <1340262473.1998.19.camel@concordia>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
 <1340256961.1998.11.camel@concordia> <1340259896.3942.2.camel@pasglop>
 <1340262473.1998.19.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-21 at 17:07 +1000, Michael Ellerman wrote:
> On Thu, 2012-06-21 at 16:24 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2012-06-21 at 15:36 +1000, Michael Ellerman wrote:
> > >=20
> > > powerpc64-linux-ld: /src/next/net/openvswitch/vport-netdev.c:189:(.te=
xt+0x89b990):=20
> > >         sibling call optimization to `_restgpr0_28' does not allow au=
tomatic multiple TOCs;
> > >         recompile with -mminimal-toc or -fno-optimize-sibling-calls, =
or make `_restgpr0_28' extern
> > >=20
> > Can you show the full build command that triggers the above ?
>=20
> Well that would be a few MBs of log, but here's an excerpt:
>=20
> make -f scripts/Makefile.build obj=3Dnet/openvswitch
>   /opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -m64 =
-Wp,-MD,net/openvswitch/.vport-netdev.o.d  -nostdinc -isystem /opt/cross/gc=
c-4.6.3-nolibc/powerpc64-linux/lib/gcc/powerpc64-linux/4.6.3/include -I/hom=
e/michael/src/kmk/next/arch/powerpc/include -Iarch/powerpc/include/generate=
d -Iinclude  -include /home/michael/src/kmk/next/include/linux/kconfig.h -D=
__KERNEL__ -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs =
-fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno=
-format-security -fno-delete-null-pointer-checks -Os -msoft-float -pipe -Ia=
rch/powerpc -mminimal-toc -mtraceback=3Dno -mcall-aixdesc -mtune=3Dpower7 -=
mtune=3Dcell -mno-altivec -mno-vsx -mno-spe -mspe=3Dno -funit-at-a-time -fn=
o-dwarf2-cfi-asm -mno-string -mno-sched-epilog -Wa,-maltivec -fno-reorder-b=
locks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=3D2048 -f=
no-stack-protector -Wno-unused-but-set-variable -g -femit-struct-debug-base=
only -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -W=
no-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO  -=
fprofile-arcs -ftest-coverage    -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=
=3DKBUILD_STR(vport_netdev)"  -D"KBUILD_MODNAME=3DKBUILD_STR(openvswitch)" =
-c -o net/openvswitch/.tmp_vport-netdev.o net/openvswitch/vport-netdev.c
>   if [ "-pg" =3D "-pg" ]; then set -e ; perl /home/michael/src/kmk/next/s=
cripts/recordmcount.pl "powerpc" "little" "64" "/opt/cross/gcc-4.6-nolibc/p=
owerpc64-linux/bin/powerpc64-linux-objdump" "/opt/cross/gcc-4.6-nolibc/powe=
rpc64-linux/bin/powerpc64-linux-objcopy" "/opt/cross/gcc-4.6-nolibc/powerpc=
64-linux/bin/powerpc64-linux-gcc -m64 -Wall -Wundef -Wstrict-prototypes -Wn=
o-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-decl=
aration -Wno-format-security -fno-delete-null-pointer-checks -Os -msoft-flo=
at -pipe -Iarch/powerpc -mminimal-toc -mtraceback=3Dno -mcall-aixdesc -mtun=
e=3Dpower7 -mtune=3Dcell -mno-altivec -mno-vsx -mno-spe -mspe=3Dno -funit-a=
t-a-time -fno-dwarf2-cfi-asm -mno-string -mno-sched-epilog -Wa,-maltivec -f=
no-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-th=
an=3D2048  -fno-stack-protector -Wno-unused-but-set-variable -g  -femit-str=
uct-debug-baseonly -pg  -fno-inline-functions-called-once -Wdeclaration-aft=
er-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_H=
AVE_ASM_GOTO" "/opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-linu=
x-ld -m elf64ppc" "/opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-=
linux-nm --synthetic" "" "" "0" "net/openvswitch/vport-netdev.o"; fi;

Just for the record it's not the FTRACE stuff (-pg):

  /opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc -m64 -W=
p,-MD,net/openvswitch/.vport-netdev.o.d  -nostdinc -isystem /opt/cross/gcc-=
4.6.3-nolibc/powerpc64-linux/lib/gcc/powerpc64-linux/4.6.3/include -I/home/=
michael/src/kmk/next/arch/powerpc/include -Iarch/powerpc/include/generated =
-Iinclude  -include /home/michael/src/kmk/next/include/linux/kconfig.h -D__=
KERNEL__ -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -f=
no-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-f=
ormat-security -fno-delete-null-pointer-checks -Os -msoft-float -pipe -Iarc=
h/powerpc -mminimal-toc -mtraceback=3Dno -mcall-aixdesc -mtune=3Dpower7 -mt=
une=3Dcell -mno-altivec -mno-vsx -mno-spe -mspe=3Dno -funit-at-a-time -fno-=
dwarf2-cfi-asm -mno-string -Wa,-maltivec -fno-reorder-blocks -fno-ipa-cp-cl=
one -fno-partial-inlining -Wframe-larger-than=3D2048 -fno-stack-protector -=
Wno-unused-but-set-variable -fomit-frame-pointer -g -femit-struct-debug-bas=
eonly -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-=
pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO  -fpr=
ofile-arcs -ftest-coverage    -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DK=
BUILD_STR(vport_netdev)"  -D"KBUILD_MODNAME=3DKBUILD_STR(openvswitch)" -c -=
o net/openvswitch/.tmp_vport-netdev.o net/openvswitch/vport-netdev.c


And same error.

cheers
