Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C44C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:28:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018D8206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018D8206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GXwb1YN9zDqdV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 01:28:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GXst4jbPzDrMC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 01:26:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43GXss1xrMz9sB5;
 Sat, 15 Dec 2018 01:26:25 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-4 tag
Date: Sat, 15 Dec 2018 01:26:19 +1100
Message-ID: <87ftv0uqus.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: radu.rendec@gmail.com, linux-kernel@vger.kernel.org,
 lineprinter@altlinux.org, oohall@gmail.com, sandipan@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 4.20:

The following changes since commit b2fed34a628df6118b5d4e13f49a33e15f704fa9:

  selftests/powerpc: Adjust wild_bctr to build with old binutils (2018-11-15 23:05:17 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.20-4

for you to fetch changes up to a225f1567405558fb5410e9b2b90805819df1c67:

  powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call (2018-12-10 15:19:58 +1100)

- ------------------------------------------------------------------
powerpc fixes for 4.20 #4

One notable fix for our change to split pt_regs between user/kernel, we forgot
to update BPF to use the user-visible type which was an ABI break for BPF
programs.

A slightly ugly but minimal fix to do_syscall_trace_enter() so that we use
tracehook_report_syscall_entry() properly. We'll rework the code in next to
avoid the empty if body.

Seven commits fixing bugs in the new papr_scm (Storage Class Memory) driver.
The driver was finally able to be tested on the other hypervisor which exposed
several bugs. The fixes are all fairly minimal at least.

Fix a crash in our MSI code if an MSI-capable device is plugged into a non-MSI
capable PHB, only seen on older hardware (MPC8378).

Fix our legacy serial code to look for "stdout-path" since the device trees were
updated to use that instead of "linux,stdout-path".

A change to the COFF zImage code to fix booting old powermacs.

A couple of minor build fixes.

Thanks to:
  Benjamin Herrenschmidt, Daniel Axtens, Dmitry V. Levin, Elvira Khabirova,
  Oliver O'Halloran, Paul Mackerras, Radu Rendec, Rob Herring, Sandipan Das.

- ------------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Look for "stdout-path" when setting up legacy consoles

Elvira Khabirova (1):
      powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call

Michael Ellerman (2):
      powerpc/mm: Fix linux page tables build with some configs
      powerpc/boot: Fix build failures with -j 1

Oliver O'Halloran (7):
      powerpc/papr_scm: Use depend instead of select
      powerpc/papr_scm: Fix resource end address
      powerpc/papr_scm: Update DT properties
      powerpc/papr_scm: Remove endian conversions
      powerpc/papr_scm: Fix DIMM device registration race
      powerpc/papr_scm: Use ibm,unit-guid as the iset cookie
      powerpc/mm: Fallback to RAM if the altmap is unusable

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

Sandipan Das (1):
      powerpc/bpf: Fix broken uapi for BPF_PROG_TYPE_PERF_EVENT


 arch/powerpc/boot/Makefile                     |  2 +-
 arch/powerpc/boot/crt0.S                       |  4 ++-
 arch/powerpc/include/asm/perf_event.h          |  2 ++
 arch/powerpc/include/uapi/asm/Kbuild           |  1 -
 arch/powerpc/include/uapi/asm/bpf_perf_event.h |  9 ++++++
 arch/powerpc/kernel/legacy_serial.c            |  6 +++-
 arch/powerpc/kernel/msi.c                      |  7 ++++-
 arch/powerpc/kernel/ptrace.c                   |  7 ++++-
 arch/powerpc/mm/dump_linuxpagetables.c         |  1 +
 arch/powerpc/mm/init_64.c                      | 19 +++++++++++--
 arch/powerpc/platforms/pseries/Kconfig         |  3 +-
 arch/powerpc/platforms/pseries/papr_scm.c      | 39 ++++++++++++++++++++------
 12 files changed, 80 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/bpf_perf_event.h
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcE71eAAoJEFHr6jzI4aWAQUkP/0Z1YlNpl2Zf9GG1J1QsBCtj
H2KS/a01GciH6TO16ULovjFhJppcwPGOCYKU/elnge4cqC+c7sZDDLeXrB6byzfP
9jYbuC3QZ0ct1d34x7vzg/kplutMu1HClxUBU5g7QF9l2b70rB6UWf1WSJnCLgCg
MEwQscEPymJJpLO5r0B1/pCijLN2Rpy0vMbZbOoQW4/G/6qQ3d4ygDdWrh4lJNFf
LwWYLXi5SZ/1jFIb6/wYuomT4WIfD+JCaGsH3THAm7sfC7qx+nUOCGtA81vHGUaK
nW14snebk0viL8STJ4MO1IFJ9x3MsQAylpyyfcdzQ3Q3+rRkaPWwHrvOcnNavwfw
+PKDyqV+Ot9+2Es79ZDGeF68q7L7Q4qtZIIL9ARh5pokvMiycsYPOcMQW3IIbkZQ
aFS3SAQalGaSAlNp5NDnNoZ4rhb+tlR3k6fCbHkuPehj3IAvVzzc6XY3w2rr0wFy
ZAgnv+54aI7CNcasRiu+KStLYflr2xorjrRHWigli9KtyB+uZbx6IzDDGgQpPHAd
rUoJujp7G/GUclFJ42LF6MBDKTGU2XJP0rogEkNhmCY8RwbDPsvw52CYosEJmrMo
rMgVbO35eRmCmF+cbaRvRzsVXYVuPFZfTt8wF2SYwDzSx49b2tW696Xr5+mkUGw6
vu2XQ1BG1C/0mbIjgjKm
=ABj8
-----END PGP SIGNATURE-----
