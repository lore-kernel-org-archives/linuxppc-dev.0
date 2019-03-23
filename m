Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A29C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 17:02:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B922183E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B922183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RRfb020xzDqBH
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 04:02:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=joe.lawrence@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RRcv2YTVzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 04:01:19 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABA77DBD75;
 Sat, 23 Mar 2019 17:01:16 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18B3860851;
 Sat, 23 Mar 2019 17:01:15 +0000 (UTC)
Date: Sat, 23 Mar 2019 13:01:14 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
Message-ID: <20190323170114.GA1400@redhat.com>
References: <20190323131950.GA30948@redhat.com>
 <20190323121732.59533e78@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190323121732.59533e78@grimm.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 23 Mar 2019 17:01:16 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 23, 2019 at 12:17:32PM -0400, Steven Rostedt wrote:
> On Sat, 23 Mar 2019 09:19:50 -0400
> Joe Lawrence <joe.lawrence@redhat.com> wrote:
>=20
> > Perhaps this is gcc version specific?  I didn't see any other reports,
> > so maybe its specific to my config.  If I run make V=3D1, I can see that
> > gcc is called with '-pg -mprofile-kernel', but then the record_mcount
> > script is skipped.  Any ideas?
>=20
> But you see it running the script if you remove that commit? Do you
> happen to see -mrecord-mcount at all in a V=3D1 make?
>=20

Hey Steve,

Here's a diff of output from 'make V=3D1 kernel/trace/trace_selftest_dynami=
c.o'=20
with stock v5.0 vs. v5.0 and that commit reverted.  The part that I
think is interesting is where it decides to invoke recordmcount.pl

I can send or pastebin the entire output from make if that is easier to
read.

-- Joe

--- v5.0.out	2019-03-23 12:54:09.540042581 -0400
+++ v5.0-revert.out	2019-03-23 12:53:05.253264482 -0400
@@ -20,29 +20,18 @@ make -f ./scripts/Makefile.build obj=3Dscr
 make -f ./scripts/Makefile.build obj=3Dscripts/selinux/genheaders need-bui=
ltin=3D
 make -f ./scripts/Makefile.build obj=3Dscripts/selinux/mdp need-builtin=3D
 make -f ./scripts/Makefile.build obj=3Dscripts/mod
-  gcc -Wp,-MD,scripts/mod/.empty.o.d  -nostdinc -isystem /usr/lib/gcc/ppc6=
4le-redhat-linux/8/include -I./arch/powerpc/include -I./arch/powerpc/includ=
e/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/inc=
lude/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./=
include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNE=
L__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=3Dstrict-prot=
otypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-P=
IE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-form=
at-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -mtracebac=
k=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-functions -m=
cpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf2-cfi-asm -mno=
-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -mlittle-end=
ian -mstack-protector-guard=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-de=
lete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-for=
mat-overflow -Wno-int-in-bool-context -O2 --param=3Dallow-store-data-races=
=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong -Wno-unused-but-se=
t-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g -gdw=
arf-4 -pg -mprofile-kernel -fno-inline-functions-called-once -Wdeclaration-=
after-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-stric=
t-overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fco=
nserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werr=
or=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned    =
-DKBUILD_BASENAME=3D'"empty"' -DKBUILD_MODNAME=3D'"empty"' -c -o scripts/mo=
d/empty.o scripts/mod/empty.c
-  if objdump -h scripts/mod/empty.o | grep -q __ksymtab; then gcc -E -Wall=
 -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -f=
no-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -W=
error=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m64=
 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-p=
ointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mn=
o-vsx   -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-man=
y -mno-strict-align -mlittle-endian -mstack-protector-guard=3Dtls -mstack-p=
rotector-guard-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address=
 -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 -=
-param=3Dallow-store-data-races=3D0  -Wframe-larger-than=3D2048 -fstack-pro=
tector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable  -fno=
-var-tracking-assignments -g -gdwarf-4 -pg -mprofile-kernel    -fno-inline-=
functions-called-once -Wdeclaration-after-statement -Wvla -Wno-pointer-sign=
 -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fm=
erge-constants -fno-stack-check -fconserve-stack -Werror=3Ddate-time -Werro=
r=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmacro-prefix-map=
=3D./=3D -Wno-packed-not-aligned     -D__GENKSYMS__ -Wp,-MD,scripts/mod/.em=
pty.o.d  -nostdinc -isystem /usr/lib/gcc/ppc64le-redhat-linux/8/include -I.=
/arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./a=
rch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./includ=
e/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -inclu=
de ./include/linux/compiler_types.h -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_A=
THIGH=3D1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-str=
ict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function=
-declaration -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -mlit=
tle-endian -m64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=
=3Dmedium -mno-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 =
-mno-altivec -mno-vsx -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mp=
ower4 -Wa,-many -mno-strict-align -mlittle-endian -mstack-protector-guard=
=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-null-pointer-checks -W=
no-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bo=
ol-context -O2 --param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D2=
048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const=
-variable -fno-var-tracking-assignments -g -gdwarf-4 -pg -mprofile-kernel -=
fno-inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wno-p=
ointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-co=
nstants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Ddate-=
time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmacro=
-prefix-map=3D./=3D -Wno-packed-not-aligned    -DKBUILD_BASENAME=3D'"empty"=
' -DKBUILD_MODNAME=3D'"empty"' scripts/mod/empty.c | scripts/genksyms/genks=
yms  -R  -r /dev/null > scripts/mod/.tmp_empty.ver; ld  -EL -m elf64lppc -r=
 -o scripts/mod/.tmp_empty.o scripts/mod/empty.o -T scripts/mod/.tmp_empty.=
ver; mv -f scripts/mod/.tmp_empty.o scripts/mod/empty.o; rm -f scripts/mod/=
=2Etmp_empty.ver; fi
-  if [ "-pg -mprofile-kernel " =3D "-pg -mprofile-kernel " ]; then perl ./=
scripts/recordmcount.pl "powerpc" "little" "64" "objdump" "objcopy" "gcc -D=
__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1   -Wall -Wundef -Werror=3Dst=
rict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wch=
ar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int =
-Wno-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -=
mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-fun=
ctions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx   -fno-dwarf2-c=
fi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -=
mlittle-endian -mstack-protector-guard=3Dtls -mstack-protector-guard-reg=3D=
r13 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncati=
on -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=3Dallow-store-=
data-races=3D0  -Wframe-larger-than=3D2048 -fstack-protector-strong -Wno-un=
used-but-set-variable -Wno-unused-const-variable  -fno-var-tracking-assignm=
ents -g -gdwarf-4 -pg -mprofile-kernel    -fno-inline-functions-called-once=
 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-trunca=
tion -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fno-s=
tack-check -fconserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-poin=
ter-types -Werror=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-=
not-aligned     " "ld  -EL -m elf64lppc" "nm --synthetic" "" "" "0" "script=
s/mod/empty.o"; fi
-  scripts/mod/mk_elfconfig < scripts/mod/empty.o > scripts/mod/elfconfig.h
-  gcc -Wp,-MD,scripts/mod/.modpost.o.d -Wall -Wmissing-prototypes -Wstrict=
-prototypes -O2 -fomit-frame-pointer -std=3Dgnu89       -c -o scripts/mod/m=
odpost.o scripts/mod/modpost.c
-  gcc -Wp,-MD,scripts/mod/.devicetable-offsets.s.d -nostdinc -isystem /usr=
/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc/include -I./arch/p=
owerpc/include/generated -I./include -I./arch/powerpc/include/uapi -I./arch=
/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi=
 -include ./include/linux/kconfig.h -include ./include/linux/compiler_types=
=2Eh -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=
=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshor=
t-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit=
-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -p=
ipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-neste=
d-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf=
2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-alig=
n -mlittle-endian -mstack-protector-guard=3Dtls -mstack-protector-guard-reg=
=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-trunc=
ation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=3Dallow-sto=
re-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong -Wno-=
unused-but-set-variable -Wno-unused-const-variable -pg -mprofile-kernel -fn=
o-inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wno-poi=
nter-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-cons=
tants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Ddate-ti=
me -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmacro-p=
refix-map=3D./=3D -Wno-packed-not-aligned -DKBUILD_BASENAME=3D'"devicetable=
_offsets"' -DKBUILD_MODNAME=3D'"devicetable_offsets"'  -fverbose-asm -S -o =
scripts/mod/devicetable-offsets.s scripts/mod/devicetable-offsets.c
 set -e; mkdir -p scripts/mod/; { 	 echo "#ifndef __DEVICETABLE_OFFSETS_H__=
"; echo "#define __DEVICETABLE_OFFSETS_H__"; echo "/*"; echo " * DO NOT MOD=
IFY."; echo " *"; echo " * This file was generated by Kbuild"; echo " */"; =
echo ""; sed -ne 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{=
s:->#\(.*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 =
/* \3 */:; s:->::; p;}' < scripts/mod/devicetable-offsets.s; echo ""; echo =
"#endif"; } > scripts/mod/devicetable-offsets.h.tmp; if [ -r scripts/mod/de=
vicetable-offsets.h ] && cmp -s scripts/mod/devicetable-offsets.h scripts/m=
od/devicetable-offsets.h.tmp; then rm -f scripts/mod/devicetable-offsets.h.=
tmp; else : '  UPD     scripts/mod/devicetable-offsets.h'; mv -f scripts/mo=
d/devicetable-offsets.h.tmp scripts/mod/devicetable-offsets.h; fi
-  gcc -Wp,-MD,scripts/mod/.file2alias.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu89       -c -o scripts/mo=
d/file2alias.o scripts/mod/file2alias.c
-  gcc -Wp,-MD,scripts/mod/.sumversion.o.d -Wall -Wmissing-prototypes -Wstr=
ict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu89       -c -o scripts/mo=
d/sumversion.o scripts/mod/sumversion.c
-  gcc   -o scripts/mod/modpost scripts/mod/modpost.o scripts/mod/file2alia=
s.o scripts/mod/sumversion.o  =20
 make -f ./scripts/Makefile.build obj=3D.
-  gcc -Wp,-MD,kernel/.bounds.s.d -nostdinc -isystem /usr/lib/gcc/ppc64le-r=
edhat-linux/8/include -I./arch/powerpc/include -I./arch/powerpc/include/gen=
erated -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/g=
enerated/uapi -I./include/uapi -I./include/generated/uapi -include ./includ=
e/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -I=
arch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=3Dstrict-prototypes=
 -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -We=
rror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-format-sec=
urity -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -mtraceback=3Dno=
 -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-functions -mcpu=3D=
power8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf2-cfi-asm -mno-strin=
g -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -mlittle-endian -m=
stack-protector-guard=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-n=
ull-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-ov=
erflow -Wno-int-in-bool-context -O2 --param=3Dallow-store-data-races=3D0 -W=
frame-larger-than=3D2048 -fstack-protector-strong -Wno-unused-but-set-varia=
ble -Wno-unused-const-variable -pg -mprofile-kernel -fno-inline-functions-c=
alled-once -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-strin=
gop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-consta=
nts -fno-stack-check -fconserve-stack -Werror=3Ddate-time -Werror=3Dincompa=
tible-pointer-types -Werror=3Ddesignated-init -fmacro-prefix-map=3D./=3D -W=
no-packed-not-aligned -DKBUILD_BASENAME=3D'"bounds"' -DKBUILD_MODNAME=3D'"b=
ounds"'  -fverbose-asm -S -o kernel/bounds.s kernel/bounds.c
 set -e; mkdir -p include/generated/; { 	 echo "#ifndef __LINUX_BOUNDS_H__"=
; echo "#define __LINUX_BOUNDS_H__"; echo "/*"; echo " * DO NOT MODIFY."; e=
cho " *"; echo " * This file was generated by Kbuild"; echo " */"; echo "";=
 sed -ne 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.=
*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */=
:; s:->::; p;}' < kernel/bounds.s; echo ""; echo "#endif"; } > include/gene=
rated/bounds.h.tmp; if [ -r include/generated/bounds.h ] && cmp -s include/=
generated/bounds.h include/generated/bounds.h.tmp; then rm -f include/gener=
ated/bounds.h.tmp; else : '  UPD     include/generated/bounds.h'; mv -f inc=
lude/generated/bounds.h.tmp include/generated/bounds.h; fi
 set -e; mkdir -p include/generated/; { echo 100 | bc -q kernel/time/timeco=
nst.bc; } > include/generated/timeconst.h.tmp; if [ -r include/generated/ti=
meconst.h ] && cmp -s include/generated/timeconst.h include/generated/timec=
onst.h.tmp; then rm -f include/generated/timeconst.h.tmp; else : '  UPD    =
 include/generated/timeconst.h'; mv -f include/generated/timeconst.h.tmp in=
clude/generated/timeconst.h; fi
-  gcc -Wp,-MD,arch/powerpc/kernel/.asm-offsets.s.d -nostdinc -isystem /usr=
/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc/include -I./arch/p=
owerpc/include/generated -I./include -I./arch/powerpc/include/uapi -I./arch=
/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi=
 -include ./include/linux/kconfig.h -include ./include/linux/compiler_types=
=2Eh -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=
=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshor=
t-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit=
-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -p=
ipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-neste=
d-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf=
2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-alig=
n -mlittle-endian -mstack-protector-guard=3Dtls -mstack-protector-guard-reg=
=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-trunc=
ation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=3Dallow-sto=
re-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong -Wno-=
unused-but-set-variable -Wno-unused-const-variable -pg -mprofile-kernel -fn=
o-inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wno-poi=
nter-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-cons=
tants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Ddate-ti=
me -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmacro-p=
refix-map=3D./=3D -Wno-packed-not-aligned -DKBUILD_BASENAME=3D'"asm_offsets=
"' -DKBUILD_MODNAME=3D'"asm_offsets"'  -fverbose-asm -S -o arch/powerpc/ker=
nel/asm-offsets.s arch/powerpc/kernel/asm-offsets.c
 set -e; mkdir -p include/generated/; { 	 echo "#ifndef __ASM_OFFSETS_H__";=
 echo "#define __ASM_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; ech=
o " *"; echo " * This file was generated by Kbuild"; echo " */"; echo ""; s=
ed -ne 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\=
):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:;=
 s:->::; p;}' < arch/powerpc/kernel/asm-offsets.s; echo ""; echo "#endif"; =
} > include/generated/asm-offsets.h.tmp; if [ -r include/generated/asm-offs=
ets.h ] && cmp -s include/generated/asm-offsets.h include/generated/asm-off=
sets.h.tmp; then rm -f include/generated/asm-offsets.h.tmp; else : '  UPD  =
   include/generated/asm-offsets.h'; mv -f include/generated/asm-offsets.h.=
tmp include/generated/asm-offsets.h; fi
-  /bin/sh scripts/checksyscalls.sh gcc -Wp,-MD,./.missing-syscalls.d  -nos=
tdinc -isystem /usr/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc=
/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/i=
nclude/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./in=
clude/generated/uapi -include ./include/linux/kconfig.h -include ./include/=
linux/compiler_types.h -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wa=
ll -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration =
-Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m=
64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno=
-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -=
mno-vsx -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-man=
y -mno-strict-align -mlittle-endian -mstack-protector-guard=3Dtls -mstack-p=
rotector-guard-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address=
 -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 -=
-param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-prot=
ector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-v=
ar-tracking-assignments -g -gdwarf-4 -pg -mprofile-kernel -fno-inline-funct=
ions-called-once -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno=
-stringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-=
constants -fno-stack-check -fconserve-stack -Werror=3Ddate-time -Werror=3Di=
ncompatible-pointer-types -Werror=3Ddesignated-init -fmacro-prefix-map=3D./=
=3D -Wno-packed-not-aligned    -DKBUILD_BASENAME=3D'"missing_syscalls"' -DK=
BUILD_MODNAME=3D'"missing_syscalls"'=20
+  /bin/sh scripts/checksyscalls.sh gcc -Wp,-MD,./.missing-syscalls.d  -nos=
tdinc -isystem /usr/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc=
/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/i=
nclude/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./in=
clude/generated/uapi -include ./include/linux/kconfig.h -include ./include/=
linux/compiler_types.h -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wa=
ll -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing =
-fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration =
-Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m=
64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno=
-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -=
mno-vsx -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-man=
y -mno-strict-align -mlittle-endian -mstack-protector-guard=3Dtls -mstack-p=
rotector-guard-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address=
 -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 -=
-param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-prot=
ector-strong -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-v=
ar-tracking-assignments -g -gdwarf-4 -pg -mprofile-kernel -mno-sched-epilog=
 -fno-inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wno=
-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-=
constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Ddat=
e-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmac=
ro-prefix-map=3D./=3D -Wno-packed-not-aligned    -DKBUILD_BASENAME=3D'"miss=
ing_syscalls"' -DKBUILD_MODNAME=3D'"missing_syscalls"'=20
 <stdin>:1478:2: warning: #warning syscall pidfd_send_signal not implemente=
d [-Wcpp]
 <stdin>:1481:2: warning: #warning syscall io_uring_setup not implemented [=
-Wcpp]
 <stdin>:1484:2: warning: #warning syscall io_uring_enter not implemented [=
-Wcpp]
 <stdin>:1487:2: warning: #warning syscall io_uring_register not implemente=
d [-Wcpp]
   /bin/sh scripts/atomic/check-atomics.sh
 make -f ./scripts/Makefile.build obj=3Dkernel/trace kernel/trace/trace_sel=
ftest_dynamic.o
-  gcc -Wp,-MD,kernel/trace/.trace_selftest_dynamic.o.d  -nostdinc -isystem=
 /usr/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc/include -I./a=
rch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I=
=2E/arch/powerpc/include/generated/uapi -I./include/uapi -I./include/genera=
ted/uapi -include ./include/linux/kconfig.h -include ./include/linux/compil=
er_types.h -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -=
Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common =
-fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dim=
plicit-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-fl=
oat -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to=
-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno=
-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-stric=
t-align -mlittle-endian -mstack-protector-guard=3Dtls -mstack-protector-gua=
rd-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format=
-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=3Dall=
ow-store-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong=
 -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-=
assignments -g -gdwarf-4 -fno-inline-functions-called-once -Wdeclaration-af=
ter-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-=
overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fcons=
erve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=
=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned -msta=
ck-protector-guard-offset=3D2936 -D_TASK_CPU=3D300 -pg -mprofile-kernel    =
-DKBUILD_BASENAME=3D'"trace_selftest_dynamic"' -DKBUILD_MODNAME=3D'"trace_s=
elftest_dynamic"' -c -o kernel/trace/trace_selftest_dynamic.o kernel/trace/=
trace_selftest_dynamic.c
-  if objdump -h kernel/trace/trace_selftest_dynamic.o | grep -q __ksymtab;=
 then gcc -E -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-=
strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-funct=
ion-declaration -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -m=
little-endian -m64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmod=
el=3Dmedium -mno-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower=
9 -mno-altivec -mno-vsx   -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa=
,-mpower4 -Wa,-many -mno-strict-align -mlittle-endian -mstack-protector-gua=
rd=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-null-pointer-checks =
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-=
bool-context -O2 --param=3Dallow-store-data-races=3D0  -Wframe-larger-than=
=3D2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-c=
onst-variable  -fno-var-tracking-assignments -g -gdwarf-4 -pg -mprofile-ker=
nel    -fno-inline-functions-called-once -Wdeclaration-after-statement -Wvl=
a -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merg=
e-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=
=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init=
 -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned     -mstack-protector-g=
uard-offset=3D2936 -D_TASK_CPU=3D300 -D__GENKSYMS__ -Wp,-MD,kernel/trace/.t=
race_selftest_dynamic.o.d  -nostdinc -isystem /usr/lib/gcc/ppc64le-redhat-l=
inux/8/include -I./arch/powerpc/include -I./arch/powerpc/include/generated =
 -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generat=
ed/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linu=
x/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Iarch/p=
owerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-=
trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-format-securit=
y -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -mtraceback=3Dno -ma=
bi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-functions -mcpu=3Dpowe=
r8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf2-cfi-asm -mno-string -W=
a,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -mlittle-endian -mstac=
k-protector-guard=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-null-=
pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overfl=
ow -Wno-int-in-bool-context -O2 --param=3Dallow-store-data-races=3D0 -Wfram=
e-larger-than=3D2048 -fstack-protector-strong -Wno-unused-but-set-variable =
-Wno-unused-const-variable -fno-var-tracking-assignments -g -gdwarf-4 -fno-=
inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wno-point=
er-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all-consta=
nts -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Ddate-time=
 -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fmacro-pre=
fix-map=3D./=3D -Wno-packed-not-aligned -mstack-protector-guard-offset=3D29=
36 -D_TASK_CPU=3D300 -pg -mprofile-kernel    -DKBUILD_BASENAME=3D'"trace_se=
lftest_dynamic"' -DKBUILD_MODNAME=3D'"trace_selftest_dynamic"' kernel/trace=
/trace_selftest_dynamic.c | scripts/genksyms/genksyms  -R  -r /dev/null > k=
ernel/trace/.tmp_trace_selftest_dynamic.ver; ld  -EL -m elf64lppc -r -o ker=
nel/trace/.tmp_trace_selftest_dynamic.o kernel/trace/trace_selftest_dynamic=
=2Eo -T kernel/trace/.tmp_trace_selftest_dynamic.ver; mv -f kernel/trace/.t=
mp_trace_selftest_dynamic.o kernel/trace/trace_selftest_dynamic.o; rm -f ke=
rnel/trace/.tmp_trace_selftest_dynamic.ver; fi
-  if [ "" =3D "-pg -mprofile-kernel " ]; then perl ./scripts/recordmcount.=
pl "powerpc" "little" "64" "objdump" "objcopy" "gcc -D__KERNEL__ -Iarch/pow=
erpc -DHAVE_AS_ATHIGH=3D1   -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-=
trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=
=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wno-format-securit=
y -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -mtraceback=3Dno -ma=
bi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-functions -mcpu=3Dpowe=
r8 -mtune=3Dpower9 -mno-altivec -mno-vsx   -fno-dwarf2-cfi-asm -mno-string =
-Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -mlittle-endian -mst=
ack-protector-guard=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-nul=
l-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-over=
flow -Wno-int-in-bool-context -O2 --param=3Dallow-store-data-races=3D0  -Wf=
rame-larger-than=3D2048 -fstack-protector-strong -Wno-unused-but-set-variab=
le -Wno-unused-const-variable  -fno-var-tracking-assignments -g -gdwarf-4  =
  -fno-inline-functions-called-once -Wdeclaration-after-statement -Wvla -Wn=
o-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-merge-all=
-constants -fmerge-constants -fno-stack-check -fconserve-stack -Werror=3Dda=
te-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init -fma=
cro-prefix-map=3D./=3D -Wno-packed-not-aligned     -mstack-protector-guard-=
offset=3D2936 -D_TASK_CPU=3D300 " "ld  -EL -m elf64lppc" "nm --synthetic" "=
" "" "0" "kernel/trace/trace_selftest_dynamic.o"; fi
+  gcc -Wp,-MD,kernel/trace/.trace_selftest_dynamic.o.d  -nostdinc -isystem=
 /usr/lib/gcc/ppc64le-redhat-linux/8/include -I./arch/powerpc/include -I./a=
rch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I=
=2E/arch/powerpc/include/generated/uapi -I./include/uapi -I./include/genera=
ted/uapi -include ./include/linux/kconfig.h -include ./include/linux/compil=
er_types.h -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -=
Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common =
-fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dim=
plicit-int -Wno-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-fl=
oat -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to=
-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno=
-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-stric=
t-align -mlittle-endian -mstack-protector-guard=3Dtls -mstack-protector-gua=
rd-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format=
-truncation -Wno-format-overflow -Wno-int-in-bool-context -O2 --param=3Dall=
ow-store-data-races=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong=
 -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-var-tracking-=
assignments -g -gdwarf-4 -fno-inline-functions-called-once -Wdeclaration-af=
ter-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-=
overflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fcons=
erve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=
=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned -msta=
ck-protector-guard-offset=3D2936 -D_TASK_CPU=3D300 -pg -mprofile-kernel -mn=
o-sched-epilog    -DKBUILD_BASENAME=3D'"trace_selftest_dynamic"' -DKBUILD_M=
ODNAME=3D'"trace_selftest_dynamic"' -c -o kernel/trace/trace_selftest_dynam=
ic.o kernel/trace/trace_selftest_dynamic.c
+  if objdump -h kernel/trace/trace_selftest_dynamic.o | grep -q __ksymtab;=
 then gcc -E -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-=
strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-funct=
ion-declaration -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -m=
little-endian -m64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmod=
el=3Dmedium -mno-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower=
9 -mno-altivec -mno-vsx   -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa=
,-mpower4 -Wa,-many -mno-strict-align -mlittle-endian -mstack-protector-gua=
rd=3Dtls -mstack-protector-guard-reg=3Dr13 -fno-delete-null-pointer-checks =
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-=
bool-context -O2 --param=3Dallow-store-data-races=3D0  -Wframe-larger-than=
=3D2048 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-c=
onst-variable  -fno-var-tracking-assignments -g -gdwarf-4 -pg -mprofile-ker=
nel -mno-sched-epilog   -fno-inline-functions-called-once -Wdeclaration-aft=
er-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-o=
verflow -fno-merge-all-constants -fmerge-constants -fno-stack-check -fconse=
rve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=
=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned     -=
mstack-protector-guard-offset=3D2936 -D_TASK_CPU=3D300 -D__GENKSYMS__ -Wp,-=
MD,kernel/trace/.trace_selftest_dynamic.o.d  -nostdinc -isystem /usr/lib/gc=
c/ppc64le-redhat-linux/8/include -I./arch/powerpc/include -I./arch/powerpc/=
include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/power=
pc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -incl=
ude ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D_=
_KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Werror=3Dstric=
t-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar =
-fno-PIE -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -Wn=
o-format-security -std=3Dgnu89 -mlittle-endian -m64 -msoft-float -pipe -mtr=
aceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-functi=
ons -mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -fno-dwarf2-cfi-as=
m -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many -mno-strict-align -mlitt=
le-endian -mstack-protector-guard=3Dtls -mstack-protector-guard-reg=3Dr13 -=
fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -W=
no-format-overflow -Wno-int-in-bool-context -O2 --param=3Dallow-store-data-=
races=3D0 -Wframe-larger-than=3D2048 -fstack-protector-strong -Wno-unused-b=
ut-set-variable -Wno-unused-const-variable -fno-var-tracking-assignments -g=
 -gdwarf-4 -fno-inline-functions-called-once -Wdeclaration-after-statement =
-Wvla -Wno-pointer-sign -Wno-stringop-truncation -fno-strict-overflow -fno-=
merge-all-constants -fmerge-constants -fno-stack-check -fconserve-stack -We=
rror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-=
init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligned -mstack-protector-g=
uard-offset=3D2936 -D_TASK_CPU=3D300 -pg -mprofile-kernel -mno-sched-epilog=
    -DKBUILD_BASENAME=3D'"trace_selftest_dynamic"' -DKBUILD_MODNAME=3D'"tra=
ce_selftest_dynamic"' kernel/trace/trace_selftest_dynamic.c | scripts/genks=
yms/genksyms  -R  -r /dev/null > kernel/trace/.tmp_trace_selftest_dynamic.v=
er; ld  -EL -m elf64lppc -r -o kernel/trace/.tmp_trace_selftest_dynamic.o k=
ernel/trace/trace_selftest_dynamic.o -T kernel/trace/.tmp_trace_selftest_dy=
namic.ver; mv -f kernel/trace/.tmp_trace_selftest_dynamic.o kernel/trace/tr=
ace_selftest_dynamic.o; rm -f kernel/trace/.tmp_trace_selftest_dynamic.ver;=
 fi
+  if [ "-pg -mprofile-kernel -mno-sched-epilog" =3D "-pg -mprofile-kernel =
-mno-sched-epilog" ]; then perl ./scripts/recordmcount.pl "powerpc" "little=
" "64" "objdump" "objcopy" "gcc -D__KERNEL__ -Iarch/powerpc -DHAVE_AS_ATHIG=
H=3D1   -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-stric=
t-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-d=
eclaration -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -mlittl=
e-endian -m64 -msoft-float -pipe -mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3D=
medium -mno-pointers-to-nested-functions -mcpu=3Dpower8 -mtune=3Dpower9 -mn=
o-altivec -mno-vsx   -fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpo=
wer4 -Wa,-many -mno-strict-align -mlittle-endian -mstack-protector-guard=3D=
tls -mstack-protector-guard-reg=3Dr13 -fno-delete-null-pointer-checks -Wno-=
frame-address -Wno-format-truncation -Wno-format-overflow -Wno-int-in-bool-=
context -O2 --param=3Dallow-store-data-races=3D0  -Wframe-larger-than=3D204=
8 -fstack-protector-strong -Wno-unused-but-set-variable -Wno-unused-const-v=
ariable  -fno-var-tracking-assignments -g -gdwarf-4    -fno-inline-function=
s-called-once -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-st=
ringop-truncation -fno-strict-overflow -fno-merge-all-constants -fmerge-con=
stants -fno-stack-check -fconserve-stack -Werror=3Ddate-time -Werror=3Dinco=
mpatible-pointer-types -Werror=3Ddesignated-init -fmacro-prefix-map=3D./=3D=
 -Wno-packed-not-aligned     -mstack-protector-guard-offset=3D2936 -D_TASK_=
CPU=3D300 " "ld  -EL -m elf64lppc" "nm --synthetic" "" "" "0" "kernel/trace=
/trace_selftest_dynamic.o"; fi
