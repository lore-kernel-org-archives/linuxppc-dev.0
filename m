Date: Thu, 02 Jan 2003 18:34:37 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: gcc optimizes loops badly.
In-reply-to: 
 <8608421EC5CBD511B5090002A55C004802618344@uswaumsx04medge.med.ge.com>
To: "Eisenhut, Daniel (MED)" <Daniel.Eisenhut@med.ge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	"Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEBJFJAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Daniel

The results are somewhat better. Now the loop part for crc32org is better(same as crc32do_while) but
crc32org needs 2 more instructions to prepare the loop.
crc32do_while_dec is still the winner with one less instruction in the loop.

It seems like there is lots of loop optimization work to do in gcc when it comes
to the PPC arch.

  Jocke

>
> Jocke,
>
>    It just happens that I have a ppc cross compiler using gcc v3.2.1
> handy.  "-mregnames" worked fine with it.  Here's the output file:
>
>
> 	.file	"testcode.c"
> 	.section	".text"
> 	.align 2
> 	.globl crc32org
> 	.type	crc32org,@function
> crc32org:
> 	cmpwi %cr0,%r5,0
> 	addi %r5,%r5,-1
> 	beqlr- %cr0
> 	addi %r5,%r5,1
> 	lis %r9,crc32_table@ha
> 	mtctr %r5
> 	la %r10,crc32_table@l(%r9)
> .L18:
> 	lbz %r0,0(%r4)
> 	srwi %r11,%r3,8
> 	addi %r4,%r4,1
> 	xor %r0,%r3,%r0
> 	rlwinm %r0,%r0,2,22,29
> 	lwzx %r9,%r10,%r0
> 	xor %r3,%r9,%r11
> 	bdnz .L18
> 	blr
> .Lfe1:
> 	.size	crc32org,.Lfe1-crc32org
> 	.align 2
> 	.globl crc32do_while
> 	.type	crc32do_while,@function
> crc32do_while:
> 	cmpwi %cr0,%r5,0
> 	beqlr- %cr0
> 	lis %r9,crc32_table@ha
> 	mtctr %r5
> 	la %r10,crc32_table@l(%r9)
> .L25:
> 	lbz %r0,0(%r4)
> 	srwi %r11,%r3,8
> 	addi %r4,%r4,1
> 	xor %r0,%r3,%r0
> 	rlwinm %r0,%r0,2,22,29
> 	lwzx %r9,%r10,%r0
> 	xor %r3,%r9,%r11
> 	bdnz .L25
> 	blr
> .Lfe2:
> 	.size	crc32do_while,.Lfe2-crc32do_while
> 	.align 2
> 	.globl crc32do_while_dec
> 	.type	crc32do_while_dec,@function
> crc32do_while_dec:
> 	cmpwi %cr0,%r5,0
> 	beqlr- %cr0
> 	lis %r9,crc32_table@ha
> 	mtctr %r5
> 	la %r10,crc32_table@l(%r9)
> 	addi %r4,%r4,-1
> .L32:
> 	lbzu %r0,1(%r4)
> 	srwi %r11,%r3,8
> 	xor %r0,%r3,%r0
> 	rlwinm %r0,%r0,2,22,29
> 	lwzx %r9,%r10,%r0
> 	xor %r3,%r9,%r11
> 	bdnz .L32
> 	blr
> .Lfe3:
> 	.size	crc32do_while_dec,.Lfe3-crc32do_while_dec
> 	.ident	"GCC: (GNU) 3.2.1"
>
[snip]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
