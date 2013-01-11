Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id E2DB62C01C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 16:52:51 +1100 (EST)
Date: Fri, 11 Jan 2013 16:52:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the final tree (powerpc
 tree related)
Message-Id: <20130111165241.44a5ede6b24c997810be74e1@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__11_Jan_2013_16_52_41_+1100_HYpva/npX.Lrv51c"
Cc: Michael Neuling <mikey@neuling.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jan_2013_16_52_41_+1100_HYpva/npX.Lrv51c
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (powerpc
allyesconfig) failed like this:

arch/powerpc/kernel/kgdb.c: In function 'kgdb_arch_exit':
arch/powerpc/kernel/kgdb.c:492:2: error: '__debugger_breakx_match' undeclar=
ed (first use in this function)

Caused by commit 9422de3e953d ("powerpc: Hardware breakpoints rewrite to
handle non DABR breakpoint registers").  I applied "powerpc: Fix typo in
breakpoint kgdb code" from Mikey for this.

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1204: Error: attempt to move .org back=
wards

Not sure what caused that - probably a combination of patches adding code
low down.  I have just left this broken for today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__11_Jan_2013_16_52_41_+1100_HYpva/npX.Lrv51c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQ76ipAAoJEECxmPOUX5FE7tQQAIFdZpJ78SNjcr9cc+ia823y
7i+bezSWLUGToKHZJ87ajVtMCpImEVCsQa2Hq1GahBlj9vQJmpkGQ79GD1bxt6wW
behryfUSf3ORzVKseUsrXQ53FI35jSk38hL4xNqGH5sbtarZb6fPlWN4iPiFwo6k
5QIoYo5MabgvQEHOJBNiuX2XqEdFYgHM7qZ8SMSImnAJE1MHYt/dmx6AdVFoKNXq
JXcPPBmmnjXnK1JKst5tnti+AmGimIaHPfsf3FSj1JGApPFIovQtU5kPH2HeNz1S
v0QY6xski27Dy9CQNkWIa4vov0ok7DJ3vqbRxCfVZWCE0G4/EHRikUclmQE8gsQq
5xplD+oOAS0pzKMnbFxi62gBv+9tWwoSFrgjneQjHkXpoFmpS/Khn152K0XX4IH+
4C22CF5HJvLT4MfaU7AiaafBI8GIU53tVXMTecOlPYXZiuoOmBcDvunvyFW0le9k
bLq3YRh3H4s/cSN/jEgtyuiQUXZxSo45uv0i/xEHpVz3DMe3+KfFCTe0dIiJihIJ
DktVGtoi+wm2TJC01hV8XammK+OxYL1pkS1CwapD+bUJls1Xctu+UzQ2L+obOdkf
rJpf/9I2Z5xvrPPeKf8+UVVO6zQvp//Y/pgJnmjLZMZ3dcQ+00rFbx73Fu/+BCwy
GLOceTmxfvFMH4uLUrUh
=k6Ic
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jan_2013_16_52_41_+1100_HYpva/npX.Lrv51c--
