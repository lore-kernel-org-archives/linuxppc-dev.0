Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySy8c4GnWzDqvT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 20:58:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anju@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
 paulus@ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-6 tag
Date: Fri, 03 Nov 2017 20:58:46 +1100
Message-ID: <87375v7kfd.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.14.

This is bigger than I like to send at rc7, but that's at least partly
because I didn't send any fixes last week. If it wasn't for the IMC
driver, which is new and getting heavy testing, the diffstat would look
a bit better. I've also added ftrace on big endian to my test suite, so
we shouldn't break that again in future.

cheers


The following changes since commit 0d8ba16278ec30a262d931875018abee332f926f:

  powerpc/perf: Fix IMC initialization crash (2017-10-13 20:08:40 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.14-6

for you to fetch changes up to 7ecb37f62fe58e3e4d9b03443b92d213b2c108ce:

  powerpc/perf: Fix core-imc hotplug callback failure during imc initialization (2017-11-03 09:38:05 +1100)

----------------------------------------------------------------
powerpc fixes for 4.14 #6

A fix to the handling of misaligned paste instructions (P9 only), where a change
to a #define has caused the check for the instruction to always fail.

The preempt handling was unbalanced in the radix THP flush (P9 only). Though we
don't generally use preempt we want to keep it working as much as possible.

Two fixes for IMC (P9 only), one when booting with restricted number of CPUs and
one in the error handling when initialisation fails due to firmware etc.

A revert to fix function_graph on big endian machines, and then a rework of the
reverted patch to fix kprobes blacklist handling on big endian machines.

Thanks to:
  Anju T Sudhakar, Guilherme G. Piccoli, Madhavan Srinivasan, Naveen N. Rao,
  Nicholas Piggin, Paul Mackerras.

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      powerpc/perf: Fix IMC allocation routine

Madhavan Srinivasan (1):
      powerpc/perf: Fix core-imc hotplug callback failure during imc initialization

Naveen N. Rao (2):
      Revert "powerpc64/elfv1: Only dereference function descriptor for non-text symbols"
      powerpc/kprobes: Dereference function pointers only if the address does not belong to kernel text

Nicholas Piggin (1):
      powerpc/64s/radix: Fix preempt imbalance in TLB flush

Paul Mackerras (1):
      powerpc: Fix check for copy/paste instructions in alignment handler

 arch/powerpc/include/asm/code-patching.h | 10 +---------
 arch/powerpc/kernel/align.c              |  2 +-
 arch/powerpc/kernel/kprobes.c            |  7 ++++++-
 arch/powerpc/mm/tlb-radix.c              |  2 ++
 arch/powerpc/perf/imc-pmu.c              | 18 ++++++++++++++++--
 5 files changed, 26 insertions(+), 13 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZ/D3XAAoJEFHr6jzI4aWAcKgP/0TdSPM55D0NTfh5nrXo+AuA
5m7iE3gr2QGkodrVwjSzm1W3V6pOMHRZjjm9W7V7PkYdxoqgZSnUif/NSZyrSKWl
oAgD1SFSgNi9Eqa2P/vCbIPmZ7JFLuWwa93EskfK4dtg4NAEVzS1VkQKO74+W5mg
JMZrmIZVHJfeVYLhhU/R/oHZVVKRPdVG4joI6yV0Cs/DhkL/lcwH+4P2q3GkzcIf
/NDvwGBM9WPqVscHK2sUjYOAoI0+Mm7zzNWmdqxntm+I6vMrh7ysKtXKG/VTtMRO
12FbmpEJTogT35zL186vLRsjvxTwtxJV/JzQZPxUm1KtZuBe6+VUcYYUWlTlfvj4
gqACP13aSpDQZ1gVQVcS9mVrHGwIMLiM07Sj2+nJu+8LggWogqqWT34P4NR1o/8b
b24Hnyd1/KdiCrXdBekDLZAwKt1oeqnHT6vJaRfHSav033mIBApmqhdj/7n/Soh2
CN0rbnseVlb2tlwyooYwsackv0piK06UQKX8JI4372mBFP2RU7JUaspP6QSq9zpt
4VMa/vIMk2xyXDkhlgB0rwDqR+ZiV9nCapMEs+MOzUwrdyzfxSxkqB/BTlqahuqF
kPVrXPFbXalGPPCfWAu0EQzoNh7/qr1nI4DiuOQKF6DhF04rmNSOX5OZBMmUc4Hg
NzN5lh/KcY/lf4pAd63j
=+MKP
-----END PGP SIGNATURE-----
--=-=-=--
