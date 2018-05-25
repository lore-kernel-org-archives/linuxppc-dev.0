Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sksF48TmzF1xg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:43:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-7 tag
Date: Fri, 25 May 2018 21:43:11 +1000
Message-ID: <878t88q7u8.fsf@concordia.ellerman.id.au>
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

Please pull one more powerpc fix for 4.17:

The following changes since commit c1d2a31397ec51f0370f6bd17b19b39152c263cb:

  powerpc/powernv: Fix NVRAM sleep in invalid context when crashing (2018-05-18 00:23:07 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-7

for you to fetch changes up to faf37c44a105f3608115785f17cbbf3500f8bc71:

  powerpc/64s: Clear PCR on boot (2018-05-18 16:05:15 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #7

Just one fix, to make sure the PCR (Processor Compatibility Register) is reset
on boot. Otherwise if we're running in compat mode in a guest (eg. pretending a
Power9 is a Power8) and the host kernel oopses and kdumps then the kdump
kernel's userspace will be running in Power8 mode, and will SIGILL if it uses
Power9-only instructions.

Thanks to:
  Michael Neuling.

- ----------------------------------------------------------------
Michael Neuling (1):
      powerpc/64s: Clear PCR on boot

 arch/powerpc/kernel/cpu_setup_power.S | 6 ++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c     | 1 +
 2 files changed, 7 insertions(+)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbB/bPAAoJEFHr6jzI4aWADOAP/iK5Tnxdd6NnVan9szsvmQpO
TFwOB+/bYERdJfNIybe6IWCvMnRPpLWeL0tSbh9zcbx5O9QJgueOy/XxdzAvuDpk
nexT03cCPS6llAcVI4HvhigfO4zUQB+pfSu5/XHjZGCqwAKP+OVBv8BuQbC6J6DV
p8Kx1EpkG5kBvsN3OxwMCNjX4f99qpBEAWvDuV0Th0H1elr9kjNmkrSn6kV/56M3
MXpuAknP9QPBddiV2SbgMFw5WwmT31h3BAbTDJok64LcKVAw2PWO/YLMdYl27Gy2
6Zwern6hK9fy620JnPExNbNzME0tlgtBYpPOYUezsjg+XDxED+bwNrzEIb14HgcJ
mtzd3TZUJ5GznlbxzeSso7LNsJ8CFG5k9zYtg80s3K67Z1BPosV/xXi/BR53iYDU
fw+u4QqA1P/fp6wq3VWI37oyqbtMnBz/C0Lx1vbcFDBGs2rtz0+EmoBBQBxWAZ2Z
CuWiuGyd+rOhMIcLX+KsnIKPLadrbj4s7EBYR+kZa7JnS2tvToLp5PjLpQaBUVSR
vD6WzRRg2vH6/aicjRUjmduUCzBkaNtQjokkyv0kZqiUnnglxUbLvloprjZHEaKK
VpBANpHV+N74lGwiGJFTKeEmxp6VDC7BQWSSWKvve8LwwcK6rhyQOoPPwo7NN7yp
ubkeS/hnoX2H2YBP6BbT
=3Iqr
-----END PGP SIGNATURE-----
