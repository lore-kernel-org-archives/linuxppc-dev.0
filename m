Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzYST59w2zDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 20:59:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-8 tag
Date: Fri, 30 Jun 2017 20:59:19 +1000
Message-ID: <87tw2xpwqg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull hopefully the last two powerpc fixes for 4.12.

The CXL one is larger than I'd usually send at rc7, but it fixes new
code this cycle, so better to have it working for the release. It was
actually sent a few weeks back but got blocked in testing behind another
fix that was causing issues.

We are still tracking one crash in v4.12-rc7, but only one person has
reproduced it and the commit identified by bisect doesn't touch any of
the relevant code, so I think it's 50/50 whether that commit is actually
the problem or it's some code layout / toolchain issue.

cheers

The following changes since commit 34f19ff1b5a0d11e46df479623d6936460105c9f:

  powerpc/64: Initialise thread_info for emergency stacks (2017-06-23 13:25:38 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-8

for you to fetch changes up to d6bd8194e2867e85ac2de63486d3b83ccfae4e62:

  powerpc/32: Avoid miscompilation w/GCC 4.6.3 - don't inline copy_to/from_user() (2017-06-26 23:25:08 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #8

Two fixes for code we merged this cycle:

 - cxl: Fixes for Coherent Accelerator Interface Architecture 2.0
 - Avoid miscompilation w/GCC 4.6.3 on 32-bit - don't inline copy_to/from_user()

Thanks to:
  Al Viro, Larry Finger, Christophe Lombard.

----------------------------------------------------------------
Christophe Lombard (1):
      cxl: Fixes for Coherent Accelerator Interface Architecture 2.0

Michael Ellerman (1):
      powerpc/32: Avoid miscompilation w/GCC 4.6.3 - don't inline copy_to/from_user()

 arch/powerpc/include/asm/uaccess.h |  8 +-------
 drivers/misc/cxl/context.c         |  6 +++---
 drivers/misc/cxl/cxl.h             | 18 +++++-------------
 drivers/misc/cxl/fault.c           | 23 +++++++++++++++--------
 drivers/misc/cxl/main.c            | 17 +++++++++++++----
 drivers/misc/cxl/native.c          | 29 +++++++++++++++++------------
 drivers/misc/cxl/pci.c             | 11 ++++-------
 7 files changed, 58 insertions(+), 54 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZVi8IAAoJEFHr6jzI4aWAObAP/ibiGxJ0kirpBZhgK1p8Cm+Y
DXF/HUSzgn5AAIb4Tnkoj8usFYyHb4szGkx54ngEyfIiX5UqkN2/ZdYXMYRf5Ks5
FrDffjoU0+HeEFl0UgZ8DnbbFgSWbwOyOzNaIr3eV6aCRjNKjAmDuDUDsqpxbgGX
8UqAEYw3POkRIzTt7fmdcfVvvGG6pno98w1kuepWgbT07XuzFqUz8VOHM/8pP32O
AKmolBO3JH1vn9r2F4hDrcbEEB9zF9j0hZrXTy5RQV7qpEZxIlQWGgNqzGCIaeHR
VycNLvIcJECN6A5OzcWl2P/KlPUUZtEVy6PlbDuoo+A4FFouuXKlZHI5nlzpPip9
ABNRq9zHeCyUaXcpxxCCyEQlXA0q5btFFLb+3T79tZE2uosCYLfIdpC1WgeGl91q
oPq+lZZ0UHefuO+HCH1qJfrDECx4qfm9bJsQmoh2UrQW/hsVhwbjAiHaUN6uhzYT
948i/SJctFRKPc6h+t0hLk8nqmb+8ri2LWhguIebPNZCt3L9vHDRTra7CQNThQrV
IrIKcN39U1kpW+KFBThvJ+eE22utVQMq2WMJlrmPkRANr9Kd7EYXui4B9a9cqAW2
TZgq3GvKqRcEBFk0JoT8Iozs/5OIVPQsz54t1runMP9FtiP+AXOAfeQtLGXYtoxY
t0OFSSbVzkzw8btboskh
=rc+B
-----END PGP SIGNATURE-----
--=-=-=--
