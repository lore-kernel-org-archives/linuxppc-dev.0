Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6104467BB6
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 20:09:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 5/16] hypervisor functions for Celleb
Date: Sat, 18 Nov 2006 10:08:53 +0100
References: <200611150937.kAF9b305001499@toshiba.co.jp>
	<45AC8C44-8193-4311-B4BF-BF7FF56C8DF4@watson.ibm.com>
	<20061117052158.GB670@krispykreme>
In-Reply-To: <20061117052158.GB670@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611181008.54345.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 November 2006 06:21, Anton Blanchard wrote:
> > Just make another one (or a set of them like the phyp calls) and =A0
> > define then in assembly.
> > Certainly a bl to a function will be negligible to the hcall its self.
>=20
> Agreed. And I thought the phyp hcall code was ugly :)
>=20
> Any ideas why its so different? Just NIH?
>=20
Yeah, mostly that. The hcall functions were developed separately in
each company, and the Sony/Toshiba calling conventions seem to be
too different from the phyp ones to easily adapt those, at least
the version before your latest cleanup.

I wonder if we now should just do something as simple as the code
below.

=2D--------------

#define PS3_HCALL_BUFSIZE 6
#define BEAT_HCALL_BUFSIZE 6
long ps3_hcall(unsigned long opcode, unsigned long *retbuf, ...);
long beat_hcall(unsigned long opcode, unsigned long *retbuf, ...);

=2D---------------

_GLOBAL(beat_hcall)
_GLOBAL(ps3_hcall)
	HMT_MEDIUM

	mfcr	r0
	stw	r0,8(r1)

	HCALL_INST_PRECALL

	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */

	mr	r11,r3
	mr	r3,r5
	mr	r4,r6
	mr	r5,r7
	mr	r6,r8
	mr	r7,r9
	mr	r8,r10
	ld	r9,STK_PARM(r11)(r1)	 /* put arg7 in r9 */

	HVSC				/* invoke the hypervisor */

	ld	r12,STK_PARM(r4)(r1)
	std	r4,   0(r12)
	std	r5,   8(r12)
	std	r6,  16(r12)
	std	r7,  24(r12)
	std	r8,  32(r12)
	std	r9,  40(r12)

	HCALL_INST_POSTCALL

	lwz	r0,8(r1)
	mtcrf	0xff,r0

	blr				/* return r3 =3D status */

_
