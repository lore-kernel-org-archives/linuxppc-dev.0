Subject: Re: glibc: optimized ppc bcopy
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Rob Latham <rob@terizla.org>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030411210449.GC92837@terizla.org>
References: <20030411210449.GC92837@terizla.org>
Content-Type: multipart/mixed; boundary="=-zzOokDblRei/SP7TpTWN"
Date: 11 Apr 2003 23:37:44 +0200
Message-Id: <1050097064.1169.57.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-zzOokDblRei/SP7TpTWN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-11 at 23:04, Rob Latham wrote:
=20
> So i looked a bit closer at glibc: there are no optimized powerpc
> string or memory operations.  ( later confirmed by the glibc web
> pages)
>=20
> I know there are a zillion powerpc variants:  would it be hard to
> write assembly that works with all of them?  I know almost zero about
> powerpc assembly, but this might be a fun place to start learning.  Of
> course, if anyone else has already started such an undertaking, i'll
> defer to them and go work on something else.

You could start with this. I have not used them on a resent version of
glibc but it used to work.=20
=20
--=20
Kenneth Johansson=09
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsv=E4gen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se

--=-zzOokDblRei/SP7TpTWN
Content-Disposition: attachment; filename=bcopy.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=bcopy.S; charset=ANSI_X3.4-1968

/* Optimized bcopy `implementation' for PowerPC.
   Copyright (C) 1999 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330=
,
   Boston, MA 02111-1307, USA.  */

#include <sysdep.h>

ENTRY(bcopy)
/* void bcopy(const void *src [r3], const void *dest [r4], size_t n [r5]) *=
/
	mr	%r6,%r3
	mr	%r3,%r4
	mr	%r4,%r6
	b	memcpy@local
END(bcopy)

--=-zzOokDblRei/SP7TpTWN
Content-Disposition: attachment; filename=memcpy.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=memcpy.S; charset=ANSI_X3.4-1968

/* Optimized memcpy implementation for PowerPC.
   Copyright (C) 1996 Paul Mackerras.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330=
,
   Boston, MA 02111-1307, USA.  */

#include <sysdep.h>

ENTRY(memcpy)
/* void * [r3] memcpy(void *dest [r3], const void *src [r4], size_t n [r5])=
 */

/* Registers used:
   r0:  temporary
   r3:	saved `dest'
   r4:	pointer to previous word in src
   r5:=09
   r6:	pointer to previous word in dest
   r7:  temporary
   r8:  temporary (used to move words)
*/
	srwi.	%r7,%r5,3		/* r0 =3D r5 >> 3 */
	addi	%r6,%r3,-4
	addi	%r4,%r4,-4
	beq	2f			/* if less than 8 bytes to do */
	andi.	%r0,%r6,3			/* get dest word aligned */
	mtctr	%r7
	bne	5f
1:	lwz	%r7,4(%r4)
	lwzu	%r8,8(%r4)
	stw	%r7,4(%r6)
	stwu	%r8,8(%r6)
	bdnz	1b
	andi.	%r5,%r5,7
2:	cmplwi	0,%r5,4
	blt	3f
	lwzu	%r0,4(%r4)
	addi	%r5,%r5,-4
	stwu	%r0,4(%r6)
3:	cmpwi	0,%r5,0
	beqlr
	mtctr	%r5
	addi	%r4,%r4,3
	addi	%r6,%r6,3
4:	lbzu	%r0,1(%r4)
	stbu	%r0,1(%r6)
	bdnz	4b
	blr
5:	subfic	%r0,%r0,4
	mtctr	%r0
6:	lbz	%r7,4(%r4)
	addi	%r4,%r4,1
	stb	%r7,4(%r6)
	addi	%r6,%r6,1
	bdnz	6b
	subf	%r5,%r0,%r5
	srwi.	%r7,%r5,3
	beq	2b
	mtctr	%r7
	b	1b
END(memcpy)

--=-zzOokDblRei/SP7TpTWN
Content-Disposition: attachment; filename=memmove.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=memmove.S; charset=ANSI_X3.4-1968

/* Optimized memmove implementation for PowerPC.
   Copyright (C) 1996 Paul Mackerras.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330=
,
   Boston, MA 02111-1307, USA.  */

#include <sysdep.h>

ENTRY(memmove)
/* void * [r3] memmove(void *dest [r3], const void *src [r4], size_t n [r5]=
) */
	cmplw	0,%r3,%r4
	bgt	backwards_memcpy
	/* fall through */

forward_memcpy:
	srwi.	%r7,%r5,3		/* r0 =3D r5 >> 3 */
	addi	%r6,%r3,-4
	addi	%r4,%r4,-4
	beq	2f			/* if less than 8 bytes to do */
	andi.	%r0,%r6,3		/* get dest word aligned */
	mtctr	%r7
	bne	5f
1:	lwz	%r7,4(%r4)
	lwzu	%r8,8(%r4)
	stw	%r7,4(%r6)
	stwu	%r8,8(%r6)
	bdnz	1b
	andi.	%r5,%r5,7
2:	cmplwi	0,%r5,4
	blt	3f
	lwzu	%r0,4(%r4)
	addi	%r5,%r5,-4
	stwu	%r0,4(%r6)
3:	cmpwi	0,%r5,0
	beqlr
	mtctr	%r5
	addi	%r4,%r4,3
	addi	%r6,%r6,3
4:	lbzu	%r0,1(%r4)
	stbu	%r0,1(%r6)
	bdnz	4b
	blr
5:	subfic	%r0,%r0,4
	mtctr	%r0
6:	lbz	%r7,4(%r4)
	addi	%r4,%r4,1
	stb	%r7,4(%r6)
	addi	%r6,%r6,1
	bdnz	6b
	subf	%r5,%r0,%r5
	srwi.	%r7,%r5,3
	beq	2b
	mtctr	%r7
	b	1b

backwards_memcpy:
	rlwinm.	%r7,%r5,32-3,3,31		/* r0 =3D r5 >> 3 */
	add	%r6,%r3,%r5
	add	%r4,%r4,%r5
	beq	2f
	andi.	%r0,%r6,3
	mtctr	%r7
	bne	5f
1:	lwz	%r7,-4(%r4)
	lwzu	%r8,-8(%r4)
	stw	%r7,-4(%r6)
	stwu	%r8,-8(%r6)
	bdnz	1b
	andi.	%r5,%r5,7
2:	cmplwi	0,%r5,4
	blt	3f
	lwzu	%r0,-4(%r4)
	subi	%r5,%r5,4
	stwu	%r0,-4(%r6)
3:	cmpwi	0,%r5,0
	beqlr
	mtctr	%r5
4:	lbzu	%r0,-1(%r4)
	stbu	%r0,-1(%r6)
	bdnz	4b
	blr
5:	mtctr	%r0
6:	lbzu	%r7,-1(%r4)
	stbu	%r7,-1(%r6)
	bdnz	6b
	subf	%r5,%r0,%r5
	rlwinm.	%r7,%r5,32-3,3,31
	beq	2b
	mtctr	%r7
	b	1b
END(memmove)

--=-zzOokDblRei/SP7TpTWN
Content-Disposition: attachment; filename=mempcpy.S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=mempcpy.S; charset=ANSI_X3.4-1968

/* Optimized mempcpy implementation for PowerPC.
   Copyright (C) 1996 Paul Mackerras.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330=
,
   Boston, MA 02111-1307, USA.  */

#include <sysdep.h>

ENTRY(__mempcpy)
/* void * [r3] __mempcpy(void *dest [r3], const void *src [r4], size_t n [r=
5])
 */
	srwi.	%r7,%r5,3		/* r0 =3D r5 >> 3 */
	addi	%r6,%r3,-4
	addi	%r4,%r4,-4
	add	%r3,%r3,%r5		/* set up return value */
	beq	2f			/* if less than 8 bytes to do */
	andi.	%r0,%r6,3		/* get dest word aligned */
	mtctr	%r7
	bne	5f
1:	lwz	%r7,4(%r4)
	lwzu	%r8,8(%r4)
	stw	%r7,4(%r6)
	stwu	%r8,8(%r6)
	bdnz	1b
	andi.	%r5,%r5,7
2:	cmplwi	0,%r5,4
	blt	3f
	lwzu	%r0,4(%r4)
	addi	%r5,%r5,-4
	stwu	%r0,4(%r6)
3:	cmpwi	0,%r5,0
	beqlr
	mtctr	%r5
	addi	%r4,%r4,3
	addi	%r6,%r6,3
4:	lbzu	%r0,1(%r4)
	stbu	%r0,1(%r6)
	bdnz	4b
	blr
5:	subfic	%r0,%r0,4
	mtctr	%r0
6:	lbz	%r7,4(%r4)
	addi	%r4,%r4,1
	stb	%r7,4(%r6)
	addi	%r6,%r6,1
	bdnz	6b
	subf	%r5,%r0,%r5
	srwi.	%r7,%r5,3
	beq	2b
	mtctr	%r7
	b	1b
END(__mempcpy)

weak_alias (__mempcpy, mempcpy)

--=-zzOokDblRei/SP7TpTWN--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
