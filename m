Message-ID: <8608421EC5CBD511B5090002A55C004802618344@uswaumsx04medge.med.ge.com>
From: "Eisenhut, Daniel (MED)" <Daniel.Eisenhut@med.ge.com>
To: "'joakim.tjernlund@lumentis.se'" <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	"Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
Subject: RE: gcc optimizes loops badly.
Date: Thu, 2 Jan 2003 10:12:23 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jocke,

   It just happens that I have a ppc cross compiler using gcc v3.2.1
handy.  "-mregnames" worked fine with it.  Here's the output file:


	.file	"testcode.c"
	.section	".text"
	.align 2
	.globl crc32org
	.type	crc32org,@function
crc32org:
	cmpwi %cr0,%r5,0
	addi %r5,%r5,-1
	beqlr- %cr0
	addi %r5,%r5,1
	lis %r9,crc32_table@ha
	mtctr %r5
	la %r10,crc32_table@l(%r9)
.L18:
	lbz %r0,0(%r4)
	srwi %r11,%r3,8
	addi %r4,%r4,1
	xor %r0,%r3,%r0
	rlwinm %r0,%r0,2,22,29
	lwzx %r9,%r10,%r0
	xor %r3,%r9,%r11
	bdnz .L18
	blr
.Lfe1:
	.size	crc32org,.Lfe1-crc32org
	.align 2
	.globl crc32do_while
	.type	crc32do_while,@function
crc32do_while:
	cmpwi %cr0,%r5,0
	beqlr- %cr0
	lis %r9,crc32_table@ha
	mtctr %r5
	la %r10,crc32_table@l(%r9)
.L25:
	lbz %r0,0(%r4)
	srwi %r11,%r3,8
	addi %r4,%r4,1
	xor %r0,%r3,%r0
	rlwinm %r0,%r0,2,22,29
	lwzx %r9,%r10,%r0
	xor %r3,%r9,%r11
	bdnz .L25
	blr
.Lfe2:
	.size	crc32do_while,.Lfe2-crc32do_while
	.align 2
	.globl crc32do_while_dec
	.type	crc32do_while_dec,@function
crc32do_while_dec:
	cmpwi %cr0,%r5,0
	beqlr- %cr0
	lis %r9,crc32_table@ha
	mtctr %r5
	la %r10,crc32_table@l(%r9)
	addi %r4,%r4,-1
.L32:
	lbzu %r0,1(%r4)
	srwi %r11,%r3,8
	xor %r0,%r3,%r0
	rlwinm %r0,%r0,2,22,29
	lwzx %r9,%r10,%r0
	xor %r3,%r9,%r11
	bdnz .L32
	blr
.Lfe3:
	.size	crc32do_while_dec,.Lfe3-crc32do_while_dec
	.ident	"GCC: (GNU) 3.2.1"


-----Original Message-----
From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
Sent: Thursday, January 02, 2003 9:57 AM
To: Eisenhut, Daniel (MED)
Cc: Linuxppc-Embedded@Lists. Linuxppc. Org; Petersen, David (MED,
GEMS-IT)
Subject: RE: gcc optimizes loops badly.


Hi Daniel

Thanks for running the test for me.

The option "-mregnames" exists only on gcc for PPC.

Results are as before for x86. crc32do_while is the
winner followed by crc32do_while_dec.
Gcc should be able generate the same code for
crc32org and crc32do_while, it's a simple optimization.
crc32do_while_dec is possibly only useful on PPC.

On PPC I expect crc32do_while_dec to be the winner.
Do you have a gcc 3.2 which will generate PPC assembly?

 Jocke
PS.
  You don't have to be on the list to post to it. I will
  CC the list for now.
>
>
> Jocke,
>
>    The option "-mregnames" no longer exists in version 3.2 of gcc.  I
> couldn't find anything equivalent.  I ran it without that option (gcc
-S
> -O2 testcode.c) and produced the following on a i686 RedHat 7.3 box
> using gcc 3.2  (gcc 3.2.1 is the latest release I believe)
>
>    I am not on the list, hence I cannot CC the list.  This message was
> forwarded to me from someone else.
>
> Dan Eisenhut
> GE Medical Systems - Information Technologies
> daniel.eisenhut@med.ge.com
> 414-362-3151
>
>
> 	.file	"testcode.c"
> 	.text
> 	.align 2
> 	.p2align 4,,15
> .globl crc32org
> 	.type	crc32org,@function
> crc32org:
> 	pushl	%ebp
> 	movl	%esp, %ebp
> 	pushl	%esi
> 	movl	16(%ebp), %edx
> 	pushl	%ebx
> 	movl	8(%ebp), %ecx
> 	movl	12(%ebp), %ebx
> 	decl	%edx
> 	cmpl	$-1, %edx
> 	je	.L7
> 	movl	$crc32_table, %esi
> 	.p2align 4,,15
> .L5:
> 	movzbl	(%ebx), %eax
> 	decl	%edx
> 	incl	%ebx
> 	xorb	%cl, %al
> 	shrl	$8, %ecx
> 	movzbl	%al, %eax
> 	xorl	(%esi,%eax,4), %ecx
> 	cmpl	$-1, %edx
> 	jne	.L5
> .L7:
> 	popl	%ebx
> 	movl	%ecx, %eax
> 	popl	%esi
> 	popl	%ebp
> 	ret
> .Lfe1:
> 	.size	crc32org,.Lfe1-crc32org
> 	.align 2
> 	.p2align 4,,15
> .globl crc32do_while
> 	.type	crc32do_while,@function
> crc32do_while:
> 	pushl	%ebp
> 	movl	%esp, %ebp
> 	pushl	%esi
> 	movl	8(%ebp), %edx
> 	pushl	%ebx
> 	movl	16(%ebp), %ebx
> 	movl	12(%ebp), %ecx
> 	testl	%ebx, %ebx
> 	je	.L9
> 	movl	$crc32_table, %esi
> 	.p2align 4,,15
> .L10:
> 	movzbl	(%ecx), %eax
> 	incl	%ecx
> 	xorb	%dl, %al
> 	shrl	$8, %edx
> 	movzbl	%al, %eax
> 	xorl	(%esi,%eax,4), %edx
> 	decl	%ebx
> 	jne	.L10
> .L9:
> 	popl	%ebx
> 	movl	%edx, %eax
> 	popl	%esi
> 	popl	%ebp
> 	ret
> .Lfe2:
> 	.size	crc32do_while,.Lfe2-crc32do_while
> 	.align 2
> 	.p2align 4,,15
> .globl crc32do_while_dec
> 	.type	crc32do_while_dec,@function
> crc32do_while_dec:
> 	pushl	%ebp
> 	movl	%esp, %ebp
> 	pushl	%esi
> 	movl	8(%ebp), %edx
> 	pushl	%ebx
> 	movl	16(%ebp), %ebx
> 	movl	12(%ebp), %ecx
> 	testl	%ebx, %ebx
> 	je	.L15
> 	decl	%ecx
> 	movl	$crc32_table, %esi
> 	.p2align 4,,15
> .L16:
> 	incl	%ecx
> 	movzbl	(%ecx), %eax
> 	xorb	%dl, %al
> 	shrl	$8, %edx
> 	movzbl	%al, %eax
> 	xorl	(%esi,%eax,4), %edx
> 	decl	%ebx
> 	jne	.L16
> .L15:
> 	popl	%ebx
> 	movl	%edx, %eax
> 	popl	%esi
> 	popl	%ebp
> 	ret
> .Lfe3:
> 	.size	crc32do_while_dec,.Lfe3-crc32do_while_dec
> 	.ident	"GCC: (GNU) 3.2"
>
>
> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@lumentis.se]
> Sent: Wednesday, January 01, 2003 8:45 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: gcc optimizes loops badly.
>
>
>
> I have spent some time to optimize the crc32 function since JFFS2 uses
> it heavily. I found that
> gcc 2.95.3 optimizes loops badly, even gcc 2.96 RH produces better
code
> for x86 in some cases.
>
> So I optimized the C code a bit and got much better results.
> Now I wounder how recent(>= 3.2) gcc performs. Could somebody run gcc
-S
> -O2 -mregnames on
> functions below and mail me the results?
>
>  Jocke
>
> These are different version of the same  crc32 function:
> #include <linux/types.h>
>
> extern  const __u32 crc32_table[256];
>
> /* Return a 32-bit CRC of the contents of the buffer. */
>
> __u32 crc32org(__u32 val, const void *ss, unsigned int len)
> {
>         const unsigned char *s = ss;
>
>         while (len--){
>           val = crc32_table[(val ^ *s++) & 0xff] ^ (val >> 8);
>         }
>         return val;
> }
> __u32 crc32do_while(__u32 val, const void *ss, unsigned int len)
> {
>         const unsigned char *s = ss;
>
>         if(len){
>           do {
>             val = crc32_table[(val ^ *s++) & 0xff] ^ (val >> 8);
>           }  while (--len);
>         }
>         return val;
> }
> __u32 crc32do_while_dec(__u32 val, const void *ss, unsigned int len)
> {
>         const unsigned char *s = ss;
>
>         if(len){
>           --s;
>           do {
>             val = crc32_table[(val ^ *(++s)) & 0xff] ^ (val >> 8);
>           }  while (--len);
>         }
>         return val;
> }
>
> and the resulting assembly:
>         .file   "crc32.c"
> gcc2_compiled.:
>         .section        ".text"
>         .align 2
>         .globl crc32org
>         .type    crc32org,@function
> crc32org:
>         cmpwi %cr0,%r5,0
>         addi %r5,%r5,-1
>         bclr 12,2
>         lis %r9,crc32_table@ha
>         la %r10,crc32_table@l(%r9)
> .L18:
>         lbz %r0,0(%r4)
>         cmpwi %cr0,%r5,0
>         xor %r0,%r3,%r0
>         rlwinm %r0,%r0,2,22,29
>         lwzx %r11,%r10,%r0
>         srwi %r9,%r3,8
>         xor %r3,%r11,%r9
>         addi %r4,%r4,1
>         addi %r5,%r5,-1
>         bc 4,2,.L18
>         blr
> .Lfe1:
>         .size    crc32org,.Lfe1-crc32org
>         .align 2
>         .globl crc32do_while
>         .type    crc32do_while,@function
> crc32do_while:
>         mr. %r0,%r5
>         mtctr %r0
>         bclr 12,2
>         lis %r9,crc32_table@ha
>         la %r10,crc32_table@l(%r9)
> .L25:
>         lbz %r0,0(%r4)
>         srwi %r11,%r3,8
>         xor %r0,%r3,%r0
>         rlwinm %r0,%r0,2,22,29
>         lwzx %r9,%r10,%r0
>         addi %r4,%r4,1
>         xor %r3,%r9,%r11
>         bdnz .L25
>         blr
> .Lfe2:
>         .size    crc32do_while,.Lfe2-crc32do_while
>         .align 2
>         .globl crc32do_while_dec
>         .type    crc32do_while_dec,@function
> crc32do_while_dec:
>         mr. %r0,%r5
>         mtctr %r0
>         bclr 12,2
>         lis %r9,crc32_table@ha
>         la %r10,crc32_table@l(%r9)
>         addi %r4,%r4,-1
> .L31:
>         lbzu %r0,1(4)
>         srwi %r11,%r3,8
>         xor %r0,%r3,%r0
>         rlwinm %r0,%r0,2,22,29
>         lwzx %r9,%r10,%r0
>         xor %r3,%r9,%r11
>         bdnz .L31
>         blr
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
