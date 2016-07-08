Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlzTd0sNMzDr5F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 12:49:09 +1000 (AEST)
Message-ID: <1467946148.27479.163.camel@neuling.org>
Subject: Re: [PATCH v7 00/11] powerpc/powernv/cpuidle: Add support for POWER
 ISA v3 idle states
From: Michael Neuling <mikey@neuling.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>,  Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Date: Fri, 08 Jul 2016 12:49:08 +1000
In-Reply-To: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Except for the issue with patch 7 I've already commented on the rest of
this series is good with me. =C2=A0FWIW:

Acked-by: Michael Neuling <mikey@neuling.org>

Thanks.

On Fri, 2016-07-08 at 02:17 +0530, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
> =C2=A0a) new instruction named stop is added. This instruction replaces
> 	instructions like nap, sleep, rvwinkle.
> =C2=A0b) new per thread SPR named PSSCR is added which controls the behav=
ior
> 	of stop instruction.=C2=A0
> 	=09
> PSSCR has following key fields
> 	Bits 0:3=C2=A0=C2=A0- Power-Saving Level Status. This field indicates th=
e
> 	lowest power-saving state the thread entered since stop
> 	instruction was last executed.
> 	=09
> 	Bit 42 - Enable State Loss=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 	0 - No state is lost irrespective of other fields=C2=A0=C2=A0
> 	1 - Allows state loss
> 	=09
> 	Bits 44:47 - Power-Saving Level Limit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> 	This limits the power-saving level that can be entered into.
> 	=09
> 	Bits 60:63 - Requested Level=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 	Used to specify which power-saving level must be entered on
> 	executing stop instruction
> 	=09
> Stop idle states and their properties like name, latency, target
> residency, psscr value are exposed via device tree.
>=20
> This patch series adds support for this new mechanism.
>=20
> Patches 1-6 are cleanups and code movement.
> Patch 7 adds platform specific support for stop and psscr handling.
> Patch 8 and 9 are minor cleanup in cpuidle driver.
> Patch 10 adds cpuidle driver support.
> Patch 11 makes offlined cpu use deepest stop state.
>=20
> Note: Documentation for the device tree bindings is posted here-
> http://patchwork.ozlabs.org/patch/629125/
>=20
> Changes in v7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- File renamed to idle_book3s.S instead of idle_power_common.S
> =C2=A0- Comment changes
> =C2=A0- power_stop0, power_stop renamed to power9_idle and power_idle_sto=
p
> =C2=A0- PSSCR template is now a macro instead of storing in paca
> =C2=A0- power9_idle in C file instead of assembly
> =C2=A0- Fixed TOC related bug
> =C2=A0- Handling subcore within FTR section
> =C2=A0- Functions in idle.c reordered and broken into multiple functions
> =C2=A0- calling __restore_cpu_power8/9 via cur_cpu_spec->cpu_restore=C2=
=A0
> =C2=A0- Added a minor patch with minor cleanups in cpuidle-powernv.c . Th=
is
> =C2=A0=C2=A0=C2=A0was mainly to make the existing code consistent with th=
e review
> =C2=A0=C2=A0=C2=A0comments for new code
> =C2=A0- Using stack for variables while probing for idle states instead o=
f
> =C2=A0=C2=A0=C2=A0kzalloc/kcalloc
>=20
> Changes in v6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Restore new POWER ISA v3 SPRS when waking up from deep idle
>=20
> Changes in v5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Use generic cpuidle constant CPUIDLE_NAME_LEN
> =C2=A0- Fix return code handling for of_property_read_string_array
> =C2=A0- Use DT flags to determine if are using stop instruction, instead =
of
> =C2=A0=C2=A0=C2=A0cpu_has_feature
> =C2=A0- Removed uncessary cast with names
> =C2=A0- &stop_loop -> stop_loop
> =C2=A0- Added POWERNV_THRESHOLD_LATENCY_NS to filter out idle states with=
 high latency
>=20
> Changes in v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Added a patch to use PNV_THREAD_WINKLE macro while requesting for=
 winkle
> =C2=A0- Moved power7_powersave_common rename to more appropriate patch
> =C2=A0- renaming power7_enter_nap_mode to pnv_enter_arch207_idle_mode
> =C2=A0- Added PSSCR layout to Patch 7's commit message
> =C2=A0- Improved / Fixed comments
> =C2=A0- Fixed whitespace error in paca.h
> =C2=A0- Using MAX_POSSIBLE_STOP_STATE macro instead of hardcoding 0xF has
> =C2=A0=C2=A0=C2=A0max possible stop state
>=20
> Changes in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Rebased on powerpc-next
> =C2=A0- Dropping patch 1 since we are not adding a new file for P9 idle s=
upport
> =C2=A0- Improved comments in multiple places
> =C2=A0- Moved GET_PACA from power7_restore_hyp_resource to System Reset
> =C2=A0- Instead of moving few functions from idle_power7 to idle_power_co=
mmon,
> =C2=A0=C2=A0=C2=A0renaming idle_power7.S to idle_power_common.S
> =C2=A0- Moved HSTATE_HWTHREAD_STATE updation to power_powersave_common
> =C2=A0- Dropped earlier patch 5 which moved few macros from idle_power_co=
mmon to
> =C2=A0=C2=A0=C2=A0asm/cpuidle.h.=C2=A0
> =C2=A0- Added a patch to rename reusable power7_* idle functions to pnv_*
> =C2=A0- Added new patch that creates abstraction for saving SPRs before
> =C2=A0=C2=A0=C2=A0entering deep idle states
> =C2=A0- Instead of introducing new file idle_power_stop.S, P9 idle suppor=
t
> =C2=A0=C2=A0=C2=A0is added to idle_power_common.S using CPU_FTR sections.
> =C2=A0- Fixed r4 reg clobbering in power_stop0
>=20
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Rebased on v4.6-rc6
> =C2=A0- Using CPU_FTR_ARCH_300 bit instead of CPU_FTR_STOP_INST
>=20
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>=20
> Shreyas B. Prabhu (11):
> =C2=A0 powerpc/powernv: Use PNV_THREAD_WINKLE macro while requesting for
> =C2=A0=C2=A0=C2=A0=C2=A0winkle
> =C2=A0 powerpc/kvm: make hypervisor state restore a function
> =C2=A0 powerpc/powernv: Rename idle_power7.S to idle_book3s.S
> =C2=A0 powerpc/powernv: Rename reusable idle functions to hardware agnost=
ic
> =C2=A0=C2=A0=C2=A0=C2=A0names
> =C2=A0 powerpc/powernv: Make pnv_powersave_common more generic
> =C2=A0 powerpc/powernv: abstraction for saving SPRs before entering deep =
idle
> =C2=A0=C2=A0=C2=A0=C2=A0states
> =C2=A0 powerpc/powernv: Add platform support for stop instruction
> =C2=A0 cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of
> =C2=A0=C2=A0=C2=A0=C2=A0MAX_POWERNV_IDLE_STATES
> =C2=A0 cpuidle/powernv: cleanup powernv_add_idle_states
> =C2=A0 cpuidle/powernv: Add support for POWER ISA v3 idle states
> =C2=A0 powerpc/powernv: Use deepest stop state when cpu is offlined
>=20
> =C2=A0arch/powerpc/include/asm/cpuidle.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> =C2=A0arch/powerpc/include/asm/kvm_book3s_asm.h |=C2=A0=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/include/asm/opal-api.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A011 +-
> =C2=A0arch/powerpc/include/asm/ppc-opcode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A04 +
> =C2=A0arch/powerpc/include/asm/processor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A02 +
> =C2=A0arch/powerpc/include/asm/reg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A010 +
> =C2=A0arch/powerpc/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +-
> =C2=A0arch/powerpc/kernel/exceptions-64s.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A030 +-
> =C2=A0arch/powerpc/kernel/idle_book3s.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 664 ++++++++++++++++++++++++++++++
> =C2=A0arch/powerpc/kernel/idle_power7.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 515 -----------------------
> =C2=A0arch/powerpc/kvm/book3s_hv_rmhandlers.S=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A04 +-
> =C2=A0arch/powerpc/platforms/powernv/idle.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
| 185 +++++++--
> =C2=A0arch/powerpc/platforms/powernv/powernv.h=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A01 +
> =C2=A0arch/powerpc/platforms/powernv/smp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A04 +-
> =C2=A0drivers/cpuidle/cpuidle-powernv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A099 ++++-
> =C2=A015 files changed, 940 insertions(+), 595 deletions(-)
> =C2=A0create mode 100644 arch/powerpc/kernel/idle_book3s.S
> =C2=A0delete mode 100644 arch/powerpc/kernel/idle_power7.S
>=20
