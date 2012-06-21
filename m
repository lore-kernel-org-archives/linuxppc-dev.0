Return-Path: <michael@ellerman.id.au>
Message-ID: <1340262473.1998.19.camel@concordia>
Subject: Re: linux-next: build failure after merge of the final tree
 (powerpc related)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Jun 2012 17:07:53 +1000
In-Reply-To: <1340259896.3942.2.camel@pasglop>
References: <20120620175014.a822a766e0f91f7b44f48fa0@canb.auug.org.au>
 <1340256961.1998.11.camel@concordia> <1340259896.3942.2.camel@pasglop>
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

On Thu, 2012-06-21 at 16:24 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2012-06-21 at 15:36 +1000, Michael Ellerman wrote:
> >=20
> > powerpc64-linux-ld: /src/next/net/openvswitch/vport-netdev.c:189:(.text=
+0x89b990):=20
> >         sibling call optimization to `_restgpr0_28' does not allow auto=
matic multiple TOCs;
> >         recompile with -mminimal-toc or -fno-optimize-sibling-calls, or=
 make `_restgpr0_28' extern
> >=20
> >=20
> > And those are generated calls so I don't see how we can fix them.
>=20
> Is this a module ? We should really be linking that stuff directly with t=
he module....

No, it's builtin.

> The interesting thing is that we do build everything except a handful of
> files with -mminimal-toc unless something's wrong with our main Makefile.=
...

Yeah, the top arch Makefile sets it, though we do override it in a few
places. I tried removing those overrides and it didn't seem to make any
difference.

> Can you show the full build command that triggers the above ?

Well that would be a few MBs of log, but here's an excerpt:

make -f scripts/Makefile.build obj=3Dnet/openvswitch
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
dwarf2-cfi-asm -mno-string -mno-sched-epilog -Wa,-maltivec -fno-reorder-blo=
cks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-than=3D2048 -fno=
-stack-protector -Wno-unused-but-set-variable -g -femit-struct-debug-baseon=
ly -pg -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno=
-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO  -fp=
rofile-arcs -ftest-coverage    -D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3D=
KBUILD_STR(vport_netdev)"  -D"KBUILD_MODNAME=3DKBUILD_STR(openvswitch)" -c =
-o net/openvswitch/.tmp_vport-netdev.o net/openvswitch/vport-netdev.c
  if [ "-pg" =3D "-pg" ]; then set -e ; perl /home/michael/src/kmk/next/scr=
ipts/recordmcount.pl "powerpc" "little" "64" "/opt/cross/gcc-4.6-nolibc/pow=
erpc64-linux/bin/powerpc64-linux-objdump" "/opt/cross/gcc-4.6-nolibc/powerp=
c64-linux/bin/powerpc64-linux-objcopy" "/opt/cross/gcc-4.6-nolibc/powerpc64=
-linux/bin/powerpc64-linux-gcc -m64 -Wall -Wundef -Wstrict-prototypes -Wno-=
trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declar=
ation -Wno-format-security -fno-delete-null-pointer-checks -Os -msoft-float=
 -pipe -Iarch/powerpc -mminimal-toc -mtraceback=3Dno -mcall-aixdesc -mtune=
=3Dpower7 -mtune=3Dcell -mno-altivec -mno-vsx -mno-spe -mspe=3Dno -funit-at=
-a-time -fno-dwarf2-cfi-asm -mno-string -mno-sched-epilog -Wa,-maltivec -fn=
o-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining -Wframe-larger-tha=
n=3D2048  -fno-stack-protector -Wno-unused-but-set-variable -g  -femit-stru=
ct-debug-baseonly -pg  -fno-inline-functions-called-once -Wdeclaration-afte=
r-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HA=
VE_ASM_GOTO" "/opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-linux=
-ld -m elf64ppc" "/opt/cross/gcc-4.6-nolibc/powerpc64-linux/bin/powerpc64-l=
inux-nm --synthetic" "" "" "0" "net/openvswitch/vport-netdev.o"; fi;

And then a whole bunch of calls to ld.

So we are at least building that file with -mminimal-toc.

cheers
