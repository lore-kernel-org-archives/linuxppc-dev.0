Message-ID: <00d001c06edc$f3ec3d20$5ef1d092@chn.agilent.com>
From: "kerler" <kerler@newmail.net>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <gcc@gcc.gnu.org>
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp><or66kazecj.fsf@guarana.lsd.ic.unicamp.br><3A4613FB.384BAD24@ife.ee.ethz.ch> <orsnnd3d6f.fsf@guarana.lsd.ic.unicamp.br>
Subject: how to use macro in assemble language embedded in C?
Date: Tue, 26 Dec 2000 09:41:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello,

When i use the assemble language embedded in C, how can i use the macro?

in the following code, i want to use the macro PT_R16 defined in
asm\ptrace.h.

=========temp.c==========
asm("#include <asm\\ptrace.h>\n\t");
void dummy (void)
{
    asm("stwu   %r1, -PT_R16(%r1)");             /* stack */
}
=========end of temp.c===

when i
      gcc -c temp.c
error message:
/tmp/cc8ztvPf.s: Assembler messages:
/tmp/cc8ztvPf.s:13: Error: Negative of non-absolute symbol PT_R16

if use
      gcc -S temp.c
the file temp.s is:

=========temp.s==========
        .file   "temp.c"
gcc2_compiled.:
        #include <asm\ptrace.h>

        .section        ".text"
        .align 2
        .globl dummy
        .type    dummy,@function
dummy:
        stwu 1,-16(1)
        stw 31,12(1)
        mr 31,1
        stwu   %r1, -PT_R16(%r1)
.L2:
        lwz 11,0(1)
        lwz 31,-4(11)
        mr 1,11
        blr
.Lfe1:
        .size    dummy,.Lfe1-dummy
        .ident  "GCC: (GNU) 2.95.2 20000220 (Debian GNU/Linux)"
======end of temp.s=============


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
