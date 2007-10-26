Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 89AE7DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 19:50:48 +1000 (EST)
Message-ID: <393454580.24977@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: ppc manual paging question
Date: Fri, 26 Oct 2007 17:50:51 +0800
References: <200710221203.24157.wangbj@lzu.edu.cn>
	<200710221542.10592.wangbj@lzu.edu.cn> <393040796.08064@lzu.edu.cn>
In-Reply-To: <393040796.08064@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6457997.rmyWsQdic4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710261750.54221.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6457997.rmyWsQdic4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 October 2007 16:04:14, Benjamin Herrenschmidt wrote=EF=BC=9A
> > Yup, I've found how does the kernel handle tlbs, I think the most
> > important thing is I forgot read/write the SPRN_SPRG3 register as _swit=
ch
> > does.
>
> SPRG3 is for use by the operating system for whatever you want... if you
> are copying linux code, then you probably indeed want to get that right
> but you don't have to use SPRG3.
>
> > I've add the _PAGE_PRESENT flag to the related PTE
>
> Hrm.. that has nothing ot do with the PTE. Bolting is more a property of
> your replacement algorithm in the TLB miss handler.
>
> Ben.

Hi,

  First thanks a lot for your help I've finish the tlb code, now I can=20
manually translate the virtual address correctly, I verified this by printi=
ng=20
out the data within the virtual address and it's fine. now the only thing=20
left is jump to that address (the address is point to _start function), But=
 I=20
got an error about unable to access the stack (0xd100fc60 ...), but it is=20
valid before the instruction:

/**
 * XXX: should not defined here
 */
#define EVENTS_USER_ADDR_OFFSET 36

_GLOBAL(jump_xm_dom)
        stwu    r1,-INT_FRAME_SIZE(r1)
        mflr    r0
        stw     r0,INT_FRAME_SIZE+4(r1)

        stw     r31,INT_FRAME_SIZE+128(r1)

        lwz     r5,EVENTS_USER_ADDR_OFFSET(r4)
        mr      r31,r5  /* new_domain->events_user_addr */

        cmpwi   r3,0
        beq     1f

        mtctr   r3      /* jump to entry_point */
        bctrl

        li      r3,0
1:
        lwz     r31,INT_FRAME_SIZE+128(r1)

        lwz     r0,INT_FRAME_SIZE+4(r1)
        addi    r1,r1,INT_FRAME_SIZE
        mtlr    r0
        blr

the SP is valid before `bctrl', while exec bctrl, I got the error said unab=
le=20
to access address SP ($r1) from bdigdb, without bdigbd (running directly), =
an=20
error is print out while the system is dead:=20

insn: 94 21 ff 40 7c 08 02 a6 90 01 00 c4 7f e3 fb 78 3d 20 10 01 90 69 07 =
a0=20
48 00 02 55 80 01 00 c4
$T0440:10000094;01:d1072e60;#ee

address d1072e60 is the address of SP ($r1) before bctrl.

NOTE entry_point($r3) is address like 0x100000a0 which is loaded from the=20
userspace by a loader program (it loads all section marked as PT_LOAD, such=
=20
as .text, the above insn is the entry of .text section, which is _start), b=
ut=20
the above code is from the kernel space. and here is the _start function:

#define INT_FRAME_SIZE  192

=2Eglobl _start
_start:
        stwu    1, -INT_FRAME_SIZE(1)
        mflr    0
        stw     0, INT_FRAME_SIZE+4(1)

        mr      3,31    /* new_domain->events_user_addr */

        lis     9, event_handling@ha
        stw     3, event_handling@l(9)
        bl      kmain

        lwz     0, INT_FRAME_SIZE+4(1);
        mtlr    0
        addi    1, 1, INT_FRAME_SIZE
        blr

=2Esize   _start, .-_start

I'm sorry I'm not very familiar with the ppc assembly, is there something=20
fundamentally wrong? Thank you very much!

  Regards,
Wang

=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022

--nextPart6457997.rmyWsQdic4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHIbh7IuIOr7tpgg0RAvmxAKCh90t9JrX5Wa6R7HN5rHEVsjMeIgCfXTJg
tB79e/GXZb0Fy2gGXTHQVVs=
=JRW3
-----END PGP SIGNATURE-----

--nextPart6457997.rmyWsQdic4--
