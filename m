Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9AC31A033E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 17:37:34 +1100 (AEDT)
Date: Tue, 24 Mar 2015 17:37:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the kselftest tree with the powerpc-mpe
 tree
Message-ID: <20150324173725.442f88c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+_SYdCU37V1BehUDV.18aQf"; protocol="application/pgp-signature"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sam Bobroff <sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/+_SYdCU37V1BehUDV.18aQf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

Today's linux-next merge of the kselftest tree got a conflict in
tools/testing/selftests/powerpc/Makefile between commit a908f5de3b10
("selftests/powerpc: Rename TARGETS in powerpc selftests makefile")
from the powerpc-mpe tree and commit 6faeeea44b84 ("selftests: Add
install support for the powerpc tests") from the kselftest tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc tools/testing/selftests/powerpc/Makefile
index 27dff8241de3,2958fe9a74e9..000000000000
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@@ -8,27 -8,41 +8,41 @@@ ifeq ($(ARCH),powerpc
 =20
  GIT_VERSION =3D $(shell git describe --always --long --dirty || echo "unk=
nown")
 =20
- CC :=3D $(CROSS_COMPILE)$(CC)
  CFLAGS :=3D -Wall -O2 -flto -Wall -Werror -DGIT_VERSION=3D'"$(GIT_VERSION=
)"' -I$(CURDIR) $(CFLAGS)
 =20
- export CC CFLAGS
+ export CFLAGS
 =20
 -TARGETS =3D pmu copyloops mm tm primitives stringloops
 +SUB_DIRS =3D pmu copyloops mm tm primitives stringloops vphn
 =20
  endif
 =20
 -all: $(TARGETS)
 +all: $(SUB_DIRS)
 =20
 -$(TARGETS):
 +$(SUB_DIRS):
  	$(MAKE) -k -C $@ all
 =20
- run_tests: all
+ include ../lib.mk
+=20
+ override define RUN_TESTS
 -	@for TARGET in $(TARGETS); do \
 +	@for TARGET in $(SUB_DIRS); do \
  		$(MAKE) -C $$TARGET run_tests; \
  	done;
+ endef
+=20
+ override define INSTALL_RULE
 -	@for TARGET in $(TARGETS); do \
++	@for TARGET in $(SUB_DIRS); do \
+ 		$(MAKE) -C $$TARGET install; \
+ 	done;
+ endef
+=20
+ override define EMIT_TESTS
 -	@for TARGET in $(TARGETS); do \
++	@for TARGET in $(SUB_DIRS); do \
+ 		$(MAKE) -s -C $$TARGET emit_tests; \
+ 	done;
+ endef
 =20
  clean:
 -	@for TARGET in $(TARGETS); do \
 +	@for TARGET in $(SUB_DIRS); do \
  		$(MAKE) -C $$TARGET clean; \
  	done;
  	rm -f tags
@@@ -36,4 -50,4 +50,4 @@@
  tags:
  	find . -name '*.c' -o -name '*.h' | xargs ctags
 =20
- .PHONY: all run_tests clean tags $(SUB_DIRS)
 -.PHONY: tags $(TARGETS)
++.PHONY: tags $(SUB_DIRS)

--Sig_/+_SYdCU37V1BehUDV.18aQf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVEQYtAAoJEMDTa8Ir7ZwVOagP/1razoHji4tCGmKiJl1q28qz
GRvMwAbBJYZezNMm+kESDs2oDwq7B4leJJ4NQZc2JDBNXtiTGB2pycxTfKGtfMUF
22X/GMb0I2YdBpXwnOHn4JB1SOmW754w5sLq3W/EXt+FyomMrwVjgHFmGh9TmxZy
bBHN/EDMSl1jJkuSarSlDsGpKntBdjVAGvzelXuOL4VfELWtFbBN4HSWWyKJ19Rb
lh/zgZsWUl3xJZe9caboePn9DUyUdaPJIOvhtphK1GIEAGLXDvJBWbFHcaxeRepl
0y0JDL/yvXe7met4ihtKFD8PWF90tYISRdOH5h8VQ5OgT09dXC8bw3lRBW+XzuWQ
GP9p7joCDmfpXnBcXTJgLlUyCs5uAPWmHLtUOkw7bLX5i7zUP+XW3fN5qdHPTj2H
W28qsCeG7d2+6rUycXibEncyNfMnAf9WGY5iF59enmyWJvHnc4tmjwM9OAdUbRj7
M5ldD0+c0TACOKQP8ZJfblZ3c4PB7pdjSlXGcVoabZIudW1lSSgesiqGaOYvdeIl
JVJ9KCpS99zqsaxPdXTPprJNFN/759P1XGHRbdQ/YVeCkuLE4cMJvo0gPLI+vSwU
BBzSZtFIYKcxy09QLpRKOZ0vFxv7PoDgkS+gAC+7PPIOT3MsX8Xdcm8ylEdaUIte
+c6ppvdwhpaio7mwfmYL
=XXhX
-----END PGP SIGNATURE-----

--Sig_/+_SYdCU37V1BehUDV.18aQf--
