Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnrv26m4HzDrW9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 17:00:30 +1000 (AEST)
Message-ID: <1504767630.1173.60.camel@neuling.org>
Subject: Re: [PATCH v8 00/10] Enable VAS
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, apopple@au1.ibm.com, oohall@gmail.com
Date: Thu, 07 Sep 2017 17:00:30 +1000
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

So this is upstream now but it will cause a crash on boot with older skiboo=
ts
with:=20

powernv-cpufreq: cpufreq pstate min 101 nominal 50 max 0
powernv-cpufreq: Workload Optimized Frequency is enabled in the platform
Disabling lock debugging due to kernel taint
Severe Machine check interrupt [Not recovered]
=C2=A0 NIP [c000000000098530]: reset_window_regs+0x20/0x220
=C2=A0 Initiator: CPU
=C2=A0 Error type: Unknown
opal: Machine check interrupt unrecoverable: MSR(RI=3D0)
opal: Hardware platform error: Unrecoverable Machine Check exception
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G=C2=A0=C2=A0=C2=A0M=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04.13.0-rc7-00708-g=
8b680911e774-dirty #10
task: c000000f22680000 task.stack: c000000f22700000
NIP:=C2=A0=C2=A0c000000000098530 LR: c000000000098758 CTR: 0000000000000000
REGS: c00000003ffebd80 TRAP: 0200=C2=A0=C2=A0=C2=A0Tainted: G=C2=A0=C2=A0=
=C2=A0M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(4.13.0-rc7-00708-g8b680911e774-dirty)
MSR:=C2=A0=C2=A09000000008349031 <SF,HV,EE,ME,IR,DR,LE>=C2=A0=C2=A0CR: 2400=
0224=C2=A0=C2=A0XER: 00000000
CFAR: c000000000098754 DAR: 00000000100bef30 DSISR: 40000000 SOFTE: 0=C2=A0
GPR00: c000000000098f44 c000000f22703a00 c000000000eff200 c000000f1cf861e0=
=C2=A0
GPR04: c000000f22703a50 0000000000000001 0000000000000fff 0000000000000003=
=C2=A0
GPR08: c00c0000842f0000 0000000000000001 0000000000000000 0000000000000000=
=C2=A0
GPR12: 0000000000000000 c00000000fd40580 c000000000c03590 c000000000c1f428=
=C2=A0
GPR16: c000000000c4a640 c000000000c31360 c000000000c92738 c000000000c92690=
=C2=A0
GPR20: c000000000c926a0 c000000000c926f0 c000000f1d672940 0000000000000000=
=C2=A0
GPR24: c000000000c92638 0000000000000000 c000000000e888b0 c000000000dce428=
=C2=A0
GPR28: 0000000000000002 c000000f0e800000 c000000f22703a50 c000000f1cf861e0=
=C2=A0
NIP [c000000000098530] reset_window_regs+0x20/0x220
LR [c000000000098758] init_winctx_regs+0x28/0x6c0
Call Trace:
[c000000f22703a00] [0000000000000002] 0x2 (unreliable)
[c000000f22703a30] [c000000000098f44] vas_rx_win_open.part.11+0x154/0x210
[c000000f22703ae0] [c000000000d668e8] nx842_powernv_init+0x6b4/0x824
[c000000f22703c[=C2=A0=C2=A0=C2=A038.412765557,0] OPAL: Reboot requested du=
e to Platform error.
[=C2=A0=C2=A0=C2=A038.412828287,3] OPAL: Reboot requested due to Platform e=
rror.40] [c00000000000ca60] do_one_initcall+0x60/0x1c0

If you see this you need a new skiboot with at least these two patches:

    b503dcf16d vas: Set mmio enable bits in DD2
    a5c124072f vas: Set FIRs according to workbook

This is a community announcement brought to you by OzLabs.=C2=A0
  OzLabs: Making Linux better since 1999

Mikey


On Mon, 2017-08-28 at 23:23 -0700, Sukadev Bhattiprolu wrote:
> Power9 introduces a hardware subsystem referred to as the Virtual
> Accelerator Switchboard (VAS). VAS allows kernel subsystems and user
> space processes to directly access the Nest Accelerator (NX) engines
> which implement compression and encryption algorithms in the hardware.
>=20
> NX has been in Power processors since Power7+, but access to the NX
> engines was through the 'icswx' instruction which is only available
> to the kernel/hypervisor. Starting with Power9, access to the NX
> engines is provided to both kernel and user space processes through
> VAS.
>=20
> The switchboard (i.e VAS) multiplexes accesses between "receivers" and
> "senders", where the "receivers" are typically the NX engines and
> "senders" are the kernel subsystems and user processors that wish to
> access the receivers (NX engines).=C2=A0=C2=A0Once a sender is "connected=
" to
> a receiver through the switchboard, the senders can submit compression/
> encryption requests to the hardware using the new (PowerISA 3.0)
> "copy" and "paste" instructions.
>=20
> In the initial OPAL and PowerNV kernel patchsets, the "senders" can
> only be kernel subsystems (eg NX-842 driver) and receivers can only
> be the NX-842 engine. Follow-on patch sets will allow senders/receivers
> to be user-space processes and receivers to be NX-GZIP engines.
>=20
> Provides:
>=20
> 	This kernel patch set configures the VAS subsystems and provides
> 	kernel interfaces to drivers like NX-842 to open receive and send
> 	windows in VAS and to submit compression requests to the NX engine.
>=20
> Requires:
>=20
> 	This patch set needs corresponding VAS/NX skiboot patches which
> 	were merged into skiboot tree. i.e skiboot must include:
> 	commit b503dcf ("vas: Set mmio enable bits in DD2")
>=20
> Tests:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0In-kernel compression req=
uests were tested on DD1 and DD2 POWER9
> 	hardware using compression self-test module and the following
> 	NX-842 patch set from Haren Myneni:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://lists.ozlabs.org/=
pipermail/linuxppc-dev/2017-July/160620.html
>=20
> 	and by dropping the last parameters to both vas_copy_crb() and
> 	vas_paste_crb() calls in drivers/crypto/nx/nx-842-powernv.c.
> 	See also PATCH 10/10.
>=20
> Git Tree:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://github.com/sukade=
v/linux/=C2=A0
> 	Branch: vas-kern-v8
>=20
> Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman
> and Haren Myneni.
>=20
> Changelog[v8]:
> 	- [Michael Ellerman] Use kernel int types (u64, u32 etc); make VAS
> 	=C2=A0=C2=A0a built-in rather than a module; drop unnecessary fields fro=
m
> 	=C2=A0=C2=A0struct vas_instance; Update ISA references; use 0 or 1 with
> 	=C2=A0=C2=A0SET_FIELD macros instead of bool; skip writing to SPARE regi=
sters;
> 	=C2=A0=C2=A0minor cleanup of debug/error messages; retry if ida_get_new(=
)
> 	=C2=A0=C2=A0fails with EAGAIN; fix couple of leaks in ids in error handl=
ing;
> 	=C2=A0=C2=A0drop vas_initialized() check; drop vas_win_id() and vas_past=
e_addr()
> 	=C2=A0=C2=A0interfaces as they are not yet used; Set task_state() and fi=
x
> 	=C2=A0=C2=A0parameter to schedule_timeout(); Reuse existing copy/paste m=
acros
> 	=C2=A0=C2=A0drop unnecessary parameters and add cr0 to clobbers list
>=20
> Changelog[v7]:
> 	- Drop support for user space send/receive FTW windows (will be
> 	=C2=A0=C2=A0posted separately) Simplifies the rx-win-open interface a bi=
t.
> 	- [Michael Ellerman] Move GET_FIELD/SET_FIELD macros from=C2=A0
> 	=C2=A0=C2=A0uapi/asm/vas.h to asm/vas.h.
>=20
> Changelog[v6]
> 	- Add support for user space send/receive FTW windows
> 	- Add a new, NX-FTW driver which provides the FTW user interface
>=20
> Changelog[v5]
> 	- [Ben Herrenschmidt] Make VAS a platform device in the device tree
> 	=C2=A0=C2=A0and use the core platform functions to parse the VAS propert=
ies.
> 	=C2=A0=C2=A0Map the VAS MMIO regions as non-cachable and paste regions a=
s
> 	=C2=A0=C2=A0cachable. Use CONFIG_PPC_VAS rather than CONFIG_VAS; Don't a=
ssume
> 	=C2=A0=C2=A0VAS ids are sequential.
> 	- Copy the FIFO address as is into LFIFO_BAR (don't shift it).
>=20
> Changelog[v4]
> 	Comments from Michael Neuling:
> 	- Move VAS code from drivers/misc/vas to arch/powerpc/platforms/powernv
> 	=C2=A0=C2=A0since VAS only provides interfaces to other drivers like NX-=
842.
> 	- Drop vas-internal.h and use vas.h in separate dirs for VAS
> 	=C2=A0=C2=A0internal, kernel API and user API
> 	- Rather than create 6 separate device tree properties windows
> 	=C2=A0=C2=A0and window context, combine them into 6 "reg" properties.
> 	- Drop vas_window_reset() since windows are reset/cleared before
> 	=C2=A0=C2=A0being assigned to kernel/users.
> 	- Use ilog2() and radix_enabled() helpers
>=20
> Changelog[v3]
> 	- Rebase to v4.11-rc1
> 	- Add interfaces to initialize send/receive window attributes to
> 	=C2=A0=C2=A0defaults that drivers can use (see arch/powerpc/include/asm/=
vas.h)
> 	- Modify interface vas_paste() to return 0 or error code
> 	- Fix a bug in setting Translation Control Mode (0b11 not 0x11)
> 	- Enable send-window-credit checking=C2=A0
> 	- Reorg code=C2=A0=C2=A0in vas_win_close()
> 	- Minor reorgs and tweaks to register field settings to make it
> 	=C2=A0=C2=A0easier to add support for user space windows.
> 	- Skip writing to read-only registers
> 	- Start window indexing from 0 rather than 1
>=20
> Changelog[v2]
> 	- Use vas-id, HVWC, UWC and paste address, entries from device tree
> 	=C2=A0=C2=A0rather than defining/computing them in kernel and reorg code=
.
>=20
>=20
> Sukadev Bhattiprolu (10):
> =C2=A0 powerpc/vas: Define macros, register fields and structures
> =C2=A0 Move GET_FIELD/SET_FIELD to vas.h
> =C2=A0 powerpc/vas: Define vas_init() and vas_exit()
> =C2=A0 powerpc/vas: Define helpers to access MMIO regions
> =C2=A0 powerpc/vas: Define helpers to init window context
> =C2=A0 powerpc/vas: Define helpers to alloc/free windows
> =C2=A0 powerpc/vas: Define vas_rx_win_open() interface
> =C2=A0 powerpc/vas: Define vas_win_close() interface
> =C2=A0 powerpc/vas: Define vas_tx_win_open()
> =C2=A0 powerpc/vas: Define copy/paste interfaces
>=20
> =C2=A0.../devicetree/bindings/powerpc/ibm,vas.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A023 +
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A09 +
> =C2=A0arch/powerpc/include/asm/ppc-opcode.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A02 +
> =C2=A0arch/powerpc/include/asm/vas.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0160 +++
> =C2=A0arch/powerpc/platforms/powernv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A014 +
> =C2=A0arch/powerpc/platforms/powernv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A01 +
> =C2=A0arch/powerpc/platforms/powernv/copy-paste.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A046 +
> =C2=A0arch/powerpc/platforms/powernv/vas-window.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 1134
> ++++++++++++++++++++
> =C2=A0arch/powerpc/platforms/powernv/vas.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A015=
1 +++
> =C2=A0arch/powerpc/platforms/powernv/vas.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A046=
7 ++++++++
> =C2=A0drivers/crypto/nx/nx-842-powernv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A07 +-
> =C2=A0drivers/crypto/nx/nx-842.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A05 -
> =C2=A012 files changed, 2011 insertions(+), 8 deletions(-)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,va=
s.txt
> =C2=A0create mode 100644 arch/powerpc/include/asm/vas.h
> =C2=A0create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h
> =C2=A0create mode 100644 arch/powerpc/platforms/powernv/vas-window.c
> =C2=A0create mode 100644 arch/powerpc/platforms/powernv/vas.c
> =C2=A0create mode 100644 arch/powerpc/platforms/powernv/vas.h
>=20
