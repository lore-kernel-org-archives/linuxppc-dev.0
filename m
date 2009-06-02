Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id 0AF30DDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 04:46:04 +1000 (EST)
Date: Tue, 02 Jun 2009 20:45:55 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFEEF9A8F1.2B11D1F7-ONC12575C8.00214DF9-C12575C8.00224E4F@transmode.se>
	(from joakim.tjernlund@transmode.se on Mon Jun  1 08:14:43 2009)
Message-Id: <1243968361.4951.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-khL/OpVkhe9B1GXUpsJ/"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-khL/OpVkhe9B1GXUpsJ/
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.06.09 08:14 schrieb(en) Joakim Tjernlund:
> .. not even 4.2.2 which is fairly modern will get it right. It breaks =20
> very easy as gcc has never been any good at this type of =20
> optimization. Sometimes small changes will make gcc unhappy and it =20
> won't do the right optimization.

It's even worse...  Looking at the assembly output of the simple =20
function

<snip>
void loop2(void * src, void * dst, int n)
{
   volatile uint32_t * _dst =3D (volatile uint32_t *) (dst - 4);
   volatile uint32_t * _src =3D (volatile uint32_t *) (src - 4);
   n >>=3D 2;
   do {
     *(++_dst) =3D *(++_src);
   } while (--n);
}
</snip>

gcc 4.0.1 coming with Apple's Developer Tools (on Tiger) with options =20
"-O3 -mcpu=3D603e -mtune=3D603e" produces

<snip>
_loop2:
         srawi r5,r5,2
         mtctr r5
         addi r4,r4,-4
         addi r3,r3,-4
L11:
         lwzu r0,4(r3)
         stwu r0,4(r4)
         bdnz L11
         blr
</snip>

which looks perfect to me.  However, gcc 4.3.3 on Ubuntu/PPC produces =20
with the same options

<snip>
loop2:
         srawi 5,5,2
         stwu 1,-16(1)
         mtctr 5
         li 9,0
.L8:
         lwzx 0,3,9
         stwx 0,4,9
         addi 9,9,4
         bdnz .L8
         addi 1,1,16
         blr
</snip>

wasting a register and a statement in the loop core, and fiddles around =20
with the stack pointer for no good reason.  Gcc 4.4.0 produces

<snip>
loop2:
         srawi 5,5,2
         mtctr 5
         li 9,0
.L9:
         lwzx 0,3,9
         stwx 0,4,9
         addi 9,9,4
         bdnz .L9
         blr
</snip>

which drops the r1 accesses, but still produces the sub-optimal loop.  =20
Is this a gcc regression, or did I miss something here?  Probably the =20
only bullet-proof way is to write some core loops in assembly... :-/

Thanks, Albrecht.

--=-khL/OpVkhe9B1GXUpsJ/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKJXNpn/9unNAn/9ERAqJSAJ9k4au6BgBXOhTGLarpwepKdu5HhACgzP8y
B+rwzyauDB4jLtntXOW2MaM=
=qG8D
-----END PGP SIGNATURE-----

--=-khL/OpVkhe9B1GXUpsJ/--
