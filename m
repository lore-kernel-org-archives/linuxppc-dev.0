Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SGrz2RpTzDrq2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 23:28:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com, mikey@neuling.org,
 ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-3 tag
Date: Fri, 20 Apr 2018 23:28:28 +1000
Message-ID: <87k1t2j9c3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 4.17:

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-3

for you to fetch changes up to 56376c5864f8ff4ba7c78a80ae857eee3b1d23d8:

  powerpc/kvm: Fix lockups when running KVM guests on Power8 (2018-04-19 16:22:20 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #3

Fix an off-by-one bug in our alternative asm patching which leads to incorrectly
patched code. This bug lay dormant for nearly 10 years but we finally hit it
due to a recent change.

Fix lockups when running KVM guests on Power8 due to a missing check when a
thread that's running KVM comes out of idle.

Fix an out-of-spec behaviour in the XIVE code (P9 interrupt controller).

Fix EEH handling of bridge MMIO windows.

Prevent crashes in our RFI fallback flush handler if firmware didn't tell us the
size of the L1 cache (only seen on simulators).

Thanks to:
  Benjamin Herrenschmidt, Madhavan Srinivasan, Michael Neuling.

- ----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc/xive: Fix trying to "push" an already active pool VP

Madhavan Srinivasan (1):
      powerpc/64s: Default l1d_size to 64K in RFI fallback flush

Michael Ellerman (2):
      powerpc/lib: Fix off-by-one in alternate feature patching
      powerpc/kvm: Fix lockups when running KVM guests on Power8

Michael Neuling (1):
      powerpc/eeh: Fix enabling bridge MMIO windows

 arch/powerpc/kernel/eeh_pe.c      |  3 ++-
 arch/powerpc/kernel/idle_book3s.S |  4 ++--
 arch/powerpc/kernel/setup_64.c    | 11 +++++++++++
 arch/powerpc/lib/feature-fixups.c |  2 +-
 arch/powerpc/sysdev/xive/native.c |  4 ++++
 5 files changed, 20 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa2er8AAoJEFHr6jzI4aWAnc4P/2uaDmQ4NN9ETvsn11Ii6y9B
umuQ/TnFmS8piP9LrLyh5A0DNEheEizLf44qJDaXfgnJtV2+ZgKeW8kyzpdOYH1F
B6+Rq25gZ2ItBrKv8vrcfGyBFplVfSfg3KO/NC2tBoB/COCKA2lj6lxo1CvZ8BLq
Ov05mm2grmQ20XJgFQjAiK+GT6JKsra5Vc8WcpX3xj4DOP9yXvJpm5Ui+1RpqK0U
ZuKHocSKUQdIvQBuPcrqU6IVHN51lQLtvb//s3TUpMRS7sb7/y4VHBou93FsT8LZ
rjNKM4104u79ZN7SERRF17bqdY0fgmqHeAB1U8lxP8QvYo14z5ix99d9KjunDHt2
IRI25AhgHo4dfdcFr7sl3fg+85/Njwj4T7a2KPGw0FW4dIwPklodYzxnlVpbBQMB
92J8fKC6G0UsVza2KLySuGY1AO1FvAXw+84JfeqpBsShpH7op2QSa7GjxgF7YeXz
w0guFuUKBOlmiyuuTaq7HPGNVZBqmyAIpTaTKmv/L7pnaOY/fL14y4zPyKDav9VN
E6wLxqh0b1kOMaOzZelps8Isrd/5LCx9wmv6TnZCjGazoy6GtV0NTt4Nl8l0wjJW
uvDm8h6MOnwLG282OyKBJee79vBxKUey3cl41Y5DCkqJDmymnqTCCn/lF24zJ3nf
qpYttmW/n2nfdR/VSEZM
=UKi3
-----END PGP SIGNATURE-----
