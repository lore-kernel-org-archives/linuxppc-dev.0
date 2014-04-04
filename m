Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com, rostedt@goodmis.org, philippe.bergheaud@fr.ibm.com
Subject: [PATCH 0/7] Build ppc64le kernel using ABIv2, supplemental patches
Date: Fri,  4 Apr 2014 17:09:03 +1100
Message-Id: <1396591750-8203-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches apply against my last series and fix all known
ABIv2 issues.

To stress the module loader and dynamic ftrace code, I built an
allmodconfig kernel and inserted every module I could. I found a bunch
of bugs in the modules themselves, but in the end I managed to
get quite a few modules to load:

# cat /proc/modules | wc -l
3830

It survived a fair bit of poking (enabling/disabling function tracers
etc).

Anton Blanchard (7):
  powerpc: Add _GLOBAL_TOC for ABIv2 assembly functions exported to
    modules
  powerpc: ftrace_caller, _mcount is exported to modules so needs
    _GLOBAL_TOC()
  powerpc/kprobes: Fix ABIv2 issues with kprobe_lookup_name
  powerpc/modules: Create is_module_trampoline()
  powerpc/modules: Create module_trampoline_target()
  powerpc/ftrace: Use module loader helpers to parse trampolines
  powerpc/ftrace: Fix ABIv2 issues with __ftrace_make_call

 arch/powerpc/include/asm/kprobes.h |   5 +-
 arch/powerpc/include/asm/module.h  |   3 +
 arch/powerpc/include/asm/ppc_asm.h |  12 ++++
 arch/powerpc/kernel/entry_64.S     |   7 +-
 arch/powerpc/kernel/ftrace.c       | 137 +++++++++++--------------------------
 arch/powerpc/kernel/module_64.c    |  80 ++++++++++++++++++++--
 arch/powerpc/lib/copyuser_64.S     |   2 +-
 arch/powerpc/lib/memcpy_64.S       |   2 +-
 8 files changed, 136 insertions(+), 112 deletions(-)

-- 
1.8.3.2
