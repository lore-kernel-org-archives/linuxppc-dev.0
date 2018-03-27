Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCJ69KGzF27P
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:32 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 0/8] powerpc: Disable DAWR on POWER9
Date: Tue, 27 Mar 2018 15:37:16 +1100
Message-Id: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using the DAWR on POWER9 can cause xstops, hence we need to disable
it.

The current CPU_FTR for DAWR is a bit messy. Despite having
CPU_FTR_DAWR, currently we assume DAWR exists in the KVM code based on
CPU_FTR_ARCH_207. In other places we assume DAWR exists if
CPU_FTR_DAWR is set.

This attempts to clear up the situation by always using CPU_FTR_DAWR
before setting the DAWR (to a non-zero value).

DAWR has 5 different ways of being set from userspace. ptrace,
h_set_mode, h_set_mode(DAWR), h_set_dabr(), kvmppc_set_one_reg() and
xmon.

For ptrace, we now advertise zero breakpoints on POWER9 via the
PPC_PTRACE_GETHWDBGINFO call. This results in GDB falling back to
software emulation of the watchpoint (which is slow).

h_set_mode() and h_set_dabr() will now return an error to the guest
when on a POWER9 host. Current Linux guests ignore this error, so they
will silently not get the DAWR (sigh). The same error codes are being
used by POWERVM in this case.

kvmppc_set_one_reg() will store the value in the vcpu but won't
actually set it on POWER9 hardware. This is done so we don't break
migration from P8 to P9, at the cost of silently losing the DAWR on
the migration. This is not ideal but hopefully the best overall
solution. This approach has been acked by paulus.

For xmon, the 'bd' command will return an error on P9.

Thanks to Pedro Franco de Carvalho for the initial version of this.

v3:
  Split patches
  Fix usage of H_UNSUPPORTED

v2:
  Move to CPU feature quirk from Nick's
  dbginfo.num_data_bps = 0 if !breakpoint_available() from Pedro
