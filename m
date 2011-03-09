Return-Path: <SRS0=7pvk=WC=start.ca=wilsons@srs.perfora.net>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	by ozlabs.org (Postfix) with ESMTP id 6A28BB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 11:38:53 +1100 (EST)
From: Stephen Wilson <wilsons@start.ca>
To: x86@kernel.org
Subject: [PATCH 0/5] make *_gate_vma accept mm_struct instead of task_struct
Date: Tue,  8 Mar 2011 19:31:56 -0500
Message-Id: <1299630721-4337-1-git-send-email-wilsons@start.ca>
Cc: linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Michel Lespinasse <walken@google.com>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Morally, the question of whether an address lies in a gate vma should be asked
with respect to an mm, not a particular task.

Practically, dropping the dependency on task_struct will help make current and
future operations on mm's more flexible and convenient.  In particular, it
allows some code paths to avoid the need to hold task_lock.

The only architecture this change impacts in any significant way is x86_64.
The principle change on that architecture is to mirror TIF_IA32 via
a new flag in mm_context_t. 

This is the first of a two part series that implements safe writes to
/proc/pid/mem.  I will be posting the second series to lkml shortly.  These
patches are based on v2.6.38-rc8.  The general approach used here was suggested
to me by Alexander Viro, but any mistakes present in these patches are entirely
my own.


--
steve


Stephen Wilson (5):
      x86: add context tag to mark mm when running a task in 32-bit compatibility mode
      x86: mark associated mm when running a task in 32 bit compatibility mode
      mm: arch: make get_gate_vma take an mm_struct instead of a task_struct
      mm: arch: make in_gate_area take an mm_struct instead of a task_struct
      mm: arch: rename in_gate_area_no_task to in_gate_area_no_mm


 arch/powerpc/kernel/vdso.c         |    6 +++---
 arch/s390/kernel/vdso.c            |    6 +++---
 arch/sh/kernel/vsyscall/vsyscall.c |    6 +++---
 arch/x86/ia32/ia32_aout.c          |    1 +
 arch/x86/include/asm/mmu.h         |    6 ++++++
 arch/x86/kernel/process_64.c       |    8 ++++++++
 arch/x86/mm/init_64.c              |   16 ++++++++--------
 arch/x86/vdso/vdso32-setup.c       |   15 ++++++++-------
 fs/binfmt_elf.c                    |    2 +-
 fs/proc/task_mmu.c                 |    8 +++++---
 include/linux/mm.h                 |   10 +++++-----
 kernel/kallsyms.c                  |    4 ++--
 mm/memory.c                        |    8 ++++----
 mm/mlock.c                         |    4 ++--
 mm/nommu.c                         |    2 +-
 15 files changed, 61 insertions(+), 42 deletions(-)
