Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 14/22] spufs: use SPU master control to prevent wild
	SPU execution
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20061120180525.281408000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180525.281408000@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-l7LLhPe2wjgBvnxiMmA4"
Date: Thu, 01 Mar 2007 15:18:10 +0900
Message-Id: <1172729890.5852.40.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-l7LLhPe2wjgBvnxiMmA4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-20 at 18:45 +0100, Arnd Bergmann wrote:
> plain text document attachment (spufs-master-control.diff)
> When the user changes the runcontrol register, an SPU might be
> running without a process being attached to it and waiting for
> events. In order to prevent this, make sure we always disable
> the priv1 master control when we're not inside of spu_run.

Hi Arnd,

Sorry I didn't comment on this when you sent it, I wasn't paying enough
attention. This patch confuses me, you say we should make sure we always
disable the master control when we're not inside spu_run, but I see
several exit paths where we leave the master run bit enabled - or maybe
I'm reading it wrong.

I think I've also seen it happen:

[root@localhost dma5]# ./put-test=20
10963.13
[root@localhost dma5]# find /spu
/spu
[root@localhost dma5]# echo x > /proc/sysrq-trigger=20
SysRq : Entering xmon

0:mon> ss
..
Stopped spu 06, was running (mfc_sr1: 0x32 runcntl: 0x1)
Stopped spu 07, was running (mfc_sr1: 0x32 runcntl: 0x1)
..

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-l7LLhPe2wjgBvnxiMmA4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF5nAidSjSd0sB4dIRAmgwAJ9Ja8Zfk042+yCpVJwB2Wej1dQRBACfSb9G
uyvInkx7Ldhi82Y32Te3SHY=
=rXMY
-----END PGP SIGNATURE-----

--=-l7LLhPe2wjgBvnxiMmA4--
