Message-ID: <002701c2b1a4$57647730$0200a8c0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: gcc optimizes loops badly.
Date: Wed, 1 Jan 2003 15:44:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have spent some time to optimize the crc32 function since JFFS2 uses it heavily. I found that
gcc 2.95.3 optimizes loops badly, even gcc 2.96 RH produces better code for x86 in some cases.

So I optimized the C code a bit and got much better results.
Now I wounder how recent(>= 3.2) gcc performs. Could somebody run gcc -S -O2 -mregnames on
functions below and mail me the results?

 Jocke

These are different version of the same  crc32 function:
#include <linux/types.h>

extern  const __u32 crc32_table[256];

/* Return a 32-bit CRC of the contents of the buffer. */

__u32 crc32org(__u32 val, const void *ss, unsigned int len)
{
        const unsigned char *s = ss;

        while (len--){
          val = crc32_table[(val ^ *s++) & 0xff] ^ (val >> 8);
        }
        return val;
}
__u32 crc32do_while(__u32 val, const void *ss, unsigned int len)
{
        const unsigned char *s = ss;

        if(len){
          do {
            val = crc32_table[(val ^ *s++) & 0xff] ^ (val >> 8);
          }  while (--len);
        }
        return val;
}
__u32 crc32do_while_dec(__u32 val, const void *ss, unsigned int len)
{
        const unsigned char *s = ss;

        if(len){
          --s;
          do {
            val = crc32_table[(val ^ *(++s)) & 0xff] ^ (val >> 8);
          }  while (--len);
        }
        return val;
}

and the resulting assembly:
        .file   "crc32.c"
gcc2_compiled.:
        .section        ".text"
        .align 2
        .globl crc32org
        .type    crc32org,@function
crc32org:
        cmpwi %cr0,%r5,0
        addi %r5,%r5,-1
        bclr 12,2
        lis %r9,crc32_table@ha
        la %r10,crc32_table@l(%r9)
.L18:
        lbz %r0,0(%r4)
        cmpwi %cr0,%r5,0
        xor %r0,%r3,%r0
        rlwinm %r0,%r0,2,22,29
        lwzx %r11,%r10,%r0
        srwi %r9,%r3,8
        xor %r3,%r11,%r9
        addi %r4,%r4,1
        addi %r5,%r5,-1
        bc 4,2,.L18
        blr
.Lfe1:
        .size    crc32org,.Lfe1-crc32org
        .align 2
        .globl crc32do_while
        .type    crc32do_while,@function
crc32do_while:
        mr. %r0,%r5
        mtctr %r0
        bclr 12,2
        lis %r9,crc32_table@ha
        la %r10,crc32_table@l(%r9)
.L25:
        lbz %r0,0(%r4)
        srwi %r11,%r3,8
        xor %r0,%r3,%r0
        rlwinm %r0,%r0,2,22,29
        lwzx %r9,%r10,%r0
        addi %r4,%r4,1
        xor %r3,%r9,%r11
        bdnz .L25
        blr
.Lfe2:
        .size    crc32do_while,.Lfe2-crc32do_while
        .align 2
        .globl crc32do_while_dec
        .type    crc32do_while_dec,@function
crc32do_while_dec:
        mr. %r0,%r5
        mtctr %r0
        bclr 12,2
        lis %r9,crc32_table@ha
        la %r10,crc32_table@l(%r9)
        addi %r4,%r4,-1
.L31:
        lbzu %r0,1(4)
        srwi %r11,%r3,8
        xor %r0,%r3,%r0
        rlwinm %r0,%r0,2,22,29
        lwzx %r9,%r10,%r0
        xor %r3,%r9,%r11
        bdnz .L31
        blr

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
