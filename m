Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (gwmail.lzu.edu.cn [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id D94DDDDEE6
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 19:37:56 +1000 (EST)
Message-ID: <380406375.32007@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Is it possible to call a C function in
	transfer_to_handler(arch/ppc/kernel/entry.S)?
Date: Mon, 28 May 2007 17:30:35 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8255300.fhl4F3DXJS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200705281730.39257.wangbj@lzu.edu.cn>
Cc: Nicholas McGuire <der.herr@hofr.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart8255300.fhl4F3DXJS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, list

  I'm sorry to ask this topic in this mailling list. I've spend more than 2=
=20
days try to add a C function call in transfer_to_handler(in=20
arch/ppc/kernel/entry.S) like this:

/* cut from arch/ppc/kernel/entry.S */
transfer_to_handler:
        stw     r2,GPR2(r11)
        stw     r12,_NIP(r11)
        stw     r9,_MSR(r11)
        andi.   r2,r9,MSR_PR
        mfctr   r12
        mfspr   r2,SPRN_XER
        stw     r12,_CTR(r11)
        stw     r2,_XER(r11)
        mfspr   r12,SPRN_SPRG3
        addi    r2,r12,-THREAD
        tovirt(r2,r2)                   /* set r2 to current */
        beq     2f                      /* if from user, fix up THREAD.regs=
 */
#if 1	/* this is add by me */
        stwu    r1, -16(r1)
        mflr    r0
        stw     r0, 20(r1)
        bl      emulate_iret
        lwz     r0, 20(r1)
        mtlr    r0
        addi    r1, r1, 16
#endif
        addi    r11,r1,STACK_FRAME_OVERHEAD
        stw     r11,PT_REGS(r12)


The function prolog is taken from a userspace program. this code freeze the=
=20
system after prints out `emulate_iret' (The only thing function emulate_ire=
t=20
do is print that message).=20

I read the source code from head_44x.S to entry.S, sounds like all register=
s=20
(r0-r32, and even more such as _LINK, _CTR, etc..) are being saved, does th=
at=20
mean I shouldn't call any C function in transfer_to_handler()? Is there=20
something tricky (or is it possible) to add a C function call?=20

Thanks in advance!

regards

=2D-=20
Wang, Baojun                                        Lanzhou University
Distributed & Embedded System Lab              http://dslab.lzu.edu.cn
School of Information Science and Engeneering        wangbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000                     .P.R.China
Tel:+86-931-8912025                                Fax:+86-931-8912022

--nextPart8255300.fhl4F3DXJS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGWqE8IuIOr7tpgg0RArKRAJ9IU7kdQvzxENuARQk6NkfmPTOpyACePm3w
olS9dD3ceCU9ymIFE2K0Wps=
=Qoed
-----END PGP SIGNATURE-----

--nextPart8255300.fhl4F3DXJS--
