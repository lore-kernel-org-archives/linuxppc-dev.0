Return-Path: <labbott@redhat.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L0Wm0yqMzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 09:22:08 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so7203567oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 16:22:08 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
 "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Cc: Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 linux-kernel@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 0/4] Salted build ids via ELF notes
Date: Tue,  3 Jul 2018 16:21:56 -0700
Message-Id: <20180703232200.11315-1-labbott@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

This is v5 of the series to allow unique build ids in the kernel. As a
reminder of the context:

""
In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only one
version of a debuginfo info package can be installed at a time. Mark Wielaard
made an effort for Fedora 27 to allow parallel installation of debuginfo (see
https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
more details)

Part of the requirement to allow this to work is that build ids are
unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated. After poking holes in a few of my
ideas, there was a discussion with some people from the binutils team about
adding --build-id-salt to let ld do the calculation debugedit is doing. There
was a counter proposal made to add in the salt while building. The
easiest proposal was to add an item in the linker script vs. linking in
an object since we need the salt to go in every module as well as the
kernel and vmlinux.
""

v5 uses the approach suggested by Masahiro Yamada which uses the
existing ELF note macro to more easily add the salt (vs previous
approaches which tried to adjust via linker section).

If arch maintainers are okay, I'd like acks for this so this can go
through the kbuild tree.

Thanks,
Laura

Laura Abbott (4):
  kbuild: Add build salt to the kernel and modules
  x86: Add build salt to the vDSO
  powerpc: Add build salt to the vDSO
  arm64: Add build salt to the vDSO

 arch/arm64/kernel/vdso/note.S     |  3 +++
 arch/powerpc/kernel/vdso32/note.S |  3 +++
 arch/x86/entry/vdso/vdso-note.S   |  3 +++
 arch/x86/entry/vdso/vdso32/note.S |  3 +++
 include/linux/build-salt.h        | 20 ++++++++++++++++++++
 init/Kconfig                      |  9 +++++++++
 init/version.c                    |  3 +++
 scripts/mod/modpost.c             |  3 +++
 8 files changed, 47 insertions(+)
 create mode 100644 include/linux/build-salt.h

-- 
2.17.1
