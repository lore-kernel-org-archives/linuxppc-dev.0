Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAB8C1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 02:50:49 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so95575107igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 09:50:46 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 11 Aug 2015 19:50:46 +0300
Message-ID: <CAJ2oMhLr9aoZ258hm0-xuRuW5iksLMOgNOL=hQh6S4SteFNDeg@mail.gmail.com>
Subject: gdb with powerpc
From: Ran Shalit <ranshalit@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, gdb <gdb@sourceware.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I would like to ask if anyone tried remote debugging with
gdb/gdbserver on powerpc.
I've tried to cross-compile gdb for powerpc, but I get into troubles.
I am using the following compiler:
powerpc-buildroot-linux-gnu-gcc (Buildroot 2014.11) 4.8.3

I've downloaded several version, gdb version 6 and above all have same
error as following:

gcc -c -g -O2    -I. -I.././gdb -I.././gdb/config
-DLOCALEDIR=3D"\"/home/tigran/gdb/share/locale\"" -DHAVE_CONFIG_H
-I.././gdb/../include/opcode -I.././gdb/../readline/.. -I../bfd
-I.././gdb/../bfd -I.././gdb/../include -I../intl -I.././gdb/../intl
-DMI_OUT=3D1 -DTUI=3D1 -Wimplicit -Wreturn-type -Wcomment -Wtrigraphs
-Wformat -Wparentheses -Wpointer-arith -Wformat-nonliteral
-Wunused-label -Wunused-function -Wno-pointer-sign -Wuninitialized
ppc-linux-nat.c
ppc-linux-nat.c: In function =E2=80=98ppc_register_u_addr=E2=80=99:
ppc-linux-nat.c:186:47: error: =E2=80=98PT_R0=E2=80=99 undeclared (first us=
e in this function)
     u_addr =3D ((regno - tdep->ppc_gp0_regnum + PT_R0) * wordsize);


Trying to compile older version 5.3 also fails in different way:

gcc -c -g -O2 -DDEFAULT_INLINE=3DPSIM_INLINE_LOCALS
-DWITH_HOST_BYTE_ORDER=3DLITTLE_ENDIAN -DWITH_SMP=3D5
-DHAVE_TERMIOS_STRUCTURE -DHAVE_TERMIOS_CLINE -DHAVE_DEVZERO     -I.
-I. -I./../../include -I../../bfd -I./../../bfd -I../../gdb
-I./../../gdb  -I./../../gdb/config -I./../../mmalloc -I../../intl
-I./../../intl support.c
In file included from cpu.h:25:0,
                 from support.c:27:
./ppc-instructions: In function =E2=80=98convert_to_integer=E2=80=99:
idecode_fields.h:105:31: error: label at end of compound statement
 #define LABEL(dest)  XCONCAT4(label__,dest,__,MY_PREFIX)
                               ^

As an alternative, Is anyone familiar with binary package with
gdb/gdbserver for powerpc used with x86 host ?

Best Regards,
Ran
