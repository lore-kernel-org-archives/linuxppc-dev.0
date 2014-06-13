Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 507F21A0566
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 15:16:02 +1000 (EST)
Date: Fri, 13 Jun 2014 15:15:59 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: Kernel build issues after yesterdays merge by Linus
Message-ID: <20140613051559.GC19628@thor.bakeyournoodle.com>
References: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
 <20140612220912.3447677f@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
In-Reply-To: <20140612220912.3447677f@kryten>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@gentwo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2014 at 10:09:12PM +1000, Anton Blanchard wrote:

> The TOC symbol export is special and I think we might need to get our
> script to ignore it.

Try this (untested) patch.  If it's good I'll send it to Ben.


diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
index 3f46e8b..34e3f25 100755
--- a/arch/powerpc/relocs_check.pl
+++ b/arch/powerpc/relocs_check.pl
@@ -45,6 +45,9 @@ while (<FD>) {
 		 /\bR_PPC_ADDR16_HA\b/ or /\bR_PPC_RELATIVE\b/ or
 		 /\bR_PPC_NONE\b/);
=20
+	# The TOC is "special" so let's ignore it.
+	next if (/__crc_TOC\./);
+
 	# If we see this type of relocation it's an idication that
 	# we /may/ be using an old version of binutils.
 	if (/R_PPC64_UADDR64/) {

<snip>
=20
> Shows how much we use make install :) Below is a quick hack to get you go=
ing
> but we should look at either fixing the Ubuntu installkernel to handle
> extra optional args, or stop passing them from the ppc64 kernel
> install.sh script.

It seems like passign the zImage files is probably wrong.  How about:


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ccc25ed..146d898 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -390,7 +390,7 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
=20
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map =
"$(INSTALL_PATH)" $^
+	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map =
"$(INSTALL_PATH)"
=20
 # anything not in $(targets)
 clean-files +=3D $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJTmokPAAoJEPvNNsFAAoTB8nAP/RyTAt2otQLgvTD6X7HQIwkU
H9FH++ZCpJUq6RIw2og2FzC747jRza6ypimYOI0DaLvouhm3LL38KtLYbmw34+hm
K9FuZ/f18KCvacvOWjfCC/ykZ1vjwVKT7AzZvtt8GHxqyKfkqWOo4sFvP+fH2QgK
1AFXQ3LDx5jRGimjTitd7I9b5J14C3vEUKer1fRGDYHI+4ygEEwCxDT/LchhVAIi
bHu1nbKsSJJCVEVFtPlZCMuqA2I/EA7hNZw6ahixAFEo3NuiTdc/mQtIu+iRzlh7
k1o/c16vsAqfCa6uSEX/m+uMiermVEHMHR8J0Z/Y9vyH5KEYsonuPfTOsNzJrb6T
STAXD1klZgN72pbUnO3aYTuP0auZDWvpflF0UfeucOLlwIKlk1XdNWNx9bJfMkz+
/TIQHLCBmmKhYeRpZX0GNiN7my1BgslHvoyW3KKK9k0IPJ0GeLX+vTUBMxFbqLg8
FMbjxMFfPLGUvcoB1Cqjf7fbK4cEDMtkC3WYPLL0Lg3qcg/WFIc496O1lZdR5QRg
cPMvTd49jUhv04B86xn55B4abD/dl1EO/GyLp6unHhWwLhawyEXLDlckn6dvZC9B
LUNUMNdP0UGZyydcNfYUzEJ4cUlEeWncEueOOz8pDHvVwc+ITVi87rsCONLtl7M1
cDY6HjwvNi1Jjs9toatu
=K2DN
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
