Date: Sat, 15 Nov 2003 22:04:49 +0100
From: Olaf Hering <olh@suse.de>
To: Alan Modra <amodra@bigpond.net.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: kernel oops due to unaligned access with lswi
Message-ID: <20031115210449.GA10105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan,

2.6 has a function parse_header(), its part of gunzip and used for
initramfs as example. I got an oops, exception 600, sig 7. I think that
means unaligned access.

Why does the compiler optimize this one? I see it with 2.95, 3.2, 3.3
and 3.4 with -O1 and better, not with -O0.

gcc -msoft-float -mmultiple -mstring -O2 -Wall -Wstrict-prototypes \
-Wno-trigraphs -Wno-uninitialized -version -fno-strict-aliasing \
-fno-common -ffixed-r2 -fomit-frame-pointer -o parse_header \
 -c parse_header.c -v --save-temps

	lswi 9,31,8
	stswi 9,28,8

s = r31. How can gcc be sure that s aligned?
ppc64 will call memcpy (tested with gcc3.2.3).

	.file	"parse_header.c"
	.section	.init.text,"ax",@progbits
	.align 2
	.type	parse_header,@function
parse_header:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	li 0,0
	stb 0,64(1)
	li 30,0
	addi 31,3,6
	addi 28,1,56
	addi 27,1,8
.L6:
	lswi 9,31,8
	stswi 9,28,8
	slwi 29,30,2
	mr 3,28
	li 4,0
	li 5,16
	bl simple_strtoul
	stwx 3,29,27
	addi 30,30,1
	addi 31,31,8
	cmpwi 0,30,11
	ble+ 0,.L6
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	addi 1,1,112
	blr
.Lfe1:
	.size	parse_header,.Lfe1-parse_header
	.section	".text"
	.align 2
	.globl main
	.type	main,@function
main:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,0x1
	ori 3,3,57920
	bl malloc
	bl parse_header
	li 3,0
	lwz 0,20(1)
	mtlr 0
	addi 1,1,16
	blr
.Lfe2:
	.size	main,.Lfe2-main
	.ident	"GCC: (GNU) 3.2.3 (SuSE Linux)"


#include <stdlib.h>
typedef unsigned int __kernel_size_t;
extern void *memcpy(void *, const void *, __kernel_size_t);
extern unsigned long simple_strtoul(const char *, char **, unsigned int);

static void __attribute__ ((__section__(".init.text"))) parse_header(char *s)
{
	unsigned long parsed[12];
	char buf[9];
	int i;

	buf[8] = '\0';
	for (i = 0, s += 6; i < 12; i++, s += 8) {
		memcpy(buf, s, 8);
		parsed[i] = simple_strtoul(buf, ((void *) 0), 16);
	}
}

int
main(void)
{
	char *s;
	s = malloc(123456);
	parse_header(s);
	return 0;
}
--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
