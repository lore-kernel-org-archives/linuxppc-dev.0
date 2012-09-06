Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 2BA6A2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 17:12:02 +1000 (EST)
Date: Thu, 6 Sep 2012 17:11:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
 tree related)
Message-Id: <20120906171153.c80e87ea8db3dd3f4ac87cf5@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__6_Sep_2012_17_11_53_+1000_9qgwl6mOfInQ1Z19"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Sep_2012_17_11_53_+1000_9qgwl6mOfInQ1Z19
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc allyesconfi=
g)
failed like this:

In file included from drivers/atm/fore200e.c:70:0:
drivers/atm/fore200e.h:263:3: error: redefinition of typedef 'opcode_t' wit=
h different type
arch/powerpc/include/asm/probes.h:25:13: note: previous declaration of 'opc=
ode_t' was here

Caused by commit 7118e7e648e0 ("powerpc: Consolidate {k,u}probe
definitions") from the powerpc tree.

I have reverted that commit (and the two following:
41ab5266c362	"powerpc: Add trap_nr to thread_struct"
8b7b80b9ebb4	"powerpc: Uprobes port to powerpc")
for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__6_Sep_2012_17_11_53_+1000_9qgwl6mOfInQ1Z19
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQSEy5AAoJEECxmPOUX5FEo0EQAIALijyHzcSPJTpOkXOC5al6
1hc+LVqeBwRSwuLJyXObyXTIIU1C9kaDB3ziJ0Ji2WXG7M8FEHf8K8q1xbw6fQ8A
whcIZjVlZ7gfj+l31iFGsLqMI2sZq1V1Pk2/zuZst7HrDS3AsDLxQY7xRSIW7W+u
nSLrzrIFA1n9r0SVhtelVNSUE471g4kJ7ww4aI8rig72m08zD/AzfK9zFkHxhH00
4LXIHqTYhWTsMIhk79UirBFWLyinKStS7uCIfBF2Cxxlqao0mrrPlEDTd3VBRiEk
IgHVzu4lQ+pquI0Fk7IjbkmxGWyMsR3X1cyt6tl9EAuy95iW/HIB8H02heL2ka0U
v55XAibbgn04WTlLROZFRSyWlsGXg7Fp/yL83x2lHpbysBlO+vNk9uFt1kugMcU6
9nW75BpyDQWoHQbOZFoK+N5NChw0qEyZz4iCMBuj44BGY9XJgRaR0Se2nOh2D6co
6tCDBsPM8r+tUEsnZ2/W1EmzLmw1xg+R/SnrxaYPIbJUZhS/B5FRIiZhadNJHFbF
02GC63qd3S5GxbWRFY5QCM5XIBU0e2kKNBga8czTxNr619ehXnUiZ/C/4rdfRJyQ
OVfAKCYmSctefKyKo4ITfW4+AbLJlBSCN7609lrpR/ykcMLJ67dky1oLaOCViEfc
jTogHNotM+TNnccFAWrO
=xExw
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Sep_2012_17_11_53_+1000_9qgwl6mOfInQ1Z19--
