Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXR9X6xS1zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 15:56:00 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S4rb8D058503
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 23:55:58 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28w28k8pf8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 23:55:56 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 10:25:53 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EB32AE0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 10:27:33 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S4toZH12910602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 10:25:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S4tlWL001032
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 10:25:49 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_30C25DD1-FF6B-4137-800E-C43273DE16C1"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
Date: Tue, 28 Feb 2017 10:25:46 +0530
In-Reply-To: <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Cc: David Daney <ddaney@caviumnetworks.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
 Chris Metcalf <cmetcalf@mellanox.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Russell King <linux@armlinux.org.uk>, Rabin Vincent <rabin@rab.in>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>,
 Michael Ellerman <mpe@ellerman.id.au>
To: Jason Baron <jbaron@akamai.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Message-Id: <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_30C25DD1-FF6B-4137-800E-C43273DE16C1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> Thanks for the suggestion! I would like to see if this resolves the =
ppc issue we had. I'm attaching a powerpc patch based on your =
suggestion. Hopefully, Sachin can try it.
>=20
> Thanks,
>=20

I tried this patch. It does not fix the warning.=20

[   11.709071] mount (2956) used greatest stack depth: 10176 bytes left
[   11.731883] ------------[ cut here ]------------
[   11.731911] WARNING: CPU: 3 PID: 2972 at kernel/jump_label.c:287 =
static_key_set_entries.isra.10+0x3c/0x50
[   11.731915] Modules linked in: nfsd(+) ip_tables x_tables autofs4
[   11.731925] CPU: 3 PID: 2972 Comm: modprobe Not tainted =
4.10.0-next-20170227 #4
[   11.731930] task: c00000077b284a00 task.stack: c00000077b8b8000
[   11.731933] NIP: c0000000017bf84c LR: c0000000017bfcbc CTR: =
0000000000000000
[   11.731937] REGS: c00000077b8bb800 TRAP: 0700   Not tainted  =
(4.10.0-next-20170227)
[   11.731940] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[   11.731948]   CR: 48248282  XER: 00000001
[   11.731953] CFAR: c0000000017bf81c SOFTE: 1=20
GPR00: c0000000017bfc7c c00000077b8bba80 c00000000266c300 =
d0000000063e28f8=20
GPR04: d0000000063e5b57 0000000100000017 c0000000017bf5a0 =
0000000000000000=20
GPR08: 0000000000052eb3 0000000000000001 c00000000258c300 =
0000000000000001=20
GPR12: c000000001b5b460 c00000000ea80c00 0000000000000020 =
d000000006380bb0=20
GPR16: c00000077b8bbda0 c00000077b8bbdec 0000000000000000 =
0000000000008580=20
GPR20: d000000006410000 d0000000063e7ea8 c00000000256db90 =
0000000000000001=20
GPR24: c00000000258ca14 0000000000000000 c0000000025737f8 =
d0000000063e5c17=20
GPR28: 0000000000000000 d0000000063e6780 d0000000063e28f0 =
d0000000063e5b57=20
[   11.732000] NIP [c0000000017bf84c] =
static_key_set_entries.isra.10+0x3c/0x50
[   11.732004] LR [c0000000017bfcbc] =
jump_label_module_notify+0x20c/0x420
[   11.732007] Call Trace:
[   11.732011] [c00000077b8bba80] [c0000000017bfc7c] =
jump_label_module_notify+0x1cc/0x420 (unreliable)
[   11.732019] [c00000077b8bbb40] [c0000000016b69b0] =
notifier_call_chain+0x90/0x100
[   11.732024] [c00000077b8bbb90] [c0000000016b6e80] =
__blocking_notifier_call_chain+0x60/0x90
[   11.732029] [c00000077b8bbbe0] [c0000000017380ec] =
load_module+0x1c2c/0x2760
[   11.732034] [c00000077b8bbd70] [c000000001738e80] =
SyS_finit_module+0xc0/0xf0
[   11.732040] [c00000077b8bbe30] [c0000000015cb8e0] =
system_call+0x38/0xfc
[   11.732043] Instruction dump:
[   11.732046] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 =
3d42fff2 892a0714=20
[   11.732053] 2f890000 40feffe0 39200001 992a0714 <0fe00000> 4bffffd0 =
60000000 60000000=20
[   11.732061] ---[ end trace 13c67d418143453c ]---
[   11.732319] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

I have collected the o/p of the command suggested by David. Here is a =
snippet from the run

File: ./arch/powerpc/kernel/built-in.o
  [383] __jump_table      PROGBITS        0000000000000000 068020 000c78 =
18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtasd.o
File: ./arch/powerpc/kernel/of_platform.o
File: ./arch/powerpc/kernel/eeh_event.o
File: ./arch/powerpc/kernel/setup_64.o
  [18] __jump_table      PROGBITS        0000000000000000 001240 000048 =
18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtas-proc.o
File: ./arch/powerpc/kernel/signal_64.o
  [13] __jump_table      PROGBITS        0000000000000000 001c68 000060 =
18 WAM  0   0  1

Have attached the complete o/p here for reference.

Thanks
-Sachin


--Apple-Mail=_30C25DD1-FF6B-4137-800E-C43273DE16C1
Content-Disposition: attachment;
	filename=jump_table.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="jump_table.log"
Content-Transfer-Encoding: 7bit

# find . -name \*\.o | xargs readelf -eW | grep 'File:\| __jump_table'
File: ./arch/powerpc/boot/cpm-serial.o
File: ./arch/powerpc/boot/crtsavres.o
File: ./arch/powerpc/boot/crt0.o
File: ./arch/powerpc/boot/devtree.o
File: ./arch/powerpc/boot/elf_util.o
File: ./arch/powerpc/boot/cuboot.o
File: ./arch/powerpc/boot/div64.o
File: ./arch/powerpc/boot/main.o
File: ./arch/powerpc/boot/mpc52xx-psc.o
File: ./arch/powerpc/boot/mpsc.o
File: ./arch/powerpc/boot/ns16550.o
File: ./arch/powerpc/boot/ofconsole.o
File: ./arch/powerpc/boot/oflib.o
File: ./arch/powerpc/boot/opal-calls.o
File: ./arch/powerpc/boot/fdt_wip.o
File: ./arch/powerpc/boot/opal.o
File: ./arch/powerpc/boot/serial.o
File: ./arch/powerpc/boot/simple_alloc.o
File: ./arch/powerpc/boot/decompress.o
File: ./arch/powerpc/boot/stdio.o
File: ./arch/powerpc/boot/stdlib.o
File: ./arch/powerpc/boot/string.o
File: ./arch/powerpc/boot/uartlite.o
File: ./arch/powerpc/boot/util.o
File: ./arch/powerpc/boot/epapr-wrapper.o
File: ./arch/powerpc/boot/epapr.o
File: ./arch/powerpc/boot/of.o
File: ./arch/powerpc/boot/pseries-head.o
File: ./arch/powerpc/boot/inffast.o
File: ./arch/powerpc/boot/inflate.o
File: ./arch/powerpc/boot/inftrees.o
File: ./arch/powerpc/boot/libfdt-wrapper.o
File: ./arch/powerpc/boot/empty.o
File: ./arch/powerpc/boot/fdt.o
File: ./arch/powerpc/boot/fdt_ro.o
File: ./arch/powerpc/boot/fdt_rw.o
File: ./arch/powerpc/boot/fdt_strerror.o
File: ./arch/powerpc/boot/fdt_sw.o
File: ./arch/powerpc/crypto/md5-asm.o
File: ./arch/powerpc/crypto/md5-glue.o
File: ./arch/powerpc/crypto/sha1-powerpc-asm.o
File: ./arch/powerpc/crypto/sha1.o
File: ./arch/powerpc/crypto/md5-ppc.o
File: ./arch/powerpc/crypto/sha1-powerpc.o
File: ./arch/powerpc/crypto/md5-ppc.mod.o
File: ./arch/powerpc/crypto/sha1-powerpc.mod.o
File: ./arch/powerpc/kernel/vdso64/sigtramp.o
File: ./arch/powerpc/kernel/vdso64/gettimeofday.o
File: ./arch/powerpc/kernel/vdso64/datapage.o
File: ./arch/powerpc/kernel/vdso64/cacheflush.o
File: ./arch/powerpc/kernel/vdso64/note.o
File: ./arch/powerpc/kernel/vdso64/getcpu.o
File: ./arch/powerpc/kernel/vdso64/vdso64_wrapper.o
File: ./arch/powerpc/kernel/vdso64/built-in.o
File: ./arch/powerpc/kernel/io.o
File: ./arch/powerpc/kernel/vecemu.o
File: ./arch/powerpc/kernel/fadump.o
File: ./arch/powerpc/kernel/built-in.o
  [383] __jump_table      PROGBITS        0000000000000000 068020 000c78 18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtasd.o
File: ./arch/powerpc/kernel/of_platform.o
File: ./arch/powerpc/kernel/eeh_event.o
File: ./arch/powerpc/kernel/setup_64.o
  [18] __jump_table      PROGBITS        0000000000000000 001240 000048 18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtas-proc.o
File: ./arch/powerpc/kernel/signal_64.o
  [13] __jump_table      PROGBITS        0000000000000000 001c68 000060 18 WAM  0   0  1
File: ./arch/powerpc/kernel/paca.o
File: ./arch/powerpc/kernel/proc_powerpc.o
File: ./arch/powerpc/kernel/tm.o
File: ./arch/powerpc/kernel/cpu_setup_pa6t.o
File: ./arch/powerpc/kernel/cputable.o
File: ./arch/powerpc/kernel/ptrace32.o
File: ./arch/powerpc/kernel/cpu_setup_ppc970.o
File: ./arch/powerpc/kernel/eeh.o
File: ./arch/powerpc/kernel/ptrace.o
  [10] __jump_table      PROGBITS        0000000000000000 006378 000318 18 WAM  0   0  1
File: ./arch/powerpc/kernel/module.o
File: ./arch/powerpc/kernel/syscalls.o
  [ 6] __jump_table      PROGBITS        0000000000000000 00022c 000030 18 WAM  0   0  1
File: ./arch/powerpc/kernel/module_64.o
File: ./arch/powerpc/kernel/irq.o
  [22] __jump_table      PROGBITS        0000000000000000 0028b8 000078 18 WAM  0   0  1
File: ./arch/powerpc/kernel/dbell.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000190 000018 18 WAM  0   0  1
File: ./arch/powerpc/kernel/align.o
  [13] __jump_table      PROGBITS        0000000000000000 000e98 0000a8 18 WAM  0   0  1
File: ./arch/powerpc/kernel/jump_label.o
File: ./arch/powerpc/kernel/signal_32.o
  [13] __jump_table      PROGBITS        0000000000000000 0027c4 000078 18 WAM  0   0  1
File: ./arch/powerpc/kernel/idle_book3s.o
File: ./arch/powerpc/kernel/process.o
  [50] __jump_table      PROGBITS        0000000000000000 003220 0002b8 18 WAM  0   0  1
File: ./arch/powerpc/kernel/pmc.o
File: ./arch/powerpc/kernel/vdso.o
File: ./arch/powerpc/kernel/mce.o
File: ./arch/powerpc/kernel/eeh_pe.o
File: ./arch/powerpc/kernel/eeh_dev.o
File: ./arch/powerpc/kernel/cpu_setup_power.o
File: ./arch/powerpc/kernel/idle.o
  [15] __jump_table      PROGBITS        0000000000000000 0002c8 000030 18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtas.o
File: ./arch/powerpc/kernel/signal.o
File: ./arch/powerpc/kernel/sysfs.o
  [29] __jump_table      PROGBITS        0000000000000000 005648 000120 18 WAM  0   0  1
File: ./arch/powerpc/kernel/dma.o
File: ./arch/powerpc/kernel/eeh_cache.o
File: ./arch/powerpc/kernel/cacheinfo.o
File: ./arch/powerpc/kernel/nvram_64.o
File: ./arch/powerpc/kernel/eeh_driver.o
File: ./arch/powerpc/kernel/time.o
  [43] __jump_table      PROGBITS        0000000000000000 0025a0 0000d8 18 WAM  0   0  1
File: ./arch/powerpc/kernel/rtas-rtc.o
File: ./arch/powerpc/kernel/prom.o
File: ./arch/powerpc/kernel/rtas_pci.o
File: ./arch/powerpc/kernel/traps.o
  [33] __jump_table      PROGBITS        0000000000000000 003470 000138 18 WAM  0   0  1
File: ./arch/powerpc/kernel/setup-common.o
  [41] __jump_table      PROGBITS        0000000000000000 001d64 000048 18 WAM  0   0  1
File: ./arch/powerpc/kernel/firmware.o
File: ./arch/powerpc/kernel/reloc_64.o
File: ./arch/powerpc/kernel/udbg.o
File: ./arch/powerpc/kernel/hw_breakpoint.o
  [13] __jump_table      PROGBITS        0000000000000000 000740 000018 18 WAM  0   0  1
File: ./arch/powerpc/kernel/eeh_sysfs.o
File: ./arch/powerpc/kernel/misc.o
File: ./arch/powerpc/kernel/dma-iommu.o
File: ./arch/powerpc/kernel/misc_64.o
File: ./arch/powerpc/kernel/prom_parse.o
File: ./arch/powerpc/kernel/rtas_flash.mod.o
File: ./arch/powerpc/kernel/sys_ppc32.o
File: ./arch/powerpc/kernel/mce_power.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000838 000018 18 WAM  0   0  1
File: ./arch/powerpc/kernel/crash_dump.o
File: ./arch/powerpc/kernel/fpu.o
File: ./arch/powerpc/kernel/entry_64.o
File: ./arch/powerpc/kernel/audit.o
File: ./arch/powerpc/kernel/iommu.o
File: ./arch/powerpc/kernel/smp.o
  [27] __jump_table      PROGBITS        0000000000000000 002510 000030 18 WAM  0   0  1
File: ./arch/powerpc/kernel/pci_64.o
File: ./arch/powerpc/kernel/kprobes.o
File: ./arch/powerpc/kernel/trace_clock.o
File: ./arch/powerpc/kernel/rtas_flash.o
File: ./arch/powerpc/kernel/optprobes.o
File: ./arch/powerpc/kernel/kexec_elf_64.o
File: ./arch/powerpc/kernel/optprobes_head.o
File: ./arch/powerpc/kernel/legacy_serial.o
File: ./arch/powerpc/kernel/compat_audit.o
File: ./arch/powerpc/kernel/udbg_16550.o
File: ./arch/powerpc/kernel/systbl.o
File: ./arch/powerpc/kernel/stacktrace.o
File: ./arch/powerpc/kernel/pci_dn.o
File: ./arch/powerpc/kernel/pci-hotplug.o
File: ./arch/powerpc/kernel/isa-bridge.o
File: ./arch/powerpc/kernel/ppc_save_regs.o
File: ./arch/powerpc/kernel/pci-common.o
File: ./arch/powerpc/kernel/pci_of_scan.o
File: ./arch/powerpc/kernel/msi.o
File: ./arch/powerpc/kernel/machine_kexec.o
File: ./arch/powerpc/kernel/crash.o
File: ./arch/powerpc/kernel/machine_kexec_file_64.o
File: ./arch/powerpc/kernel/machine_kexec_64.o
  [10] __jump_table      PROGBITS        0000000000000000 000a84 000018 18 WAM  0   0  1
File: ./arch/powerpc/kernel/prom_init.o
File: ./arch/powerpc/kernel/vector.o
File: ./arch/powerpc/kernel/head_64.o
File: ./arch/powerpc/kvm/book3s_hv_ras.o
File: ./arch/powerpc/kvm/kvm-hv.o
  [23] __jump_table      PROGBITS        0000000000000000 015b08 000600 18 WAM  0   0  1
File: ./arch/powerpc/kvm/kvm-hv.mod.o
File: ./arch/powerpc/kvm/book3s_hv_rm_xics.o
File: ./arch/powerpc/kvm/emulate_loadstore.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000698 000018 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_64_vio.o
File: ./arch/powerpc/kvm/book3s_exports.o
File: ./arch/powerpc/kvm/book3s_64_vio_hv.o
File: ./arch/powerpc/kvm/kvm.o
  [231] __jump_table      PROGBITS        0000000000000000 0192e8 0001f8 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_xics.o
  [26] __jump_table      PROGBITS        0000000000000000 0032e0 000018 18 WAM  0   0  1
File: ./arch/powerpc/kvm/kvm.mod.o
File: ./arch/powerpc/kvm/book3s_hv_hmi.o
File: ./arch/powerpc/kvm/book3s.o
  [40] __jump_table      PROGBITS        0000000000000000 002380 000030 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_hv_rmhandlers.o
File: ./arch/powerpc/kvm/book3s_hv_builtin.o
  [25] __jump_table      PROGBITS        0000000000000000 000b48 000048 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_hv_rm_mmu.o
  [24] __jump_table      PROGBITS        0000000000000000 00326d 000120 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_64_mmu_radix.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002048 000078 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_rtas.o
File: ./arch/powerpc/kvm/book3s_hv_interrupts.o
File: ./arch/powerpc/kvm/built-in.o
  [81] __jump_table      PROGBITS        0000000000000000 008d08 000168 18 WAM  0   0  1
File: ./arch/powerpc/kvm/powerpc.o
  [45] __jump_table      PROGBITS        0000000000000000 0041e8 000120 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_hv.o
  [ 9] __jump_table      PROGBITS        0000000000000000 00bc38 000498 18 WAM  0   0  1
File: ./arch/powerpc/kvm/book3s_64_mmu_hv.o
  [ 9] __jump_table      PROGBITS        0000000000000000 004a68 0000f0 18 WAM  0   0  1
File: ./arch/powerpc/lib/string.o
File: ./arch/powerpc/lib/alloc.o
File: ./arch/powerpc/lib/memcpy_power7.o
File: ./arch/powerpc/lib/crtsavres.o
File: ./arch/powerpc/lib/string_64.o
File: ./arch/powerpc/lib/code-patching.o
File: ./arch/powerpc/lib/feature-fixups.o
File: ./arch/powerpc/lib/checksum_64.o
File: ./arch/powerpc/lib/checksum_wrappers.o
File: ./arch/powerpc/lib/copypage_power7.o
File: ./arch/powerpc/lib/sstep.o
  [18] __jump_table      PROGBITS        0000000000000000 003399 000018 18 WAM  0   0  1
File: ./arch/powerpc/lib/hweight_64.o
File: ./arch/powerpc/lib/ldstfp.o
File: ./arch/powerpc/lib/copyuser_power7.o
File: ./arch/powerpc/lib/usercopy_64.o
File: ./arch/powerpc/lib/feature-fixups-test.o
File: ./arch/powerpc/lib/xor_vmx.o
File: ./arch/powerpc/lib/mem_64.o
File: ./arch/powerpc/lib/copypage_64.o
File: ./arch/powerpc/lib/copyuser_64.o
File: ./arch/powerpc/lib/memcpy_64.o
File: ./arch/powerpc/lib/vmx-helper.o
File: ./arch/powerpc/lib/memcmp_64.o
File: ./arch/powerpc/lib/locks.o
File: ./arch/powerpc/lib/built-in.o
  [125] __jump_table      PROGBITS        0000000000000000 00b8e8 000018 18 WAM  0   0  1
File: ./arch/powerpc/mm/fault.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000a34 000078 18 WAM  0   0  1
File: ./arch/powerpc/mm/pgtable_64.o
  [69] __jump_table      PROGBITS        0000000000000000 000eef 000030 18 WAM  0   0  1
File: ./arch/powerpc/mm/mem.o
  [25] __jump_table      PROGBITS        0000000000000000 000e10 000030 18 WAM  0   0  1
File: ./arch/powerpc/mm/tlb-radix.o
  [30] __jump_table      PROGBITS        0000000000000000 000e30 0000c0 18 WAM  0   0  1
File: ./arch/powerpc/mm/slb.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000f80 000060 18 WAM  0   0  1
File: ./arch/powerpc/mm/pgtable-book3s64.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0007b0 000108 18 WAM  0   0  1
File: ./arch/powerpc/mm/pgtable.o
  [12] __jump_table      PROGBITS        0000000000000000 0004aa 0000a8 18 WAM  0   0  1
File: ./arch/powerpc/mm/hugetlbpage.o
  [16] __jump_table      PROGBITS        0000000000000000 001d04 000108 18 WAM  0   0  1
File: ./arch/powerpc/mm/mmap.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000828 000018 18 WAM  0   0  1
File: ./arch/powerpc/mm/init_64.o
  [24] __jump_table      PROGBITS        0000000000000000 000880 000030 18 WAM  0   0  1
File: ./arch/powerpc/mm/slice.o
  [15] __jump_table      PROGBITS        0000000000000000 001198 000030 18 WAM  0   0  1
File: ./arch/powerpc/mm/hugetlbpage-hash64.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000488 000018 18 WAM  0   0  1
File: ./arch/powerpc/mm/copro_fault.o
  [17] __jump_table      PROGBITS        0000000000000000 00062e 000018 18 WAM  0   0  1
File: ./arch/powerpc/mm/slb_low.o
File: ./arch/powerpc/mm/init-common.o
File: ./arch/powerpc/mm/hash_native_64.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001cb8 0002a0 18 WAM  0   0  1
File: ./arch/powerpc/mm/hugetlbpage-radix.o
File: ./arch/powerpc/mm/pgtable-hash64.o
  [14] __jump_table      PROGBITS        0000000000000000 001ca0 000060 18 WAM  0   0  1
File: ./arch/powerpc/mm/mmu_context_book3s64.o
  [12] __jump_table      PROGBITS        0000000000000000 0004c0 000048 18 WAM  0   0  1
File: ./arch/powerpc/mm/pgtable-radix.o
  [11] __jump_table      PROGBITS        0000000000000000 00216c 0001b0 18 WAM  0   0  1
File: ./arch/powerpc/mm/hash_utils_64.o
  [32] __jump_table      PROGBITS        0000000000000000 003b72 0000f0 18 WAM  0   0  1
File: ./arch/powerpc/mm/subpage-prot.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000c94 000078 18 WAM  0   0  1
File: ./arch/powerpc/mm/numa.o
File: ./arch/powerpc/mm/tlb_hash64.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000a60 000078 18 WAM  0   0  1
File: ./arch/powerpc/mm/hugepage-hash64.o
File: ./arch/powerpc/mm/hash64_64k.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000bf4 000048 18 WAM  0   0  1
File: ./arch/powerpc/mm/vphn.o
File: ./arch/powerpc/mm/built-in.o
  [177] __jump_table      PROGBITS        0000000000000000 01a990 000c78 18 WAM  0   0  1
File: ./arch/powerpc/oprofile/common.o
File: ./arch/powerpc/oprofile/backtrace.o
File: ./arch/powerpc/oprofile/op_model_power4.o
File: ./arch/powerpc/oprofile/op_model_pa6t.o
File: ./arch/powerpc/oprofile/oprofile.o
File: ./arch/powerpc/oprofile/built-in.o
File: ./arch/powerpc/perf/callchain.o
File: ./arch/powerpc/perf/perf_regs.o
File: ./arch/powerpc/perf/core-book3s.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0039b0 000060 18 WAM  0   0  1
File: ./arch/powerpc/perf/bhrb.o
File: ./arch/powerpc/perf/hv-24x7.o
File: ./arch/powerpc/perf/hv-gpci.o
File: ./arch/powerpc/perf/hv-common.o
File: ./arch/powerpc/perf/power4-pmu.o
File: ./arch/powerpc/perf/built-in.o
  [18] __jump_table      PROGBITS        0000000000000000 016171 0001c8 18 WAM  0   0  1
File: ./arch/powerpc/perf/ppc970-pmu.o
File: ./arch/powerpc/perf/power5-pmu.o
File: ./arch/powerpc/perf/power5+-pmu.o
File: ./arch/powerpc/perf/power6-pmu.o
File: ./arch/powerpc/perf/power7-pmu.o
File: ./arch/powerpc/perf/isa207-common.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000cd0 000138 18 WAM  0   0  1
File: ./arch/powerpc/perf/power8-pmu.o
  [10] __jump_table      PROGBITS        0000000000000000 000454 000018 18 WAM  0   0  1
File: ./arch/powerpc/perf/power9-pmu.o
  [10] __jump_table      PROGBITS        0000000000000000 000914 000018 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/opal-sensor.o
File: ./arch/powerpc/platforms/powernv/npu-dma.o
File: ./arch/powerpc/platforms/powernv/opal-irqchip.o
File: ./arch/powerpc/platforms/powernv/opal-wrappers.o
  [ 5] __jump_table      PROGBITS        0000000000000000 00321c 000b28 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/built-in.o
  [124] __jump_table      PROGBITS        0000000000000000 01fd80 000c48 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/opal.o
File: ./arch/powerpc/platforms/powernv/opal-hmi.o
File: ./arch/powerpc/platforms/powernv/setup.o
File: ./arch/powerpc/platforms/powernv/opal-async.o
File: ./arch/powerpc/platforms/powernv/opal-kmsg.o
File: ./arch/powerpc/platforms/powernv/idle.o
  [14] __jump_table      PROGBITS        0000000000000000 001170 000030 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/opal-msglog.o
File: ./arch/powerpc/platforms/powernv/pci-ioda.o
File: ./arch/powerpc/platforms/powernv/opal-rtc.o
File: ./arch/powerpc/platforms/powernv/opal-xscom.o
File: ./arch/powerpc/platforms/powernv/pci-cxl.o
File: ./arch/powerpc/platforms/powernv/opal-nvram.o
File: ./arch/powerpc/platforms/powernv/eeh-powernv.o
File: ./arch/powerpc/platforms/powernv/opal-lpc.o
File: ./arch/powerpc/platforms/powernv/opal-flash.o
File: ./arch/powerpc/platforms/powernv/rng.o
File: ./arch/powerpc/platforms/powernv/opal-elog.o
File: ./arch/powerpc/platforms/powernv/opal-power.o
File: ./arch/powerpc/platforms/powernv/opal-dump.o
File: ./arch/powerpc/platforms/powernv/opal-sysparam.o
File: ./arch/powerpc/platforms/powernv/opal-tracepoints.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000318 000030 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/smp.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0006a4 0000a8 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/subcore.o
  [12] __jump_table      PROGBITS        0000000000000000 000b70 000018 18 WAM  0   0  1
File: ./arch/powerpc/platforms/powernv/subcore-asm.o
File: ./arch/powerpc/platforms/powernv/pci.o
File: ./arch/powerpc/platforms/pseries/smp.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000588 000048 18 WAM  0   0  1
File: ./arch/powerpc/platforms/pseries/hvcserver.o
File: ./arch/powerpc/platforms/pseries/lpar.o
  [24] __jump_table      PROGBITS        0000000000000000 002624 0000d8 18 WAM  0   0  1
File: ./arch/powerpc/platforms/pseries/msi.o
File: ./arch/powerpc/platforms/pseries/hvCall.o
  [ 5] __jump_table      PROGBITS        0000000000000000 000428 000048 18 WAM  0   0  1
File: ./arch/powerpc/platforms/pseries/kexec.o
File: ./arch/powerpc/platforms/pseries/nvram.o
File: ./arch/powerpc/platforms/pseries/pci_dlpar.o
File: ./arch/powerpc/platforms/pseries/reconfig.o
File: ./arch/powerpc/platforms/pseries/of_helpers.o
File: ./arch/powerpc/platforms/pseries/pseries_energy.o
File: ./arch/powerpc/platforms/pseries/vio.o
File: ./arch/powerpc/platforms/pseries/setup.o
File: ./arch/powerpc/platforms/pseries/iommu.o
File: ./arch/powerpc/platforms/pseries/suspend.o
File: ./arch/powerpc/platforms/pseries/event_sources.o
File: ./arch/powerpc/platforms/pseries/hotplug-cpu.o
File: ./arch/powerpc/platforms/pseries/ras.o
File: ./arch/powerpc/platforms/pseries/firmware.o
File: ./arch/powerpc/platforms/pseries/power.o
File: ./arch/powerpc/platforms/pseries/dlpar.o
File: ./arch/powerpc/platforms/pseries/eeh_pseries.o
File: ./arch/powerpc/platforms/pseries/scanlog.o
File: ./arch/powerpc/platforms/pseries/mobility.o
File: ./arch/powerpc/platforms/pseries/rng.o
File: ./arch/powerpc/platforms/pseries/lparcfg.o
File: ./arch/powerpc/platforms/pseries/pci.o
File: ./arch/powerpc/platforms/pseries/hotplug-memory.o
File: ./arch/powerpc/platforms/pseries/built-in.o
  [70] __jump_table      PROGBITS        0000000000000000 01e338 000168 18 WAM  0   0  1
File: ./arch/powerpc/platforms/pseries/hvcserver.mod.o
File: ./arch/powerpc/platforms/pseries/hvconsole.o
File: ./arch/powerpc/platforms/pseries/cmm.o
File: ./arch/powerpc/platforms/pseries/dtl.o
File: ./arch/powerpc/platforms/pseries/scanlog.mod.o
File: ./arch/powerpc/platforms/pseries/io_event_irq.o
File: ./arch/powerpc/platforms/built-in.o
  [178] __jump_table      PROGBITS        0000000000000000 03e280 000db0 18 WAM  0   0  1
File: ./arch/powerpc/purgatory/trampoline.o
File: ./arch/powerpc/purgatory/kexec-purgatory.o
File: ./arch/powerpc/purgatory/built-in.o
File: ./arch/powerpc/sysdev/xics/xics-common.o
File: ./arch/powerpc/sysdev/xics/icp-hv.o
File: ./arch/powerpc/sysdev/xics/ics-rtas.o
File: ./arch/powerpc/sysdev/xics/ics-opal.o
File: ./arch/powerpc/sysdev/xics/icp-opal.o
File: ./arch/powerpc/sysdev/xics/icp-native.o
  [15] __jump_table      PROGBITS        0000000000000000 000e08 000018 18 WAM  0   0  1
File: ./arch/powerpc/sysdev/xics/built-in.o
  [16] __jump_table      PROGBITS        0000000000000000 003fd8 000018 18 WAM  0   0  1
File: ./arch/powerpc/sysdev/scom.o
File: ./arch/powerpc/sysdev/mpic_msi.o
File: ./arch/powerpc/sysdev/mpic_u3msi.o
File: ./arch/powerpc/sysdev/mpic.o
File: ./arch/powerpc/sysdev/msi_bitmap.o
File: ./arch/powerpc/sysdev/built-in.o
  [52] __jump_table      PROGBITS        0000000000000000 00b8b8 000018 18 WAM  0   0  1
File: ./arch/powerpc/sysdev/i8259.o
File: ./arch/powerpc/xmon/nonstdio.o
File: ./arch/powerpc/xmon/spr_access.o
File: ./arch/powerpc/xmon/ppc-dis.o
File: ./arch/powerpc/xmon/ppc-opc.o
File: ./arch/powerpc/xmon/xmon.o
  [16] __jump_table      PROGBITS        0000000000000000 009668 0000a8 18 WAM  0   0  1
File: ./arch/powerpc/xmon/built-in.o
  [14] __jump_table      PROGBITS        0000000000000000 0430d8 0000a8 18 WAM  0   0  1
File: ./block/partitions/check.o
File: ./block/partitions/msdos.o
File: ./block/partitions/efi.o
File: ./block/partitions/built-in.o
File: ./block/built-in.o
  [672] __jump_table      PROGBITS        0000000000000000 047058 0002e8 18 WAM  0   0  1
File: ./block/blk-sysfs.o
File: ./block/blk-ioc.o
File: ./block/blk-exec.o
File: ./block/badblocks.o
File: ./block/blk-timeout.o
File: ./block/blk-mq-sched.o
  [23] __jump_table      PROGBITS        0000000000000000 00164d 000018 18 WAM  0   0  1
File: ./block/bsg.o
File: ./block/blk-tag.o
File: ./block/bio.o
File: ./block/genhd.o
File: ./block/blk-softirq.o
File: ./block/elevator.o
  [56] __jump_table      PROGBITS        0000000000000000 003238 000018 18 WAM  0   0  1
File: ./block/blk-lib.o
File: ./block/blk-flush.o
File: ./block/blk-map.o
File: ./block/blk-merge.o
  [17] __jump_table      PROGBITS        0000000000000000 002d9a 000018 18 WAM  0   0  1
File: ./block/blk-mq.o
  [90] __jump_table      PROGBITS        0000000000000000 007308 000150 18 WAM  0   0  1
File: ./block/ioprio.o
File: ./block/bounce.o
  [13] __jump_table      PROGBITS        0000000000000000 000b9b 000018 18 WAM  0   0  1
File: ./block/blk-settings.o
File: ./block/blk-core.o
  [149] __jump_table      PROGBITS        0000000000000000 00c4d0 000138 18 WAM  0   0  1
File: ./block/scsi_ioctl.o
File: ./block/partition-generic.o
File: ./block/blk-mq-cpumap.o
File: ./block/bsg-lib.o
File: ./block/blk-mq-tag.o
File: ./block/blk-stat.o
File: ./block/deadline-iosched.o
File: ./block/blk-mq-pci.o
File: ./block/blk-mq-sysfs.o
File: ./block/ioctl.o
File: ./block/noop-iosched.o
File: ./block/cfq-iosched.o
File: ./block/mq-deadline.o
File: ./block/compat_ioctl.o
File: ./block/blk-mq-debugfs.o
File: ./crypto/async_tx/async_xor.mod.o
File: ./crypto/async_tx/async_raid6_recov.mod.o
File: ./crypto/async_tx/async_tx.o
File: ./crypto/async_tx/async_memcpy.o
File: ./crypto/async_tx/async_xor.o
File: ./crypto/async_tx/async_pq.o
File: ./crypto/async_tx/async_raid6_recov.o
File: ./crypto/async_tx/async_memcpy.mod.o
File: ./crypto/async_tx/async_pq.mod.o
File: ./crypto/async_tx/async_tx.mod.o
File: ./crypto/api.o
File: ./crypto/crypto.o
File: ./crypto/ablkcipher.o
File: ./crypto/crypto_wq.o
File: ./crypto/proc.o
File: ./crypto/cipher.o
File: ./crypto/compress.o
File: ./crypto/algapi.o
File: ./crypto/memneq.o
File: ./crypto/scatterwalk.o
File: ./crypto/khazad.o
File: ./crypto/testmgr.o
File: ./crypto/ahash.o
File: ./crypto/md4.o
File: ./crypto/anubis.o
File: ./crypto/ecb.o
File: ./crypto/twofish_common.o
File: ./crypto/blkcipher.o
File: ./crypto/cbc.o
File: ./crypto/deflate.o
File: ./crypto/skcipher.o
File: ./crypto/crypto_algapi.o
File: ./crypto/aead.o
File: ./crypto/pcbc.o
File: ./crypto/serpent_generic.o
File: ./crypto/salsa20_generic.o
File: ./crypto/acompress.o
File: ./crypto/built-in.o
File: ./crypto/cryptomgr.o
File: ./crypto/anubis.mod.o
File: ./crypto/michael_mic.o
File: ./crypto/arc4.mod.o
File: ./crypto/drbg.o
File: ./crypto/shash.o
File: ./crypto/akcipher.o
File: ./crypto/cast_common.o
File: ./crypto/authenc.o
File: ./crypto/md5.o
File: ./crypto/des_generic.o
File: ./crypto/kpp.o
File: ./crypto/scompress.o
File: ./crypto/tgr192.o
File: ./crypto/crct10dif_generic.o
File: ./crypto/algboss.o
File: ./crypto/authencesn.o
File: ./crypto/cbc.mod.o
File: ./crypto/hmac.o
File: ./crypto/cmac.mod.o
File: ./crypto/drbg.mod.o
File: ./crypto/crypto_null.o
File: ./crypto/cmac.o
File: ./crypto/tcrypt.o
File: ./crypto/crct10dif_common.o
File: ./crypto/sha256_generic.o
File: ./crypto/cast6_generic.o
File: ./crypto/gf128mul.o
File: ./crypto/aes_generic.o
File: ./crypto/blowfish_common.o
File: ./crypto/crc32c_generic.o
File: ./crypto/xor.o
  [16] __jump_table      PROGBITS        0000000000000000 001f90 000018 18 WAM  0   0  1
File: ./crypto/arc4.o
File: ./crypto/rng.o
File: ./crypto/sha1_generic.o
File: ./crypto/ecb.mod.o
File: ./crypto/twofish_generic.o
File: ./crypto/lzo.o
File: ./crypto/crypto_engine.o
File: ./crypto/wp512.o
File: ./crypto/blowfish_generic.o
File: ./crypto/tea.o
File: ./crypto/echainiv.o
File: ./crypto/khazad.mod.o
File: ./crypto/md5.mod.o
File: ./crypto/tea.mod.o
File: ./crypto/crypto_blkcipher.o
File: ./crypto/jitterentropy.o
File: ./crypto/md4.mod.o
File: ./crypto/michael_mic.mod.o
File: ./crypto/jitterentropy-kcapi.o
File: ./crypto/tcrypt.mod.o
File: ./crypto/ghash-generic.o
File: ./crypto/crypto_hash.o
File: ./crypto/crypto_acompress.o
File: ./crypto/jitterentropy_rng.o
File: ./crypto/cast6_generic.mod.o
File: ./crypto/authenc.mod.o
File: ./crypto/jitterentropy_rng.mod.o
File: ./crypto/xor.mod.o
File: ./crypto/lzo.mod.o
File: ./crypto/crypto_engine.mod.o
File: ./crypto/authencesn.mod.o
File: ./crypto/deflate.mod.o
File: ./crypto/gf128mul.mod.o
File: ./crypto/blowfish_common.mod.o
File: ./crypto/blowfish_generic.mod.o
File: ./crypto/crct10dif_generic.mod.o
File: ./crypto/des_generic.mod.o
File: ./crypto/wp512.mod.o
File: ./crypto/cast_common.mod.o
File: ./crypto/sha1_generic.mod.o
File: ./crypto/tgr192.mod.o
File: ./crypto/echainiv.mod.o
File: ./crypto/crct10dif_common.mod.o
File: ./crypto/ghash-generic.mod.o
File: ./crypto/pcbc.mod.o
File: ./crypto/salsa20_generic.mod.o
File: ./crypto/serpent_generic.mod.o
File: ./crypto/twofish_common.mod.o
File: ./crypto/twofish_generic.mod.o
File: ./drivers/ata/libata-trace.o
File: ./drivers/ata/libata-pmp.o
File: ./drivers/ata/built-in.o
  [466] __jump_table      PROGBITS        0000000000000000 03d0b0 0000c0 18 WAM  0   0  1
File: ./drivers/ata/libata-core.o
  [238] __jump_table      PROGBITS        0000000000000000 0132e0 000078 18 WAM  0   0  1
File: ./drivers/ata/libata-scsi.o
File: ./drivers/ata/libata-transport.o
File: ./drivers/ata/libata.o
  [412] __jump_table      PROGBITS        0000000000000000 030188 0000c0 18 WAM  0   0  1
File: ./drivers/ata/libata-sff.o
File: ./drivers/ata/libata-eh.o
  [26] __jump_table      PROGBITS        0000000000000000 008e4c 000048 18 WAM  0   0  1
File: ./drivers/ata/libahci.o
File: ./drivers/ata/ahci.o
File: ./drivers/ata/pata_amd.o
File: ./drivers/ata/ata_generic.o
File: ./drivers/base/power/sysfs.o
File: ./drivers/base/power/generic_ops.o
File: ./drivers/base/power/common.o
File: ./drivers/base/power/qos.o
  [44] __jump_table      PROGBITS        0000000000000000 001f48 000060 18 WAM  0   0  1
File: ./drivers/base/power/wakeirq.o
File: ./drivers/base/power/runtime.o
  [50] __jump_table      PROGBITS        0000000000000000 0038d0 0000d8 18 WAM  0   0  1
File: ./drivers/base/power/main.o
  [26] __jump_table      PROGBITS        0000000000000000 005078 000240 18 WAM  0   0  1
File: ./drivers/base/power/wakeup.o
  [56] __jump_table      PROGBITS        0000000000000000 001f68 000030 18 WAM  0   0  1
File: ./drivers/base/power/built-in.o
  [260] __jump_table      PROGBITS        0000000000000000 00ffc0 0003a8 18 WAM  0   0  1
File: ./drivers/base/regmap/regcache-rbtree.o
File: ./drivers/base/regmap/regcache-lzo.o
File: ./drivers/base/regmap/regcache-flat.o
File: ./drivers/base/regmap/regmap-debugfs.o
File: ./drivers/base/regmap/regmap.o
  [93] __jump_table      PROGBITS        0000000000000000 0087e0 000168 18 WAM  0   0  1
File: ./drivers/base/regmap/regcache.o
  [23] __jump_table      PROGBITS        0000000000000000 001fe4 0000c0 18 WAM  0   0  1
File: ./drivers/base/regmap/regmap-i2c.o
File: ./drivers/base/regmap/built-in.o
  [107] __jump_table      PROGBITS        0000000000000000 00e4b0 000228 18 WAM  0   0  1
File: ./drivers/base/component.o
File: ./drivers/base/transport_class.o
File: ./drivers/base/dd.o
File: ./drivers/base/built-in.o
  [904] __jump_table      PROGBITS        0000000000000000 03eac0 000630 18 WAM  0   0  1
File: ./drivers/base/core.o
File: ./drivers/base/syscore.o
  [20] __jump_table      PROGBITS        0000000000000000 0009b8 000060 18 WAM  0   0  1
File: ./drivers/base/devres.o
File: ./drivers/base/bus.o
File: ./drivers/base/driver.o
File: ./drivers/base/class.o
File: ./drivers/base/platform.o
File: ./drivers/base/topology.o
File: ./drivers/base/cpu.o
File: ./drivers/base/firmware.o
File: ./drivers/base/attribute_container.o
File: ./drivers/base/container.o
File: ./drivers/base/init.o
File: ./drivers/base/firmware_class.o
File: ./drivers/base/map.o
File: ./drivers/base/property.o
File: ./drivers/base/module.o
File: ./drivers/base/cacheinfo.o
File: ./drivers/base/devtmpfs.o
File: ./drivers/base/dma-mapping.o
File: ./drivers/base/node.o
File: ./drivers/base/memory.o
File: ./drivers/block/brd.o
File: ./drivers/block/floppy.o
File: ./drivers/block/nbd.o
File: ./drivers/block/virtio_blk.o
File: ./drivers/block/loop.o
File: ./drivers/block/built-in.o
File: ./drivers/block/floppy.mod.o
File: ./drivers/block/nbd.mod.o
File: ./drivers/block/virtio_blk.mod.o
File: ./drivers/cdrom/cdrom.o
File: ./drivers/cdrom/built-in.o
File: ./drivers/char/hw_random/pseries-rng.o
File: ./drivers/char/hw_random/powernv-rng.o
File: ./drivers/char/hw_random/core.o
File: ./drivers/char/hw_random/rng-core.o
File: ./drivers/char/hw_random/powernv-rng.mod.o
File: ./drivers/char/hw_random/pseries-rng.mod.o
File: ./drivers/char/hw_random/rng-core.mod.o
File: ./drivers/char/mem.o
File: ./drivers/char/random.o
  [43] __jump_table      PROGBITS        0000000000000000 0075d8 000168 18 WAM  0   0  1
File: ./drivers/char/built-in.o
  [52] __jump_table      PROGBITS        0000000000000000 00a8e8 000168 18 WAM  0   0  1
File: ./drivers/char/powernv-op-panel.mod.o
File: ./drivers/char/misc.o
File: ./drivers/char/bsr.mod.o
File: ./drivers/char/virtio_console.mod.o
File: ./drivers/char/raw.o
File: ./drivers/char/virtio_console.o
File: ./drivers/char/bsr.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000370 000018 18 WAM  0   0  1
File: ./drivers/char/powernv-op-panel.o
File: ./drivers/clk/built-in.o
File: ./drivers/clocksource/built-in.o
File: ./drivers/clocksource/dummy_timer.o
File: ./drivers/clocksource/i8253.o
File: ./drivers/cpufreq/cpufreq_performance.o
File: ./drivers/cpufreq/cpufreq_powersave.o
File: ./drivers/cpufreq/cpufreq_userspace.o
File: ./drivers/cpufreq/cpufreq_ondemand.o
File: ./drivers/cpufreq/cpufreq_governor.o
File: ./drivers/cpufreq/cpufreq.o
  [83] __jump_table      PROGBITS        0000000000000000 0066b8 000018 18 WAM  0   0  1
File: ./drivers/cpufreq/freq_table.o
File: ./drivers/cpufreq/powernv-cpufreq.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0020e8 000048 18 WAM  0   0  1
File: ./drivers/cpufreq/cpufreq_conservative.o
File: ./drivers/cpufreq/built-in.o
  [131] __jump_table      PROGBITS        0000000000000000 00e220 000060 18 WAM  0   0  1
File: ./drivers/cpufreq/cpufreq_governor_attr_set.o
File: ./drivers/cpuidle/governors/menu.o
File: ./drivers/cpuidle/governors/built-in.o
File: ./drivers/cpuidle/governor.o
File: ./drivers/cpuidle/sysfs.o
File: ./drivers/cpuidle/cpuidle-pseries.o
  [ 8] __jump_table      PROGBITS        0000000000000000 000b10 000090 18 WAM  0   0  1
File: ./drivers/cpuidle/cpuidle-powernv.o
  [ 8] __jump_table      PROGBITS        0000000000000000 000ce8 000090 18 WAM  0   0  1
File: ./drivers/cpuidle/driver.o
File: ./drivers/cpuidle/cpuidle.o
  [30] __jump_table      PROGBITS        0000000000000000 0013a8 000048 18 WAM  0   0  1
File: ./drivers/cpuidle/built-in.o
  [40] __jump_table      PROGBITS        0000000000000000 005ba8 000168 18 WAM  0   0  1
File: ./drivers/crypto/nx/nx-842-pseries.o
File: ./drivers/crypto/nx/nx-842-powernv.o
File: ./drivers/crypto/nx/nx-842.o
File: ./drivers/crypto/nx/nx-compress-pseries.o
File: ./drivers/crypto/nx/nx-compress.o
File: ./drivers/crypto/nx/nx-compress-powernv.o
File: ./drivers/crypto/nx/built-in.o
File: ./drivers/crypto/virtio/virtio_crypto_algs.o
File: ./drivers/crypto/virtio/virtio_crypto_mgr.o
File: ./drivers/crypto/virtio/virtio_crypto_core.o
File: ./drivers/crypto/virtio/virtio_crypto.o
File: ./drivers/crypto/virtio/virtio_crypto.mod.o
File: ./drivers/crypto/vmx/vmx.o
File: ./drivers/crypto/vmx/aes.o
File: ./drivers/crypto/vmx/aes_cbc.o
File: ./drivers/crypto/vmx/aes_ctr.o
File: ./drivers/crypto/vmx/aes_xts.o
File: ./drivers/crypto/vmx/ghash.o
File: ./drivers/crypto/vmx/aesp8-ppc.o
File: ./drivers/crypto/vmx/ghashp8-ppc.o
File: ./drivers/crypto/vmx/vmx-crypto.o
File: ./drivers/crypto/vmx/vmx-crypto.mod.o
File: ./drivers/crypto/built-in.o
File: ./drivers/firmware/built-in.o
File: ./drivers/gpu/drm/omapdrm/built-in.o
File: ./drivers/gpu/drm/built-in.o
File: ./drivers/gpu/vga/vgaarb.o
File: ./drivers/gpu/vga/built-in.o
File: ./drivers/gpu/built-in.o
File: ./drivers/hid/usbhid/hid-core.o
File: ./drivers/hid/usbhid/hid-quirks.o
File: ./drivers/hid/usbhid/hiddev.o
File: ./drivers/hid/usbhid/usbhid.o
File: ./drivers/hid/usbhid/built-in.o
File: ./drivers/hid/hid-input.o
File: ./drivers/hid/hid-kensington.o
File: ./drivers/hid/built-in.o
File: ./drivers/hid/hid-core.o
File: ./drivers/hid/hid.o
File: ./drivers/hid/hid-logitech.o
File: ./drivers/hid/hid-generic.o
File: ./drivers/hid/hid-a4tech.o
File: ./drivers/hid/hid-apple.o
File: ./drivers/hid/hid-belkin.o
File: ./drivers/hid/hid-cherry.o
File: ./drivers/hid/hid-chicony.o
File: ./drivers/hid/hid-cypress.o
File: ./drivers/hid/hid-ezkey.o
File: ./drivers/hid/hid-gyration.o
File: ./drivers/hid/hid-lg.o
File: ./drivers/hid/hid-microsoft.o
File: ./drivers/hid/hid-monterey.o
File: ./drivers/hid/hid-pl.o
File: ./drivers/hid/hid-petalynx.o
File: ./drivers/hid/hid-samsung.o
File: ./drivers/hid/hid-sunplus.o
File: ./drivers/hid/hid-debug.o
File: ./drivers/hwmon/ibmpowernv.o
File: ./drivers/hwmon/hwmon.o
File: ./drivers/hwmon/built-in.o
File: ./drivers/i2c/algos/i2c-algo-bit.o
File: ./drivers/i2c/algos/built-in.o
File: ./drivers/i2c/busses/i2c-opal.o
File: ./drivers/i2c/busses/built-in.o
File: ./drivers/i2c/i2c-boardinfo.o
File: ./drivers/i2c/i2c-core.o
  [114] __jump_table      PROGBITS        0000000000000000 009d50 000108 18 WAM  0   0  1
File: ./drivers/i2c/built-in.o
  [132] __jump_table      PROGBITS        0000000000000000 00c508 000108 18 WAM  0   0  1
File: ./drivers/infiniband/core/rdma_cm.o
File: ./drivers/infiniband/core/addr.o
File: ./drivers/infiniband/core/iw_cm.o
File: ./drivers/infiniband/core/umem_odp.o
File: ./drivers/infiniband/core/ib_uverbs.o
File: ./drivers/infiniband/core/ib_cm.mod.o
File: ./drivers/infiniband/core/packer.o
File: ./drivers/infiniband/core/ib_ucm.o
File: ./drivers/infiniband/core/user_mad.o
File: ./drivers/infiniband/core/uverbs_main.o
File: ./drivers/infiniband/core/rw.o
File: ./drivers/infiniband/core/ud_header.o
File: ./drivers/infiniband/core/cma.o
File: ./drivers/infiniband/core/cq.o
File: ./drivers/infiniband/core/verbs.o
File: ./drivers/infiniband/core/umem.o
File: ./drivers/infiniband/core/uverbs_cmd.o
File: ./drivers/infiniband/core/mad_rmpp.o
File: ./drivers/infiniband/core/rdma_ucm.o
File: ./drivers/infiniband/core/sysfs.o
File: ./drivers/infiniband/core/cm.o
File: ./drivers/infiniband/core/device.o
File: ./drivers/infiniband/core/fmr_pool.o
File: ./drivers/infiniband/core/roce_gid_mgmt.o
File: ./drivers/infiniband/core/uverbs_marshall.o
File: ./drivers/infiniband/core/iwpm_msg.o
File: ./drivers/infiniband/core/ib_core.o
File: ./drivers/infiniband/core/cache.o
File: ./drivers/infiniband/core/mr_pool.o
File: ./drivers/infiniband/core/netlink.o
File: ./drivers/infiniband/core/umem_rbtree.o
File: ./drivers/infiniband/core/ucm.o
File: ./drivers/infiniband/core/ucma.o
File: ./drivers/infiniband/core/sa_query.o
File: ./drivers/infiniband/core/multicast.o
File: ./drivers/infiniband/core/iwpm_util.o
File: ./drivers/infiniband/core/ib_ucm.mod.o
File: ./drivers/infiniband/core/iw_cm.mod.o
File: ./drivers/infiniband/core/mad.o
File: ./drivers/infiniband/core/smi.o
File: ./drivers/infiniband/core/iwcm.o
File: ./drivers/infiniband/core/ib_cm.o
File: ./drivers/infiniband/core/agent.o
File: ./drivers/infiniband/core/ib_umad.o
File: ./drivers/infiniband/core/ib_core.mod.o
File: ./drivers/infiniband/core/ib_umad.mod.o
File: ./drivers/infiniband/core/ib_uverbs.mod.o
File: ./drivers/infiniband/core/rdma_cm.mod.o
File: ./drivers/infiniband/core/rdma_ucm.mod.o
File: ./drivers/infiniband/hw/cxgb3/iwch_cm.o
File: ./drivers/infiniband/hw/cxgb3/iwch_ev.o
File: ./drivers/infiniband/hw/cxgb3/iwch_cq.o
File: ./drivers/infiniband/hw/cxgb3/iwch_qp.o
File: ./drivers/infiniband/hw/cxgb3/iwch_mem.o
File: ./drivers/infiniband/hw/cxgb3/iwch_provider.o
File: ./drivers/infiniband/hw/cxgb3/iwch.o
File: ./drivers/infiniband/hw/cxgb3/cxio_hal.o
File: ./drivers/infiniband/hw/cxgb3/cxio_resource.o
File: ./drivers/infiniband/hw/cxgb3/iw_cxgb3.o
File: ./drivers/infiniband/hw/cxgb3/iw_cxgb3.mod.o
File: ./drivers/infiniband/hw/cxgb4/device.o
File: ./drivers/infiniband/hw/cxgb4/cm.o
File: ./drivers/infiniband/hw/cxgb4/provider.o
File: ./drivers/infiniband/hw/cxgb4/mem.o
File: ./drivers/infiniband/hw/cxgb4/cq.o
File: ./drivers/infiniband/hw/cxgb4/qp.o
File: ./drivers/infiniband/hw/cxgb4/resource.o
File: ./drivers/infiniband/hw/cxgb4/ev.o
File: ./drivers/infiniband/hw/cxgb4/id_table.o
File: ./drivers/infiniband/hw/cxgb4/iw_cxgb4.o
File: ./drivers/infiniband/hw/cxgb4/iw_cxgb4.mod.o
File: ./drivers/infiniband/hw/mlx4/ah.o
File: ./drivers/infiniband/hw/mlx4/cq.o
File: ./drivers/infiniband/hw/mlx4/doorbell.o
File: ./drivers/infiniband/hw/mlx4/mad.o
File: ./drivers/infiniband/hw/mlx4/main.o
File: ./drivers/infiniband/hw/mlx4/mr.o
File: ./drivers/infiniband/hw/mlx4/qp.o
File: ./drivers/infiniband/hw/mlx4/srq.o
File: ./drivers/infiniband/hw/mlx4/mcg.o
File: ./drivers/infiniband/hw/mlx4/cm.o
File: ./drivers/infiniband/hw/mlx4/alias_GUID.o
File: ./drivers/infiniband/hw/mlx4/sysfs.o
File: ./drivers/infiniband/hw/mlx4/mlx4_ib.o
File: ./drivers/infiniband/hw/mlx4/mlx4_ib.mod.o
File: ./drivers/infiniband/hw/mthca/mthca_catas.o
File: ./drivers/infiniband/hw/mthca/mthca_main.o
File: ./drivers/infiniband/hw/mthca/mthca_srq.o
File: ./drivers/infiniband/hw/mthca/mthca_cmd.o
File: ./drivers/infiniband/hw/mthca/ib_mthca.mod.o
File: ./drivers/infiniband/hw/mthca/mthca_profile.o
File: ./drivers/infiniband/hw/mthca/mthca_reset.o
File: ./drivers/infiniband/hw/mthca/mthca_allocator.o
File: ./drivers/infiniband/hw/mthca/mthca_eq.o
File: ./drivers/infiniband/hw/mthca/mthca_pd.o
File: ./drivers/infiniband/hw/mthca/mthca_cq.o
File: ./drivers/infiniband/hw/mthca/mthca_mr.o
File: ./drivers/infiniband/hw/mthca/mthca_qp.o
File: ./drivers/infiniband/hw/mthca/mthca_av.o
File: ./drivers/infiniband/hw/mthca/ib_mthca.o
File: ./drivers/infiniband/hw/mthca/mthca_mcg.o
File: ./drivers/infiniband/hw/mthca/mthca_mad.o
File: ./drivers/infiniband/hw/mthca/mthca_provider.o
File: ./drivers/infiniband/hw/mthca/mthca_memfree.o
File: ./drivers/infiniband/hw/mthca/mthca_uar.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_main.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_ib.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_multicast.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_verbs.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_vlan.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_ethtool.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_netlink.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_cm.o
File: ./drivers/infiniband/ulp/ipoib/ipoib_fs.o
File: ./drivers/infiniband/ulp/ipoib/ib_ipoib.o
File: ./drivers/infiniband/ulp/ipoib/ib_ipoib.mod.o
File: ./drivers/infiniband/ulp/iser/iser_verbs.o
File: ./drivers/infiniband/ulp/iser/iser_initiator.o
File: ./drivers/infiniband/ulp/iser/iser_memory.o
File: ./drivers/infiniband/ulp/iser/iscsi_iser.o
File: ./drivers/infiniband/ulp/iser/ib_iser.o
File: ./drivers/infiniband/ulp/iser/ib_iser.mod.o
File: ./drivers/infiniband/ulp/srp/ib_srp.o
File: ./drivers/infiniband/ulp/srp/ib_srp.mod.o
File: ./drivers/input/keyboard/atkbd.o
File: ./drivers/input/keyboard/built-in.o
File: ./drivers/input/misc/pcspkr.o
File: ./drivers/input/misc/pcspkr.mod.o
File: ./drivers/input/mouse/psmouse-base.o
File: ./drivers/input/mouse/synaptics.o
File: ./drivers/input/mouse/focaltech.o
File: ./drivers/input/mouse/alps.o
File: ./drivers/input/mouse/byd.o
File: ./drivers/input/mouse/logips2pp.o
File: ./drivers/input/mouse/trackpoint.o
File: ./drivers/input/mouse/cypress_ps2.o
File: ./drivers/input/mouse/psmouse.o
File: ./drivers/input/mouse/built-in.o
File: ./drivers/input/serio/serio.o
File: ./drivers/input/serio/libps2.o
File: ./drivers/input/serio/i8042.o
File: ./drivers/input/serio/built-in.o
File: ./drivers/input/mousedev.o
File: ./drivers/input/input-leds.o
File: ./drivers/input/evdev.o
File: ./drivers/input/input-compat.o
File: ./drivers/input/input.o
File: ./drivers/input/input-mt.o
File: ./drivers/input/ff-core.o
File: ./drivers/input/input-core.o
File: ./drivers/input/built-in.o
File: ./drivers/input/evdev.mod.o
File: ./drivers/input/input-leds.mod.o
File: ./drivers/irqchip/built-in.o
File: ./drivers/irqchip/irqchip.o
File: ./drivers/leds/led-class.mod.o
File: ./drivers/leds/led-core.o
File: ./drivers/leds/led-class.o
File: ./drivers/leds/built-in.o
File: ./drivers/leds/leds-powernv.o
File: ./drivers/leds/leds-powernv.mod.o
File: ./drivers/md/persistent-data/dm-array.o
File: ./drivers/md/persistent-data/dm-space-map-disk.o
File: ./drivers/md/persistent-data/dm-bitset.o
File: ./drivers/md/persistent-data/dm-block-manager.o
File: ./drivers/md/persistent-data/dm-space-map-common.o
File: ./drivers/md/persistent-data/dm-space-map-metadata.o
File: ./drivers/md/persistent-data/dm-transaction-manager.o
File: ./drivers/md/persistent-data/dm-btree.o
File: ./drivers/md/persistent-data/dm-persistent-data.o
File: ./drivers/md/persistent-data/dm-btree-remove.o
File: ./drivers/md/persistent-data/dm-persistent-data.mod.o
File: ./drivers/md/persistent-data/dm-btree-spine.o
File: ./drivers/md/raid10.o
  [10] __jump_table      PROGBITS        0000000000000000 00ab28 000060 18 WAM  0   0  1
File: ./drivers/md/linear.o
  [12] __jump_table      PROGBITS        0000000000000000 000bf4 000018 18 WAM  0   0  1
File: ./drivers/md/bitmap.o
File: ./drivers/md/dm-uevent.o
File: ./drivers/md/raid0.o
  [12] __jump_table      PROGBITS        0000000000000000 00162c 000018 18 WAM  0   0  1
File: ./drivers/md/md.o
File: ./drivers/md/raid1.o
  [12] __jump_table      PROGBITS        0000000000000000 0080a4 000060 18 WAM  0   0  1
File: ./drivers/md/dm.o
  [55] __jump_table      PROGBITS        0000000000000000 0059a8 000030 18 WAM  0   0  1
File: ./drivers/md/raid5.o
  [21] __jump_table      PROGBITS        0000000000000000 014af0 0000c0 18 WAM  0   0  1
File: ./drivers/md/dm-path-selector.o
File: ./drivers/md/dm-table.o
File: ./drivers/md/dm-sysfs.o
File: ./drivers/md/md-mod.o
File: ./drivers/md/dm-region-hash.o
File: ./drivers/md/dm-target.o
File: ./drivers/md/dm-linear.o
File: ./drivers/md/multipath.o
File: ./drivers/md/dm-rq.o
  [20] __jump_table      PROGBITS        0000000000000000 001a70 000018 18 WAM  0   0  1
File: ./drivers/md/dm-stripe.o
File: ./drivers/md/dm-io.o
File: ./drivers/md/dm-builtin.o
File: ./drivers/md/dm-stats.o
File: ./drivers/md/dm-bufio.o
File: ./drivers/md/dm-ioctl.o
File: ./drivers/md/dm-kcopyd.o
File: ./drivers/md/faulty.o
File: ./drivers/md/dm-zero.mod.o
File: ./drivers/md/multipath.mod.o
File: ./drivers/md/raid5-cache.o
File: ./drivers/md/dm-multipath.mod.o
File: ./drivers/md/dm-bio-prison.o
File: ./drivers/md/dm-queue-length.mod.o
File: ./drivers/md/dm-crypt.o
File: ./drivers/md/dm-service-time.mod.o
File: ./drivers/md/dm-multipath.o
File: ./drivers/md/dm-exception-store.o
File: ./drivers/md/dm-mpath.o
File: ./drivers/md/dm-round-robin.o
File: ./drivers/md/dm-bufio.mod.o
File: ./drivers/md/faulty.mod.o
File: ./drivers/md/dm-queue-length.o
File: ./drivers/md/dm-log.mod.o
File: ./drivers/md/dm-service-time.o
File: ./drivers/md/dm-round-robin.mod.o
File: ./drivers/md/dm-snap.o
File: ./drivers/md/raid10.mod.o
File: ./drivers/md/dm-snapshot.o
File: ./drivers/md/dm-snap-transient.o
File: ./drivers/md/dm-snapshot.mod.o
File: ./drivers/md/dm-snap-persistent.o
File: ./drivers/md/dm-region-hash.mod.o
File: ./drivers/md/dm-raid1.o
File: ./drivers/md/raid456.mod.o
File: ./drivers/md/dm-log.o
File: ./drivers/md/dm-mirror.o
File: ./drivers/md/dm-crypt.mod.o
File: ./drivers/md/dm-mod.o
  [119] __jump_table      PROGBITS        0000000000000000 0175f8 000048 18 WAM  0   0  1
File: ./drivers/md/raid456.o
  [19] __jump_table      PROGBITS        0000000000000000 018670 0000c0 18 WAM  0   0  1
File: ./drivers/md/dm-thin-pool.o
File: ./drivers/md/dm-zero.o
File: ./drivers/md/dm-thin.o
File: ./drivers/md/dm-thin-pool.mod.o
File: ./drivers/md/dm-thin-metadata.o
File: ./drivers/md/built-in.o
  [229] __jump_table      PROGBITS        0000000000000000 03f030 0000d8 18 WAM  0   0  1
File: ./drivers/md/dm-bio-prison.mod.o
File: ./drivers/md/dm-mirror.mod.o
File: ./drivers/media/common/built-in.o
File: ./drivers/media/i2c/built-in.o
File: ./drivers/media/mmc/built-in.o
File: ./drivers/media/pci/built-in.o
File: ./drivers/media/platform/built-in.o
File: ./drivers/media/rc/built-in.o
File: ./drivers/media/usb/built-in.o
File: ./drivers/media/built-in.o
File: ./drivers/misc/cxl/base.o
  [34] __jump_table      PROGBITS        0000000000000000 0009af 000018 18 WAM  0   0  1
File: ./drivers/misc/cxl/built-in.o
  [33] __jump_table      PROGBITS        0000000000000000 0009af 000018 18 WAM  0   0  1
File: ./drivers/misc/cxl/cxl.mod.o
File: ./drivers/misc/cxl/main.o
  [ 8] __jump_table      PROGBITS        0000000000000000 000db0 000078 18 WAM  0   0  1
File: ./drivers/misc/cxl/file.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0014a8 000030 18 WAM  0   0  1
File: ./drivers/misc/cxl/irq.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0011b8 0000a8 18 WAM  0   0  1
File: ./drivers/misc/cxl/fault.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000c10 0000c0 18 WAM  0   0  1
File: ./drivers/misc/cxl/native.o
  [ 7] __jump_table      PROGBITS        0000000000000000 004e44 000df8 18 WAM  0   0  1
File: ./drivers/misc/cxl/context.o
  [ 8] __jump_table      PROGBITS        0000000000000000 000ac8 000018 18 WAM  0   0  1
File: ./drivers/misc/cxl/sysfs.o
  [ 8] __jump_table      PROGBITS        0000000000000000 001f88 000018 18 WAM  0   0  1
File: ./drivers/misc/cxl/pci.o
  [15] __jump_table      PROGBITS        0000000000000000 005538 0005d0 18 WAM  0   0  1
File: ./drivers/misc/cxl/trace.o
File: ./drivers/misc/cxl/vphb.o
File: ./drivers/misc/cxl/phb.o
File: ./drivers/misc/cxl/api.o
  [75] __jump_table      PROGBITS        0000000000000000 001a65 000030 18 WAM  0   0  1
File: ./drivers/misc/cxl/cxl.o
  [86] __jump_table      PROGBITS        0000000000000000 022eb8 0018c0 18 WAM  0   0  1
File: ./drivers/misc/cxl/flash.o
File: ./drivers/misc/cxl/guest.o
  [ 9] __jump_table      PROGBITS        0000000000000000 002b64 000060 18 WAM  0   0  1
File: ./drivers/misc/cxl/of.o
File: ./drivers/misc/cxl/hcalls.o
  [ 8] __jump_table      PROGBITS        0000000000000000 001e48 0000a8 18 WAM  0   0  1
File: ./drivers/misc/cxl/debugfs.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000900 000180 18 WAM  0   0  1
File: ./drivers/misc/mic/built-in.o
File: ./drivers/misc/built-in.o
  [33] __jump_table      PROGBITS        0000000000000000 0009af 000018 18 WAM  0   0  1
File: ./drivers/net/bonding/bond_main.o
File: ./drivers/net/bonding/bond_3ad.o
File: ./drivers/net/bonding/bond_alb.o
File: ./drivers/net/bonding/bond_sysfs.o
File: ./drivers/net/bonding/bond_sysfs_slave.o
File: ./drivers/net/bonding/bond_debugfs.o
File: ./drivers/net/bonding/bond_netlink.o
File: ./drivers/net/bonding/bond_options.o
File: ./drivers/net/bonding/bond_procfs.o
File: ./drivers/net/bonding/bonding.o
File: ./drivers/net/bonding/bonding.mod.o
File: ./drivers/net/ethernet/3com/3c59x.o
File: ./drivers/net/ethernet/3com/3c59x.mod.o
File: ./drivers/net/ethernet/alteon/acenic.o
File: ./drivers/net/ethernet/alteon/acenic.mod.o
File: ./drivers/net/ethernet/amd/pcnet32.o
File: ./drivers/net/ethernet/amd/pcnet32.mod.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x.o
File: ./drivers/net/ethernet/broadcom/bnx2x/bnx2x.mod.o
File: ./drivers/net/ethernet/broadcom/tg3.o
File: ./drivers/net/ethernet/broadcom/bnx2.o
File: ./drivers/net/ethernet/broadcom/cnic.o
File: ./drivers/net/ethernet/broadcom/built-in.o
File: ./drivers/net/ethernet/broadcom/bnx2.mod.o
File: ./drivers/net/ethernet/broadcom/cnic.mod.o
File: ./drivers/net/ethernet/cavium/built-in.o
File: ./drivers/net/ethernet/chelsio/cxgb/cxgb2.o
File: ./drivers/net/ethernet/chelsio/cxgb/espi.o
File: ./drivers/net/ethernet/chelsio/cxgb/tp.o
File: ./drivers/net/ethernet/chelsio/cxgb/pm3393.o
File: ./drivers/net/ethernet/chelsio/cxgb/sge.o
File: ./drivers/net/ethernet/chelsio/cxgb/subr.o
File: ./drivers/net/ethernet/chelsio/cxgb/mv88x201x.o
File: ./drivers/net/ethernet/chelsio/cxgb/my3126.o
File: ./drivers/net/ethernet/chelsio/cxgb/cxgb.o
File: ./drivers/net/ethernet/chelsio/cxgb/cxgb.mod.o
File: ./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.o
File: ./drivers/net/ethernet/chelsio/cxgb3/ael1002.o
File: ./drivers/net/ethernet/chelsio/cxgb3/vsc8211.o
File: ./drivers/net/ethernet/chelsio/cxgb3/t3_hw.o
File: ./drivers/net/ethernet/chelsio/cxgb3/mc5.o
File: ./drivers/net/ethernet/chelsio/cxgb3/xgmac.o
File: ./drivers/net/ethernet/chelsio/cxgb3/sge.o
File: ./drivers/net/ethernet/chelsio/cxgb3/aq100x.o
File: ./drivers/net/ethernet/chelsio/cxgb3/l2t.o
File: ./drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.o
File: ./drivers/net/ethernet/chelsio/cxgb3/cxgb3.o
File: ./drivers/net/ethernet/chelsio/cxgb3/cxgb3.mod.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4.o
File: ./drivers/net/ethernet/chelsio/cxgb4/t4_hw.o
File: ./drivers/net/ethernet/chelsio/cxgb4/sge.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4.mod.o
File: ./drivers/net/ethernet/chelsio/cxgb4/clip_tbl.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.o
File: ./drivers/net/ethernet/chelsio/cxgb4/sched.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.o
File: ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.o
File: ./drivers/net/ethernet/chelsio/cxgb4/l2t.o
File: ./drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.o
File: ./drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.o
File: ./drivers/net/ethernet/chelsio/libcxgb/libcxgb.o
File: ./drivers/net/ethernet/chelsio/libcxgb/libcxgb.mod.o
File: ./drivers/net/ethernet/emulex/benet/be_main.o
File: ./drivers/net/ethernet/emulex/benet/be_ethtool.o
File: ./drivers/net/ethernet/emulex/benet/be_roce.o
File: ./drivers/net/ethernet/emulex/benet/be_cmds.o
File: ./drivers/net/ethernet/emulex/benet/be2net.o
File: ./drivers/net/ethernet/emulex/benet/be2net.mod.o
File: ./drivers/net/ethernet/ibm/ibmveth.o
File: ./drivers/net/ethernet/ibm/built-in.o
File: ./drivers/net/ethernet/intel/e1000/e1000_main.o
File: ./drivers/net/ethernet/intel/e1000/e1000_hw.o
File: ./drivers/net/ethernet/intel/e1000/e1000_ethtool.o
File: ./drivers/net/ethernet/intel/e1000/e1000_param.o
File: ./drivers/net/ethernet/intel/e1000/e1000.o
File: ./drivers/net/ethernet/intel/e1000/built-in.o
File: ./drivers/net/ethernet/intel/e1000e/82571.o
File: ./drivers/net/ethernet/intel/e1000e/ich8lan.o
File: ./drivers/net/ethernet/intel/e1000e/80003es2lan.o
File: ./drivers/net/ethernet/intel/e1000e/mac.o
File: ./drivers/net/ethernet/intel/e1000e/manage.o
File: ./drivers/net/ethernet/intel/e1000e/nvm.o
File: ./drivers/net/ethernet/intel/e1000e/phy.o
File: ./drivers/net/ethernet/intel/e1000e/param.o
File: ./drivers/net/ethernet/intel/e1000e/ethtool.o
File: ./drivers/net/ethernet/intel/e1000e/netdev.o
File: ./drivers/net/ethernet/intel/e1000e/ptp.o
File: ./drivers/net/ethernet/intel/e1000e/e1000e.o
File: ./drivers/net/ethernet/intel/e1000e/built-in.o
File: ./drivers/net/ethernet/intel/i40e/i40e_main.o
File: ./drivers/net/ethernet/intel/i40e/i40e_ethtool.o
File: ./drivers/net/ethernet/intel/i40e/i40e.mod.o
File: ./drivers/net/ethernet/intel/i40e/i40e_adminq.o
File: ./drivers/net/ethernet/intel/i40e/i40e_client.o
File: ./drivers/net/ethernet/intel/i40e/i40e_common.o
File: ./drivers/net/ethernet/intel/i40e/i40e_hmc.o
File: ./drivers/net/ethernet/intel/i40e/i40e.o
File: ./drivers/net/ethernet/intel/i40e/i40e_lan_hmc.o
File: ./drivers/net/ethernet/intel/i40e/i40e_nvm.o
File: ./drivers/net/ethernet/intel/i40e/i40e_debugfs.o
File: ./drivers/net/ethernet/intel/i40e/i40e_diag.o
File: ./drivers/net/ethernet/intel/i40e/i40e_txrx.o
File: ./drivers/net/ethernet/intel/i40e/i40e_ptp.o
File: ./drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb_main.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb_hw.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb_ee.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb_ethtool.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb_param.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb.o
File: ./drivers/net/ethernet/intel/ixgb/ixgb.mod.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_main.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe.mod.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_82598.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_82599.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_phy.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_x540.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_x550.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_lib.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.o
File: ./drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.o
File: ./drivers/net/ethernet/intel/e100.o
File: ./drivers/net/ethernet/intel/built-in.o
File: ./drivers/net/ethernet/mellanox/mlx4/reset.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_clock.o
File: ./drivers/net/ethernet/mellanox/mlx4/alloc.o
File: ./drivers/net/ethernet/mellanox/mlx4/profile.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_selftest.o
File: ./drivers/net/ethernet/mellanox/mlx4/catas.o
File: ./drivers/net/ethernet/mellanox/mlx4/cq.o
File: ./drivers/net/ethernet/mellanox/mlx4/fw_qos.o
File: ./drivers/net/ethernet/mellanox/mlx4/cmd.o
File: ./drivers/net/ethernet/mellanox/mlx4/qp.o
File: ./drivers/net/ethernet/mellanox/mlx4/eq.o
File: ./drivers/net/ethernet/mellanox/mlx4/fw.o
File: ./drivers/net/ethernet/mellanox/mlx4/mlx4_core.o
File: ./drivers/net/ethernet/mellanox/mlx4/port.o
File: ./drivers/net/ethernet/mellanox/mlx4/icm.o
File: ./drivers/net/ethernet/mellanox/mlx4/sense.o
File: ./drivers/net/ethernet/mellanox/mlx4/intf.o
File: ./drivers/net/ethernet/mellanox/mlx4/mlx4_core.mod.o
File: ./drivers/net/ethernet/mellanox/mlx4/main.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_port.o
File: ./drivers/net/ethernet/mellanox/mlx4/mcg.o
File: ./drivers/net/ethernet/mellanox/mlx4/mr.o
File: ./drivers/net/ethernet/mellanox/mlx4/pd.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_cq.o
File: ./drivers/net/ethernet/mellanox/mlx4/mlx4_en.o
  [17] __jump_table      PROGBITS        0000000000000000 019d71 000030 18 WAM  0   0  1
File: ./drivers/net/ethernet/mellanox/mlx4/mlx4_en.mod.o
File: ./drivers/net/ethernet/mellanox/mlx4/srq.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_rx.o
  [10] __jump_table      PROGBITS        0000000000000000 003b50 000030 18 WAM  0   0  1
File: ./drivers/net/ethernet/mellanox/mlx4/en_resources.o
File: ./drivers/net/ethernet/mellanox/mlx4/resource_tracker.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_ethtool.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_netdev.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_main.o
File: ./drivers/net/ethernet/mellanox/mlx4/en_tx.o
File: ./drivers/net/ethernet/myricom/myri10ge/myri10ge.o
File: ./drivers/net/ethernet/myricom/myri10ge/myri10ge.mod.o
File: ./drivers/net/ethernet/neterion/s2io.o
File: ./drivers/net/ethernet/neterion/s2io.mod.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic_init.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic_main.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic.o
File: ./drivers/net/ethernet/qlogic/netxen/netxen_nic.mod.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge_dbg.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge_mpi.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge_main.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge_ethtool.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge.o
File: ./drivers/net/ethernet/qlogic/qlge/qlge.mod.o
File: ./drivers/net/ethernet/qualcomm/built-in.o
File: ./drivers/net/ethernet/built-in.o
File: ./drivers/net/phy/mdio_device.o
File: ./drivers/net/phy/phy.o
File: ./drivers/net/phy/libphy.o
  [320] __jump_table      PROGBITS        0000000000000000 009710 000060 18 WAM  0   0  1
File: ./drivers/net/phy/phy_device.o
File: ./drivers/net/phy/built-in.o
  [330] __jump_table      PROGBITS        0000000000000000 00a218 000060 18 WAM  0   0  1
File: ./drivers/net/phy/mdio_bus.o
  [50] __jump_table      PROGBITS        0000000000000000 001dc8 000060 18 WAM  0   0  1
File: ./drivers/net/phy/swphy.o
File: ./drivers/net/phy/mdio-boardinfo.o
File: ./drivers/net/phy/fixed_phy.o
File: ./drivers/net/ppp/ppp_async.o
File: ./drivers/net/ppp/pppox.o
File: ./drivers/net/ppp/bsd_comp.o
File: ./drivers/net/ppp/ppp_deflate.o
File: ./drivers/net/ppp/ppp_synctty.o
File: ./drivers/net/ppp/ppp_deflate.mod.o
File: ./drivers/net/ppp/pppoe.o
File: ./drivers/net/ppp/ppp_generic.mod.o
File: ./drivers/net/ppp/ppp_synctty.mod.o
File: ./drivers/net/ppp/pppoe.mod.o
File: ./drivers/net/ppp/pppox.mod.o
File: ./drivers/net/ppp/ppp_generic.o
File: ./drivers/net/ppp/bsd_comp.mod.o
File: ./drivers/net/ppp/ppp_async.mod.o
File: ./drivers/net/slip/slhc.o
File: ./drivers/net/slip/slhc.mod.o
File: ./drivers/net/wireless/built-in.o
File: ./drivers/net/tun.o
  [22] __jump_table      PROGBITS        0000000000000000 005608 000018 18 WAM  0   0  1
File: ./drivers/net/virtio_net.o
  [11] __jump_table      PROGBITS        0000000000000000 0061e8 000060 18 WAM  0   0  1
File: ./drivers/net/dummy.mod.o
File: ./drivers/net/vxlan.mod.o
File: ./drivers/net/mii.o
File: ./drivers/net/Space.o
File: ./drivers/net/loopback.o
File: ./drivers/net/netconsole.o
File: ./drivers/net/dummy.o
File: ./drivers/net/macvtap.o
File: ./drivers/net/macvlan.o
File: ./drivers/net/mdio.o
File: ./drivers/net/built-in.o
  [385] __jump_table      PROGBITS        0000000000000000 09d160 000060 18 WAM  0   0  1
File: ./drivers/net/tap.o
File: ./drivers/net/veth.o
File: ./drivers/net/vxlan.o
  [19] __jump_table      PROGBITS        0000000000000000 006fd0 000018 18 WAM  0   0  1
File: ./drivers/net/tap.mod.o
File: ./drivers/net/macvlan.mod.o
File: ./drivers/net/mdio.mod.o
File: ./drivers/net/macvtap.mod.o
File: ./drivers/net/tun.mod.o
File: ./drivers/net/veth.mod.o
File: ./drivers/net/virtio_net.mod.o
File: ./drivers/nvme/built-in.o
File: ./drivers/of/base.o
File: ./drivers/of/of_pci.o
File: ./drivers/of/dynamic.o
File: ./drivers/of/platform.o
File: ./drivers/of/irq.o
File: ./drivers/of/fdt_address.o
File: ./drivers/of/of_mdio.o
File: ./drivers/of/address.o
File: ./drivers/of/fdt.o
File: ./drivers/of/of_net.o
File: ./drivers/of/of_pci_irq.o
File: ./drivers/of/built-in.o
File: ./drivers/of/of_reserved_mem.o
File: ./drivers/of/device.o
File: ./drivers/oprofile/oprof.o
File: ./drivers/oprofile/cpu_buffer.o
File: ./drivers/oprofile/buffer_sync.o
File: ./drivers/oprofile/event_buffer.o
File: ./drivers/oprofile/oprofile_files.o
File: ./drivers/oprofile/oprofilefs.o
File: ./drivers/oprofile/oprofile_stats.o
File: ./drivers/oprofile/timer_int.o
File: ./drivers/parport/procfs.o
File: ./drivers/parport/ieee1284.o
File: ./drivers/parport/ieee1284_ops.o
File: ./drivers/parport/share.o
File: ./drivers/parport/parport.o
File: ./drivers/parport/parport_pc.o
File: ./drivers/parport/parport.mod.o
File: ./drivers/parport/parport_pc.mod.o
File: ./drivers/pci/hotplug/rpadlpar_io.o
File: ./drivers/pci/hotplug/pci_hotplug_core.o
File: ./drivers/pci/hotplug/pci_hotplug.o
File: ./drivers/pci/hotplug/rpaphp_core.o
File: ./drivers/pci/hotplug/rpaphp_pci.o
File: ./drivers/pci/hotplug/rpaphp_slot.o
File: ./drivers/pci/hotplug/rpaphp.o
File: ./drivers/pci/hotplug/rpadlpar_io.mod.o
File: ./drivers/pci/hotplug/rpaphp.mod.o
File: ./drivers/pci/hotplug/rpadlpar_core.o
File: ./drivers/pci/hotplug/built-in.o
File: ./drivers/pci/hotplug/rpadlpar_sysfs.o
File: ./drivers/pci/probe.o
File: ./drivers/pci/setup-res.o
File: ./drivers/pci/vc.o
File: ./drivers/pci/proc.o
File: ./drivers/pci/quirks.o
File: ./drivers/pci/host-bridge.o
File: ./drivers/pci/remove.o
File: ./drivers/pci/pci.o
File: ./drivers/pci/slot.o
File: ./drivers/pci/setup-bus.o
File: ./drivers/pci/search.o
File: ./drivers/pci/vpd.o
File: ./drivers/pci/pci-sysfs.o
File: ./drivers/pci/hotplug-pci.o
File: ./drivers/pci/rom.o
File: ./drivers/pci/irq.o
File: ./drivers/pci/msi.o
File: ./drivers/pci/built-in.o
File: ./drivers/pci/syscall.o
File: ./drivers/pci/of.o
File: ./drivers/pci/access.o
File: ./drivers/pci/bus.o
File: ./drivers/pci/pci-driver.o
File: ./drivers/pps/sysfs.o
File: ./drivers/pps/pps.o
File: ./drivers/pps/kapi.o
File: ./drivers/pps/pps_core.o
File: ./drivers/pps/built-in.o
File: ./drivers/ptp/ptp_chardev.o
File: ./drivers/ptp/ptp_sysfs.o
File: ./drivers/ptp/ptp_clock.o
File: ./drivers/ptp/ptp.o
File: ./drivers/ptp/built-in.o
File: ./drivers/rtc/hctosys.o
File: ./drivers/rtc/systohc.o
File: ./drivers/rtc/rtc-dev.o
File: ./drivers/rtc/rtc-proc.o
File: ./drivers/rtc/rtc-sysfs.o
File: ./drivers/rtc/rtc-generic.o
File: ./drivers/rtc/rtc-opal.o
File: ./drivers/rtc/rtc-lib.o
File: ./drivers/rtc/class.o
File: ./drivers/rtc/interface.o
File: ./drivers/rtc/rtc-core.o
File: ./drivers/rtc/built-in.o
File: ./drivers/scsi/be2iscsi/be_iscsi.o
File: ./drivers/scsi/be2iscsi/be_main.o
File: ./drivers/scsi/be2iscsi/be_mgmt.o
File: ./drivers/scsi/be2iscsi/be_cmds.o
File: ./drivers/scsi/be2iscsi/be2iscsi.o
File: ./drivers/scsi/be2iscsi/be2iscsi.mod.o
File: ./drivers/scsi/bnx2i/bnx2i_init.o
File: ./drivers/scsi/bnx2i/bnx2i_hwi.o
File: ./drivers/scsi/bnx2i/bnx2i_iscsi.o
File: ./drivers/scsi/bnx2i/bnx2i_sysfs.o
File: ./drivers/scsi/bnx2i/bnx2i.o
File: ./drivers/scsi/bnx2i/bnx2i.mod.o
File: ./drivers/scsi/cxgbi/cxgb3i/cxgb3i.o
File: ./drivers/scsi/cxgbi/cxgb3i/cxgb3i.mod.o
File: ./drivers/scsi/cxgbi/cxgb4i/cxgb4i.o
File: ./drivers/scsi/cxgbi/cxgb4i/cxgb4i.mod.o
File: ./drivers/scsi/cxgbi/libcxgbi.o
File: ./drivers/scsi/cxgbi/libcxgbi.mod.o
File: ./drivers/scsi/cxlflash/main.o
File: ./drivers/scsi/cxlflash/superpipe.o
File: ./drivers/scsi/cxlflash/lunmgt.o
File: ./drivers/scsi/cxlflash/vlun.o
File: ./drivers/scsi/cxlflash/cxlflash.o
File: ./drivers/scsi/cxlflash/cxlflash.mod.o
File: ./drivers/scsi/device_handler/scsi_dh_rdac.o
File: ./drivers/scsi/device_handler/scsi_dh_alua.o
File: ./drivers/scsi/device_handler/scsi_dh_alua.mod.o
File: ./drivers/scsi/device_handler/scsi_dh_rdac.mod.o
File: ./drivers/scsi/scsi_ioctl.o
File: ./drivers/scsi/ibmvscsi/ibmvscsi.o
File: ./drivers/scsi/ibmvscsi/ibmvfc.o
File: ./drivers/scsi/ibmvscsi/built-in.o
File: ./drivers/scsi/ibmvscsi/ibmvfc.mod.o
File: ./drivers/scsi/mpt3sas/mpt3sas_base.o
File: ./drivers/scsi/mpt3sas/mpt3sas_config.o
File: ./drivers/scsi/mpt3sas/mpt3sas_transport.o
File: ./drivers/scsi/mpt3sas/mpt3sas_scsih.o
File: ./drivers/scsi/mpt3sas/mpt3sas_ctl.o
File: ./drivers/scsi/mpt3sas/mpt3sas_trigger_diag.o
File: ./drivers/scsi/mpt3sas/mpt3sas_warpdrive.o
File: ./drivers/scsi/mpt3sas/mpt3sas.o
File: ./drivers/scsi/mpt3sas/mpt3sas.mod.o
File: ./drivers/scsi/qla2xxx/qla_tmpl.o
File: ./drivers/scsi/qla2xxx/qla_target.o
File: ./drivers/scsi/qla2xxx/qla_os.o
File: ./drivers/scsi/qla2xxx/qla2xxx.mod.o
File: ./drivers/scsi/qla2xxx/qla_init.o
File: ./drivers/scsi/qla2xxx/qla_mbx.o
File: ./drivers/scsi/qla2xxx/qla_isr.o
File: ./drivers/scsi/qla2xxx/qla_iocb.o
File: ./drivers/scsi/qla2xxx/qla_gs.o
File: ./drivers/scsi/qla2xxx/qla_dbg.o
File: ./drivers/scsi/qla2xxx/qla_sup.o
File: ./drivers/scsi/qla2xxx/qla_mid.o
File: ./drivers/scsi/qla2xxx/qla_attr.o
File: ./drivers/scsi/qla2xxx/qla_dfs.o
File: ./drivers/scsi/qla2xxx/qla2xxx.o
File: ./drivers/scsi/qla2xxx/qla_bsg.o
File: ./drivers/scsi/qla2xxx/qla_nx.o
File: ./drivers/scsi/qla2xxx/qla_mr.o
File: ./drivers/scsi/qla2xxx/qla_nx2.o
File: ./drivers/scsi/qla4xxx/ql4_os.o
File: ./drivers/scsi/qla4xxx/ql4_init.o
File: ./drivers/scsi/qla4xxx/ql4_mbx.o
File: ./drivers/scsi/qla4xxx/ql4_iocb.o
File: ./drivers/scsi/qla4xxx/ql4_isr.o
File: ./drivers/scsi/qla4xxx/ql4_nx.o
File: ./drivers/scsi/qla4xxx/ql4_nvram.o
File: ./drivers/scsi/qla4xxx/ql4_dbg.o
File: ./drivers/scsi/qla4xxx/ql4_attr.o
File: ./drivers/scsi/qla4xxx/ql4_bsg.o
File: ./drivers/scsi/qla4xxx/ql4_83xx.o
File: ./drivers/scsi/qla4xxx/qla4xxx.o
File: ./drivers/scsi/qla4xxx/qla4xxx.mod.o
File: ./drivers/scsi/sym53c8xx_2/sym_fw.o
File: ./drivers/scsi/sym53c8xx_2/sym_glue.o
File: ./drivers/scsi/sym53c8xx_2/sym_hipd.o
File: ./drivers/scsi/sym53c8xx_2/sym_malloc.o
File: ./drivers/scsi/sym53c8xx_2/sym_nvram.o
File: ./drivers/scsi/sym53c8xx_2/sym53c8xx.o
File: ./drivers/scsi/sym53c8xx_2/sym53c8xx.mod.o
File: ./drivers/scsi/raid_class.o
File: ./drivers/scsi/st.mod.o
File: ./drivers/scsi/scsi_transport_spi.o
File: ./drivers/scsi/scsi.o
File: ./drivers/scsi/scsi_pm.o
File: ./drivers/scsi/sd_mod.o
File: ./drivers/scsi/ipr.o
File: ./drivers/scsi/hosts.o
File: ./drivers/scsi/sd.o
File: ./drivers/scsi/st.o
File: ./drivers/scsi/scsi_trace.o
File: ./drivers/scsi/scsi_transport_fc.o
File: ./drivers/scsi/scsi_sysfs.o
File: ./drivers/scsi/sr.o
File: ./drivers/scsi/scsicam.o
File: ./drivers/scsi/scsi_transport_sas.o
File: ./drivers/scsi/scsi_common.o
File: ./drivers/scsi/scsi_transport_srp.o
File: ./drivers/scsi/scsi_dh.o
File: ./drivers/scsi/built-in.o
  [414] __jump_table      PROGBITS        0000000000000000 06df88 000090 18 WAM  0   0  1
File: ./drivers/scsi/sr_ioctl.o
File: ./drivers/scsi/constants.o
File: ./drivers/scsi/scsi_error.o
  [43] __jump_table      PROGBITS        0000000000000000 0040fe 000030 18 WAM  0   0  1
File: ./drivers/scsi/sg.o
File: ./drivers/scsi/scsi_lib.o
  [68] __jump_table      PROGBITS        0000000000000000 006208 000060 18 WAM  0   0  1
File: ./drivers/scsi/scsi_sysctl.o
File: ./drivers/scsi/sr_vendor.o
File: ./drivers/scsi/scsi_proc.o
File: ./drivers/scsi/sr_mod.o
File: ./drivers/scsi/scsi_lib_dma.o
File: ./drivers/scsi/scsi_scan.o
File: ./drivers/scsi/iscsi_boot_sysfs.o
File: ./drivers/scsi/libiscsi.o
File: ./drivers/scsi/scsi_devinfo.o
File: ./drivers/scsi/scsi_netlink.o
File: ./drivers/scsi/scsi_logging.o
File: ./drivers/scsi/scsi_mod.o
  [358] __jump_table      PROGBITS        0000000000000000 02e1f8 000090 18 WAM  0   0  1
File: ./drivers/scsi/libiscsi_tcp.o
File: ./drivers/scsi/iscsi_boot_sysfs.mod.o
File: ./drivers/scsi/raid_class.mod.o
File: ./drivers/scsi/virtio_scsi.o
File: ./drivers/scsi/scsi_transport_iscsi.o
File: ./drivers/scsi/libiscsi.mod.o
File: ./drivers/scsi/libiscsi_tcp.mod.o
File: ./drivers/scsi/scsi_transport_iscsi.mod.o
File: ./drivers/scsi/scsi_transport_sas.mod.o
File: ./drivers/scsi/scsi_transport_spi.mod.o
File: ./drivers/scsi/virtio_scsi.mod.o
File: ./drivers/soc/built-in.o
File: ./drivers/tty/hvc/hvsi_lib.o
File: ./drivers/tty/hvc/hvc_vio.o
File: ./drivers/tty/hvc/hvc_opal.o
File: ./drivers/tty/hvc/hvc_rtas.o
File: ./drivers/tty/hvc/hvc_irq.o
File: ./drivers/tty/hvc/hvcs.o
File: ./drivers/tty/hvc/hvc_console.o
File: ./drivers/tty/hvc/built-in.o
File: ./drivers/tty/hvc/hvcs.mod.o
File: ./drivers/tty/serial/8250/8250_exar.o
File: ./drivers/tty/serial/8250/8250_early.o
File: ./drivers/tty/serial/8250/8250_core.o
File: ./drivers/tty/serial/8250/8250_port.o
File: ./drivers/tty/serial/8250/8250_pci.o
File: ./drivers/tty/serial/8250/8250.o
File: ./drivers/tty/serial/8250/8250_base.o
File: ./drivers/tty/serial/8250/8250_fsl.o
File: ./drivers/tty/serial/8250/built-in.o
File: ./drivers/tty/serial/jsm/jsm_driver.o
File: ./drivers/tty/serial/jsm/jsm_neo.o
File: ./drivers/tty/serial/jsm/jsm_tty.o
File: ./drivers/tty/serial/jsm/jsm_cls.o
File: ./drivers/tty/serial/jsm/jsm.o
File: ./drivers/tty/serial/jsm/jsm.mod.o
File: ./drivers/tty/serial/earlycon.o
File: ./drivers/tty/serial/icom.o
File: ./drivers/tty/serial/serial_core.o
File: ./drivers/tty/serial/built-in.o
File: ./drivers/tty/serial/icom.mod.o
File: ./drivers/tty/vt/vc_screen.o
File: ./drivers/tty/vt/selection.o
File: ./drivers/tty/vt/consolemap_deftbl.o
File: ./drivers/tty/vt/defkeymap.o
File: ./drivers/tty/vt/vt_ioctl.o
File: ./drivers/tty/vt/keyboard.o
File: ./drivers/tty/vt/consolemap.o
File: ./drivers/tty/vt/vt.o
File: ./drivers/tty/vt/built-in.o
File: ./drivers/tty/tty_io.o
File: ./drivers/tty/tty_ioctl.o
File: ./drivers/tty/n_tty.o
File: ./drivers/tty/tty_ldisc.o
File: ./drivers/tty/tty_port.o
File: ./drivers/tty/built-in.o
File: ./drivers/tty/tty_buffer.o
File: ./drivers/tty/sysrq.o
File: ./drivers/tty/tty_mutex.o
File: ./drivers/tty/tty_ldsem.o
File: ./drivers/tty/pty.o
File: ./drivers/tty/tty_audit.o
File: ./drivers/uio/uio.o
File: ./drivers/uio/uio.mod.o
File: ./drivers/usb/common/common.o
File: ./drivers/usb/common/usb-common.o
File: ./drivers/usb/common/built-in.o
File: ./drivers/usb/core/usb.o
File: ./drivers/usb/core/hub.o
File: ./drivers/usb/core/urb.o
File: ./drivers/usb/core/driver.o
File: ./drivers/usb/core/hcd.o
File: ./drivers/usb/core/usbcore.o
File: ./drivers/usb/core/message.o
File: ./drivers/usb/core/of.o
File: ./drivers/usb/core/port.o
File: ./drivers/usb/core/config.o
File: ./drivers/usb/core/buffer.o
File: ./drivers/usb/core/sysfs.o
File: ./drivers/usb/core/endpoint.o
File: ./drivers/usb/core/devio.o
File: ./drivers/usb/core/notify.o
File: ./drivers/usb/core/hcd-pci.o
File: ./drivers/usb/core/generic.o
File: ./drivers/usb/core/built-in.o
File: ./drivers/usb/core/file.o
File: ./drivers/usb/core/quirks.o
File: ./drivers/usb/core/devices.o
File: ./drivers/usb/host/pci-quirks.o
File: ./drivers/usb/host/ohci-pci.o
File: ./drivers/usb/host/built-in.o
File: ./drivers/usb/host/ehci-pci.o
File: ./drivers/usb/host/ehci-hcd.o
File: ./drivers/usb/host/ohci-hcd.o
File: ./drivers/usb/mon/mon_main.o
File: ./drivers/usb/mon/mon_stat.o
File: ./drivers/usb/mon/mon_text.o
File: ./drivers/usb/mon/mon_bin.o
File: ./drivers/usb/mon/usbmon.o
File: ./drivers/usb/mon/usbmon.mod.o
File: ./drivers/usb/phy/of.o
File: ./drivers/usb/phy/built-in.o
File: ./drivers/usb/storage/protocol.o
File: ./drivers/usb/storage/scsiglue.o
File: ./drivers/usb/storage/transport.o
File: ./drivers/usb/storage/usb.o
File: ./drivers/usb/storage/usb-storage.o
File: ./drivers/usb/storage/initializers.o
File: ./drivers/usb/storage/usb-storage.mod.o
File: ./drivers/usb/storage/sierra_ms.o
File: ./drivers/usb/storage/option_ms.o
File: ./drivers/usb/storage/usual-tables.o
File: ./drivers/usb/built-in.o
File: ./drivers/vhost/net.o
File: ./drivers/vhost/vhost.o
File: ./drivers/vhost/vhost_net.o
File: ./drivers/vhost/vhost.mod.o
File: ./drivers/vhost/vhost_net.mod.o
File: ./drivers/video/backlight/lcd.mod.o
File: ./drivers/video/backlight/generic_bl.o
File: ./drivers/video/backlight/platform_lcd.o
File: ./drivers/video/backlight/backlight.o
File: ./drivers/video/backlight/built-in.o
File: ./drivers/video/backlight/lcd.o
File: ./drivers/video/backlight/platform_lcd.mod.o
File: ./drivers/video/console/fbcon.o
File: ./drivers/video/console/dummycon.o
File: ./drivers/video/console/bitblit.o
File: ./drivers/video/console/softcursor.o
File: ./drivers/video/console/tileblit.o
File: ./drivers/video/console/built-in.o
File: ./drivers/video/fbdev/aty/radeon_base.o
File: ./drivers/video/fbdev/aty/radeon_pm.o
File: ./drivers/video/fbdev/aty/radeon_accel.o
File: ./drivers/video/fbdev/aty/radeon_monitor.o
File: ./drivers/video/fbdev/aty/radeon_i2c.o
File: ./drivers/video/fbdev/aty/radeon_backlight.o
File: ./drivers/video/fbdev/aty/radeonfb.o
File: ./drivers/video/fbdev/aty/built-in.o
File: ./drivers/video/fbdev/core/built-in.o
File: ./drivers/video/fbdev/core/fb_notify.o
File: ./drivers/video/fbdev/core/fbmem.o
File: ./drivers/video/fbdev/core/fbmon.o
File: ./drivers/video/fbdev/core/fbcmap.o
File: ./drivers/video/fbdev/core/fbsysfs.o
File: ./drivers/video/fbdev/core/modedb.o
File: ./drivers/video/fbdev/core/fbcvt.o
File: ./drivers/video/fbdev/core/cfbfillrect.o
File: ./drivers/video/fbdev/core/fb.o
File: ./drivers/video/fbdev/core/cfbcopyarea.o
File: ./drivers/video/fbdev/core/cfbimgblt.o
File: ./drivers/video/fbdev/core/fb_ddc.o
File: ./drivers/video/fbdev/core/fb_cmdline.o
File: ./drivers/video/fbdev/matrox/matroxfb_g450.o
File: ./drivers/video/fbdev/matrox/built-in.o
File: ./drivers/video/fbdev/matrox/matroxfb_misc.o
File: ./drivers/video/fbdev/matrox/g450_pll.o
File: ./drivers/video/fbdev/matrox/matroxfb_crtc2.o
File: ./drivers/video/fbdev/matrox/matroxfb_base.o
File: ./drivers/video/fbdev/matrox/matroxfb_accel.o
File: ./drivers/video/fbdev/matrox/matroxfb_DAC1064.o
File: ./drivers/video/fbdev/matrox/matroxfb_Ti3026.o
File: ./drivers/video/fbdev/omap2/omapfb/built-in.o
File: ./drivers/video/fbdev/omap2/built-in.o
File: ./drivers/video/fbdev/gxt4500.o
File: ./drivers/video/fbdev/offb.o
File: ./drivers/video/fbdev/macmodes.o
File: ./drivers/video/fbdev/built-in.o
File: ./drivers/video/logo/logo_linux_mono.o
File: ./drivers/video/logo/logo_linux_vga16.o
File: ./drivers/video/logo/logo_linux_clut224.o
File: ./drivers/video/logo/logo.o
File: ./drivers/video/logo/built-in.o
File: ./drivers/video/built-in.o
File: ./drivers/virtio/virtio_pci_modern.o
File: ./drivers/virtio/virtio_pci_common.o
File: ./drivers/virtio/virtio_pci_legacy.o
File: ./drivers/virtio/virtio_balloon.o
File: ./drivers/virtio/virtio.o
File: ./drivers/virtio/virtio_ring.o
File: ./drivers/virtio/virtio_pci.o
File: ./drivers/virtio/virtio.mod.o
File: ./drivers/virtio/virtio_balloon.mod.o
File: ./drivers/virtio/virtio_ring.mod.o
File: ./drivers/virtio/virtio_pci.mod.o
File: ./drivers/built-in.o
  [5174] __jump_table      PROGBITS        0000000000000000 3a2030 000d08 18 WAM  0   0  1
File: ./firmware/e100/d101m_ucode.bin.gen.o
File: ./firmware/e100/d101s_ucode.bin.gen.o
File: ./firmware/e100/d102e_ucode.bin.gen.o
File: ./firmware/tigon/tg3.bin.gen.o
File: ./firmware/tigon/tg3_tso.bin.gen.o
File: ./firmware/tigon/tg3_tso5.bin.gen.o
File: ./firmware/built-in.o
File: ./fs/autofs4/init.o
File: ./fs/autofs4/inode.o
File: ./fs/autofs4/root.o
File: ./fs/autofs4/symlink.o
File: ./fs/autofs4/waitq.o
File: ./fs/autofs4/expire.o
File: ./fs/autofs4/dev-ioctl.o
File: ./fs/autofs4/autofs4.o
File: ./fs/autofs4/autofs4.mod.o
File: ./fs/btrfs/transaction.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0051e0 000078 18 WAM  0   0  1
File: ./fs/btrfs/super.o
  [ 9] __jump_table      PROGBITS        0000000000000000 011c30 000018 18 WAM  0   0  1
File: ./fs/btrfs/inode-item.o
File: ./fs/btrfs/async-thread.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000f9c 0000d8 18 WAM  0   0  1
File: ./fs/btrfs/ctree.o
  [ 9] __jump_table      PROGBITS        0000000000000000 00e674 000018 18 WAM  0   0  1
File: ./fs/btrfs/dir-item.o
File: ./fs/btrfs/extent-tree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 018378 0003f0 18 WAM  0   0  1
File: ./fs/btrfs/disk-io.o
  [14] __jump_table      PROGBITS        0000000000000000 009f20 000018 18 WAM  0   0  1
File: ./fs/btrfs/print-tree.o
File: ./fs/btrfs/root-tree.o
File: ./fs/btrfs/file-item.o
File: ./fs/btrfs/inode-map.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0014c8 000030 18 WAM  0   0  1
File: ./fs/btrfs/tree-log.o
File: ./fs/btrfs/inode.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0156a0 000090 18 WAM  0   0  1
File: ./fs/btrfs/zlib.o
File: ./fs/btrfs/ioctl.o
File: ./fs/btrfs/file.o
  [11] __jump_table      PROGBITS        0000000000000000 006a98 000018 18 WAM  0   0  1
File: ./fs/btrfs/locking.o
File: ./fs/btrfs/tree-defrag.o
File: ./fs/btrfs/xattr.o
File: ./fs/btrfs/extent_io.o
  [ 9] __jump_table      PROGBITS        0000000000000000 00c920 000048 18 WAM  0   0  1
File: ./fs/btrfs/extent_map.o
File: ./fs/btrfs/sysfs.o
File: ./fs/btrfs/volumes.o
  [10] __jump_table      PROGBITS        0000000000000000 00ee88 000030 18 WAM  0   0  1
File: ./fs/btrfs/orphan.o
File: ./fs/btrfs/struct-funcs.o
File: ./fs/btrfs/export.o
File: ./fs/btrfs/ordered-data.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002a30 000060 18 WAM  0   0  1
File: ./fs/btrfs/lzo.o
File: ./fs/btrfs/free-space-cache.o
  [11] __jump_table      PROGBITS        0000000000000000 006f98 000060 18 WAM  0   0  1
File: ./fs/btrfs/compression.o
File: ./fs/btrfs/delayed-ref.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0026f0 000048 18 WAM  0   0  1
File: ./fs/btrfs/relocation.o
File: ./fs/btrfs/delayed-inode.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0040f0 000090 18 WAM  0   0  1
File: ./fs/btrfs/scrub.o
File: ./fs/btrfs/reada.o
File: ./fs/btrfs/backref.o
File: ./fs/btrfs/ulist.o
File: ./fs/btrfs/qgroup.o
  [ 9] __jump_table      PROGBITS        0000000000000000 006498 000090 18 WAM  0   0  1
File: ./fs/btrfs/send.o
File: ./fs/btrfs/dev-replace.o
File: ./fs/btrfs/raid56.o
File: ./fs/btrfs/uuid-tree.o
File: ./fs/btrfs/props.o
File: ./fs/btrfs/hash.o
File: ./fs/btrfs/free-space-tree.o
File: ./fs/btrfs/acl.o
File: ./fs/btrfs/btrfs.o
  [24] __jump_table      PROGBITS        0000000000000000 0ff418 000900 18 WAM  0   0  1
File: ./fs/btrfs/btrfs.mod.o
File: ./fs/cifs/sess.o
File: ./fs/cifs/cifsfs.o
File: ./fs/cifs/cifs_unicode.o
File: ./fs/cifs/cifssmb.o
File: ./fs/cifs/asn1.o
File: ./fs/cifs/cifs_debug.o
File: ./fs/cifs/ioctl.o
File: ./fs/cifs/connect.o
File: ./fs/cifs/cifsencrypt.o
File: ./fs/cifs/dir.o
File: ./fs/cifs/file.o
File: ./fs/cifs/readdir.o
File: ./fs/cifs/inode.o
File: ./fs/cifs/link.o
File: ./fs/cifs/nterr.o
File: ./fs/cifs/misc.o
File: ./fs/cifs/netmisc.o
File: ./fs/cifs/smbencrypt.o
File: ./fs/cifs/transport.o
File: ./fs/cifs/export.o
File: ./fs/cifs/smb1ops.o
File: ./fs/cifs/winucase.o
File: ./fs/cifs/xattr.o
File: ./fs/cifs/cifs.mod.o
File: ./fs/cifs/cifs.o
File: ./fs/cramfs/inode.o
File: ./fs/cramfs/uncompress.o
File: ./fs/cramfs/cramfs.o
File: ./fs/cramfs/cramfs.mod.o
File: ./fs/debugfs/inode.o
File: ./fs/debugfs/file.o
File: ./fs/debugfs/debugfs.o
File: ./fs/debugfs/built-in.o
File: ./fs/devpts/inode.o
File: ./fs/devpts/devpts.o
File: ./fs/devpts/built-in.o
File: ./fs/exportfs/expfs.o
File: ./fs/exportfs/exportfs.o
File: ./fs/exportfs/built-in.o
File: ./fs/ext2/balloc.o
File: ./fs/ext2/dir.o
File: ./fs/ext2/file.o
File: ./fs/ext2/ialloc.o
File: ./fs/ext2/inode.o
File: ./fs/ext2/ioctl.o
File: ./fs/ext2/namei.o
File: ./fs/ext2/super.o
File: ./fs/ext2/symlink.o
File: ./fs/ext2/xattr.o
File: ./fs/ext2/xattr_user.o
File: ./fs/ext2/xattr_trusted.o
File: ./fs/ext2/acl.o
File: ./fs/ext2/xattr_security.o
File: ./fs/ext2/ext2.o
File: ./fs/ext2/built-in.o
File: ./fs/ext4/mballoc.o
  [10] __jump_table      PROGBITS        0000000000000000 00b8b8 0001f8 18 WAM  0   0  1
File: ./fs/ext4/balloc.o
  [11] __jump_table      PROGBITS        0000000000000000 001e34 000018 18 WAM  0   0  1
File: ./fs/ext4/block_validity.o
File: ./fs/ext4/bitmap.o
File: ./fs/ext4/mmp.o
File: ./fs/ext4/dir.o
File: ./fs/ext4/indirect.o
  [ 9] __jump_table      PROGBITS        0000000000000000 002960 000048 18 WAM  0   0  1
File: ./fs/ext4/file.o
File: ./fs/ext4/fsync.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000514 000090 18 WAM  0   0  1
File: ./fs/ext4/ialloc.o
  [11] __jump_table      PROGBITS        0000000000000000 003790 000060 18 WAM  0   0  1
File: ./fs/ext4/inode.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00cf74 0002d0 18 WAM  0   0  1
File: ./fs/ext4/page-io.o
File: ./fs/ext4/ioctl.o
File: ./fs/ext4/extents_status.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0022b8 000108 18 WAM  0   0  1
File: ./fs/ext4/namei.o
  [11] __jump_table      PROGBITS        0000000000000000 008504 000060 18 WAM  0   0  1
File: ./fs/ext4/super.o
  [ 8] __jump_table      PROGBITS        0000000000000000 01dac0 000030 18 WAM  0   0  1
File: ./fs/ext4/symlink.o
File: ./fs/ext4/xattr.o
File: ./fs/ext4/hash.o
File: ./fs/ext4/resize.o
File: ./fs/ext4/move_extent.o
File: ./fs/ext4/extents.o
  [ 9] __jump_table      PROGBITS        0000000000000000 00ae48 000210 18 WAM  0   0  1
File: ./fs/ext4/ext4_jbd2.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000e98 000048 18 WAM  0   0  1
File: ./fs/ext4/migrate.o
File: ./fs/ext4/built-in.o
  [23] __jump_table      PROGBITS        0000000000000000 0805e8 000a08 18 WAM  0   0  1
File: ./fs/ext4/xattr_user.o
File: ./fs/ext4/sysfs.o
File: ./fs/ext4/xattr_security.o
File: ./fs/ext4/xattr_trusted.o
File: ./fs/ext4/acl.o
File: ./fs/ext4/inline.o
File: ./fs/ext4/readpage.o
File: ./fs/ext4/ext4.o
  [23] __jump_table      PROGBITS        0000000000000000 0805e8 000a08 18 WAM  0   0  1
File: ./fs/fat/cache.o
File: ./fs/fat/nfs.o
File: ./fs/fat/namei_msdos.o
File: ./fs/fat/namei_vfat.o
File: ./fs/fat/dir.o
File: ./fs/fat/fatent.o
File: ./fs/fat/file.o
File: ./fs/fat/inode.o
File: ./fs/fat/misc.o
File: ./fs/fat/fat.o
File: ./fs/fat/msdos.o
File: ./fs/fat/built-in.o
File: ./fs/fat/vfat.o
File: ./fs/fat/vfat.mod.o
File: ./fs/fuse/dir.o
File: ./fs/fuse/control.o
File: ./fs/fuse/xattr.o
File: ./fs/fuse/acl.o
File: ./fs/fuse/dev.o
File: ./fs/fuse/file.o
File: ./fs/fuse/inode.o
File: ./fs/fuse/fuse.o
File: ./fs/fuse/fuse.mod.o
File: ./fs/hugetlbfs/inode.o
File: ./fs/hugetlbfs/hugetlbfs.o
File: ./fs/hugetlbfs/built-in.o
File: ./fs/isofs/namei.o
File: ./fs/isofs/inode.o
File: ./fs/isofs/dir.o
File: ./fs/isofs/util.o
File: ./fs/isofs/rock.o
File: ./fs/isofs/export.o
File: ./fs/isofs/isofs.o
File: ./fs/isofs/isofs.mod.o
File: ./fs/jbd2/commit.o
  [11] __jump_table      PROGBITS        0000000000000000 0026c0 0000a8 18 WAM  0   0  1
File: ./fs/jbd2/recovery.o
File: ./fs/jbd2/checkpoint.o
  [ 9] __jump_table      PROGBITS        0000000000000000 00127c 000048 18 WAM  0   0  1
File: ./fs/jbd2/revoke.o
File: ./fs/jbd2/transaction.o
  [27] __jump_table      PROGBITS        0000000000000000 00509d 000060 18 WAM  0   0  1
File: ./fs/jbd2/journal.o
  [106] __jump_table      PROGBITS        0000000000000000 00a270 000030 18 WAM  0   0  1
File: ./fs/jbd2/jbd2.o
  [116] __jump_table      PROGBITS        0000000000000000 015748 000180 18 WAM  0   0  1
File: ./fs/jbd2/built-in.o
  [116] __jump_table      PROGBITS        0000000000000000 015748 000180 18 WAM  0   0  1
File: ./fs/jfs/jfs_uniupr.o
File: ./fs/jfs/super.o
File: ./fs/jfs/jfs_txnmgr.o
File: ./fs/jfs/file.o
File: ./fs/jfs/jfs.mod.o
File: ./fs/jfs/inode.o
File: ./fs/jfs/namei.o
File: ./fs/jfs/symlink.o
File: ./fs/jfs/jfs_mount.o
File: ./fs/jfs/jfs_extent.o
File: ./fs/jfs/jfs_umount.o
File: ./fs/jfs/jfs_metapage.o
File: ./fs/jfs/jfs_xtree.o
File: ./fs/jfs/jfs_imap.o
File: ./fs/jfs/jfs_debug.o
File: ./fs/jfs/jfs_dmap.o
File: ./fs/jfs/jfs_unicode.o
File: ./fs/jfs/jfs_dtree.o
File: ./fs/jfs/jfs_logmgr.o
File: ./fs/jfs/jfs_inode.o
File: ./fs/jfs/jfs_discard.o
File: ./fs/jfs/resize.o
File: ./fs/jfs/xattr.o
File: ./fs/jfs/ioctl.o
File: ./fs/jfs/acl.o
File: ./fs/jfs/jfs.o
File: ./fs/kernfs/mount.o
File: ./fs/kernfs/inode.o
File: ./fs/kernfs/symlink.o
File: ./fs/kernfs/dir.o
File: ./fs/kernfs/file.o
File: ./fs/kernfs/built-in.o
File: ./fs/lockd/svcsubs.o
File: ./fs/lockd/svc.o
File: ./fs/lockd/built-in.o
File: ./fs/lockd/clntxdr.o
File: ./fs/lockd/host.o
File: ./fs/lockd/lockd.o
File: ./fs/lockd/svclock.o
File: ./fs/lockd/svcshare.o
File: ./fs/lockd/svcproc.o
File: ./fs/lockd/mon.o
File: ./fs/lockd/xdr.o
File: ./fs/lockd/clnt4xdr.o
File: ./fs/lockd/xdr4.o
File: ./fs/lockd/svc4proc.o
File: ./fs/lockd/procfs.o
File: ./fs/lockd/clntlock.o
File: ./fs/lockd/clntproc.o
File: ./fs/nfs/nfs4proc.o
  [19] __jump_table      PROGBITS        0000000000000000 00dbc0 000318 18 WAM  0   0  1
File: ./fs/nfs/nfs2super.o
File: ./fs/nfs/nfs3acl.o
File: ./fs/nfs/inode.o
  [77] __jump_table      PROGBITS        0000000000000000 004a73 0000f0 18 WAM  0   0  1
File: ./fs/nfs/client.o
File: ./fs/nfs/direct.o
File: ./fs/nfs/nfs4state.o
File: ./fs/nfs/delegation.o
  [11] __jump_table      PROGBITS        0000000000000000 0021ec 000030 18 WAM  0   0  1
File: ./fs/nfs/nfs4renewd.o
File: ./fs/nfs/dir.o
  [51] __jump_table      PROGBITS        0000000000000000 005cc8 0002a0 18 WAM  0   0  1
File: ./fs/nfs/nfsv4.o
  [38] __jump_table      PROGBITS        0000000000000000 04b020 000438 18 WAM  0   0  1
File: ./fs/nfs/nfs3xdr.o
File: ./fs/nfs/file.o
  [33] __jump_table      PROGBITS        0000000000000000 001ed6 000030 18 WAM  0   0  1
File: ./fs/nfs/read.o
File: ./fs/nfs/getroot.o
File: ./fs/nfs/pagelist.o
File: ./fs/nfs/nfs3client.o
File: ./fs/nfs/nfs4idmap.o
  [14] __jump_table      PROGBITS        0000000000000000 0017ea 000060 18 WAM  0   0  1
File: ./fs/nfs/super.o
File: ./fs/nfs/write.o
  [50] __jump_table      PROGBITS        0000000000000000 0049e7 000060 18 WAM  0   0  1
File: ./fs/nfs/nfs2xdr.o
File: ./fs/nfs/nfs4super.o
File: ./fs/nfs/io.o
File: ./fs/nfs/nfsv3.o
File: ./fs/nfs/symlink.o
File: ./fs/nfs/unlink.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001074 000030 18 WAM  0   0  1
File: ./fs/nfs/nfs4file.o
File: ./fs/nfs/nfs3super.o
File: ./fs/nfs/nfs.o
  [353] __jump_table      PROGBITS        0000000000000000 02c890 000450 18 WAM  0   0  1
File: ./fs/nfs/sysctl.o
File: ./fs/nfs/nfsv2.o
File: ./fs/nfs/nfs4client.o
File: ./fs/nfs/nfstrace.o
File: ./fs/nfs/namespace.o
File: ./fs/nfs/built-in.o
  [377] __jump_table      PROGBITS        0000000000000000 0839b0 000888 18 WAM  0   0  1
File: ./fs/nfs/proc.o
File: ./fs/nfs/nfs3proc.o
File: ./fs/nfs/mount_clnt.o
File: ./fs/nfs/nfs4xdr.o
File: ./fs/nfs/callback.o
File: ./fs/nfs/callback_xdr.o
File: ./fs/nfs/callback_proc.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000538 000090 18 WAM  0   0  1
File: ./fs/nfs/nfs4namespace.o
File: ./fs/nfs/nfs4getroot.o
File: ./fs/nfs/nfs4session.o
File: ./fs/nfs/dns_resolve.o
File: ./fs/nfs/nfs4trace.o
File: ./fs/nfs/nfs4sysctl.o
File: ./fs/nfs_common/nfsacl.o
File: ./fs/nfs_common/nfs_acl.o
File: ./fs/nfs_common/grace.o
File: ./fs/nfs_common/built-in.o
File: ./fs/nfsd/nfs4xdr.o
File: ./fs/nfsd/trace.o
File: ./fs/nfsd/nfs3xdr.o
File: ./fs/nfsd/nfssvc.o
File: ./fs/nfsd/nfsctl.o
File: ./fs/nfsd/nfsproc.o
File: ./fs/nfsd/nfs4state.o
File: ./fs/nfsd/nfsfh.o
File: ./fs/nfsd/vfs.o
  [10] __jump_table      PROGBITS        0000000000000000 004bd0 0000c0 18 WAM  0   0  1
File: ./fs/nfsd/nfs3acl.o
File: ./fs/nfsd/export.o
File: ./fs/nfsd/auth.o
File: ./fs/nfsd/lockd.o
File: ./fs/nfsd/nfs3proc.o
File: ./fs/nfsd/nfscache.o
File: ./fs/nfsd/nfsxdr.o
File: ./fs/nfsd/stats.o
File: ./fs/nfsd/nfs4proc.o
File: ./fs/nfsd/nfs2acl.o
File: ./fs/nfsd/nfs4idmap.o
File: ./fs/nfsd/nfsd.o
  [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0 18 WAM  0   0  1
File: ./fs/nfsd/nfs4acl.o
File: ./fs/nfsd/nfs4callback.o
File: ./fs/nfsd/nfs4recover.o
File: ./fs/nfsd/nfsd.mod.o
File: ./fs/nilfs2/gcinode.o
File: ./fs/nilfs2/inode.o
File: ./fs/nilfs2/alloc.o
File: ./fs/nilfs2/file.o
File: ./fs/nilfs2/ioctl.o
File: ./fs/nilfs2/dir.o
File: ./fs/nilfs2/super.o
File: ./fs/nilfs2/namei.o
File: ./fs/nilfs2/page.o
File: ./fs/nilfs2/mdt.o
  [ 9] __jump_table      PROGBITS        0000000000000000 001760 000030 18 WAM  0   0  1
File: ./fs/nilfs2/sufile.o
  [ 9] __jump_table      PROGBITS        0000000000000000 002d64 000078 18 WAM  0   0  1
File: ./fs/nilfs2/btnode.o
File: ./fs/nilfs2/bmap.o
File: ./fs/nilfs2/btree.o
File: ./fs/nilfs2/direct.o
File: ./fs/nilfs2/dat.o
File: ./fs/nilfs2/cpfile.o
File: ./fs/nilfs2/recovery.o
File: ./fs/nilfs2/the_nilfs.o
File: ./fs/nilfs2/segbuf.o
File: ./fs/nilfs2/ifile.o
File: ./fs/nilfs2/segment.o
  [12] __jump_table      PROGBITS        0000000000000000 008228 000240 18 WAM  0   0  1
File: ./fs/nilfs2/sysfs.o
File: ./fs/nilfs2/nilfs2.o
  [28] __jump_table      PROGBITS        0000000000000000 0308a8 0002e8 18 WAM  0   0  1
File: ./fs/nilfs2/nilfs2.mod.o
File: ./fs/nls/nls_cp437.o
File: ./fs/nls/nls_ascii.o
File: ./fs/nls/nls_iso8859-1.o
File: ./fs/nls/nls_utf8.o
File: ./fs/nls/nls_base.o
File: ./fs/nls/built-in.o
File: ./fs/notify/dnotify/dnotify.o
File: ./fs/notify/dnotify/built-in.o
File: ./fs/notify/inotify/inotify_fsnotify.o
File: ./fs/notify/inotify/inotify_user.o
File: ./fs/notify/inotify/built-in.o
File: ./fs/notify/group.o
File: ./fs/notify/inode_mark.o
File: ./fs/notify/mark.o
File: ./fs/notify/vfsmount_mark.o
File: ./fs/notify/fdinfo.o
File: ./fs/notify/fsnotify.o
File: ./fs/notify/notification.o
[  312.696198] kworker/dying (102) used greatest stack depth: 9472 bytes left
File: ./fs/notify/built-in.o
File: ./fs/overlayfs/super.o
File: ./fs/overlayfs/namei.o
File: ./fs/overlayfs/util.o
File: ./fs/overlayfs/inode.o
File: ./fs/overlayfs/dir.o
File: ./fs/overlayfs/readdir.o
File: ./fs/overlayfs/copy_up.o
File: ./fs/overlayfs/overlay.o
File: ./fs/overlayfs/overlay.mod.o
File: ./fs/proc/task_mmu.o
  [ 7] __jump_table      PROGBITS        0000000000000000 003f5c 0001c8 18 WAM  0   0  1
File: ./fs/proc/inode.o
File: ./fs/proc/root.o
File: ./fs/proc/proc_sysctl.o
File: ./fs/proc/base.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0065e0 000018 18 WAM  0   0  1
File: ./fs/proc/namespaces.o
File: ./fs/proc/proc_net.o
File: ./fs/proc/generic.o
File: ./fs/proc/array.o
File: ./fs/proc/fd.o
File: ./fs/proc/proc_tty.o
File: ./fs/proc/self.o
File: ./fs/proc/cmdline.o
File: ./fs/proc/softirqs.o
File: ./fs/proc/consoles.o
File: ./fs/proc/cpuinfo.o
File: ./fs/proc/devices.o
File: ./fs/proc/interrupts.o
File: ./fs/proc/loadavg.o
File: ./fs/proc/thread_self.o
File: ./fs/proc/meminfo.o
File: ./fs/proc/stat.o
File: ./fs/proc/uptime.o
File: ./fs/proc/version.o
File: ./fs/proc/proc.o
  [65] __jump_table      PROGBITS        0000000000000000 01d158 0001e0 18 WAM  0   0  1
File: ./fs/proc/built-in.o
  [65] __jump_table      PROGBITS        0000000000000000 01d158 0001e0 18 WAM  0   0  1
File: ./fs/proc/kcore.o
File: ./fs/proc/vmcore.o
File: ./fs/proc/kmsg.o
File: ./fs/proc/page.o
File: ./fs/pstore/inode.o
File: ./fs/pstore/platform.o
File: ./fs/pstore/pstore.o
File: ./fs/pstore/built-in.o
File: ./fs/ramfs/inode.o
File: ./fs/ramfs/file-mmu.o
File: ./fs/ramfs/ramfs.o
File: ./fs/ramfs/built-in.o
File: ./fs/squashfs/block.o
File: ./fs/squashfs/cache.o
File: ./fs/squashfs/dir.o
File: ./fs/squashfs/export.o
File: ./fs/squashfs/file.o
File: ./fs/squashfs/fragment.o
File: ./fs/squashfs/id.o
File: ./fs/squashfs/inode.o
File: ./fs/squashfs/namei.o
File: ./fs/squashfs/super.o
File: ./fs/squashfs/symlink.o
File: ./fs/squashfs/xz_wrapper.o
File: ./fs/squashfs/decompressor.o
File: ./fs/squashfs/zlib_wrapper.o
File: ./fs/squashfs/file_cache.o
File: ./fs/squashfs/squashfs.mod.o
File: ./fs/squashfs/decompressor_single.o
File: ./fs/squashfs/xattr.o
File: ./fs/squashfs/xattr_id.o
File: ./fs/squashfs/squashfs.o
File: ./fs/squashfs/lzo_wrapper.o
File: ./fs/sysfs/mount.o
File: ./fs/sysfs/file.o
File: ./fs/sysfs/dir.o
File: ./fs/sysfs/symlink.o
File: ./fs/sysfs/group.o
File: ./fs/sysfs/built-in.o
File: ./fs/tracefs/inode.o
File: ./fs/tracefs/tracefs.o
File: ./fs/tracefs/built-in.o
File: ./fs/udf/balloc.o
File: ./fs/udf/dir.o
File: ./fs/udf/file.o
File: ./fs/udf/ialloc.o
File: ./fs/udf/inode.o
File: ./fs/udf/lowlevel.o
File: ./fs/udf/namei.o
File: ./fs/udf/partition.o
File: ./fs/udf/super.o
File: ./fs/udf/truncate.o
File: ./fs/udf/symlink.o
File: ./fs/udf/directory.o
File: ./fs/udf/misc.o
File: ./fs/udf/udftime.o
File: ./fs/udf/unicode.o
File: ./fs/udf/udf.o
File: ./fs/udf/udf.mod.o
File: ./fs/xfs/libxfs/xfs_refcount.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0043d4 0003f0 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_rmap.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0069cc 0005a0 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_alloc.o
  [ 7] __jump_table      PROGBITS        0000000000000000 006048 000588 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_defer.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001358 000138 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_alloc_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000b00 000030 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dir2.o
  [ 8] __jump_table      PROGBITS        0000000000000000 001618 000030 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_attr.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002444 000108 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_da_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 005778 000210 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_trans_resv.o
File: ./fs/xfs/libxfs/xfs_attr_leaf.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0058f4 000210 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 008590 000090 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_da_format.o
File: ./fs/xfs/libxfs/xfs_attr_remote.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00133c 000048 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_inode_buf.o
File: ./fs/xfs/libxfs/xfs_bit.o
File: ./fs/xfs/libxfs/xfs_ialloc.o
  [ 7] __jump_table      PROGBITS        0000000000000000 004708 000060 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_log_rlimit.o
File: ./fs/xfs/libxfs/xfs_bmap.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00f290 000810 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_ag_resv.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000e78 0000c0 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_bmap_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001350 000030 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_rmap_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000e80 000060 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dir2_block.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0025cc 000090 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dir2_data.o
File: ./fs/xfs/libxfs/xfs_ialloc_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000bc8 000030 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dir2_leaf.o
  [ 7] __jump_table      PROGBITS        0000000000000000 003460 000090 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dquot_buf.o
File: ./fs/xfs/libxfs/xfs_dir2_node.o
  [ 7] __jump_table      PROGBITS        0000000000000000 003e70 0000c0 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_refcount_btree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000cc0 000060 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_dir2_sf.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001fc4 0000c0 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_symlink_remote.o
File: ./fs/xfs/libxfs/xfs_inode_fork.o
  [ 7] __jump_table      PROGBITS        0000000000000000 004260 000030 18 WAM  0   0  1
File: ./fs/xfs/libxfs/xfs_sb.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001aa8 000048 18 WAM  0   0  1
File: ./fs/xfs/xfs_buf.o
  [ 9] __jump_table      PROGBITS        0000000000000000 004c98 000240 18 WAM  0   0  1
File: ./fs/xfs/xfs_trace.o
File: ./fs/xfs/xfs_bmap_util.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0036b0 000150 18 WAM  0   0  1
File: ./fs/xfs/xfs_file.o
  [ 9] __jump_table      PROGBITS        0000000000000000 002fb4 000168 18 WAM  0   0  1
File: ./fs/xfs/xfs_aops.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002a0c 000108 18 WAM  0   0  1
File: ./fs/xfs/xfs_extent_busy.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0010e4 000090 18 WAM  0   0  1
File: ./fs/xfs/xfs_fsops.o
File: ./fs/xfs/xfs_attr_inactive.o
File: ./fs/xfs/xfs_discard.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0007f8 000060 18 WAM  0   0  1
File: ./fs/xfs/xfs_export.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0005f4 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_error.o
File: ./fs/xfs/xfs_attr_list.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0016f8 000150 18 WAM  0   0  1
File: ./fs/xfs/xfs_filestream.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000dd8 0000a8 18 WAM  0   0  1
File: ./fs/xfs/xfs_dir2_readdir.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001398 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_extfree_item.o
File: ./fs/xfs/xfs_sysctl.o
File: ./fs/xfs/xfs_globals.o
File: ./fs/xfs/xfs_trans_refcount.o
File: ./fs/xfs/xfs_acl.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0008d0 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_icache.o
  [ 7] __jump_table      PROGBITS        0000000000000000 003814 0001e0 18 WAM  0   0  1
File: ./fs/xfs/xfs_ioctl.o
  [ 7] __jump_table      PROGBITS        0000000000000000 003b0c 000030 18 WAM  0   0  1
File: ./fs/xfs/xfs_icreate_item.o
File: ./fs/xfs/xfs_trans_ail.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001828 0000a8 18 WAM  0   0  1
File: ./fs/xfs/xfs_iomap.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002148 0000c0 18 WAM  0   0  1
File: ./fs/xfs/xfs_log_recover.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0096d4 000240 18 WAM  0   0  1
File: ./fs/xfs/xfs_ioctl32.o
  [11] __jump_table      PROGBITS        0000000000000000 001efc 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_iops.o
  [ 7] __jump_table      PROGBITS        0000000000000000 002188 000060 18 WAM  0   0  1
File: ./fs/xfs/xfs_message.o
File: ./fs/xfs/xfs_inode.o
  [ 7] __jump_table      PROGBITS        0000000000000000 005d58 000180 18 WAM  0   0  1
File: ./fs/xfs/xfs_itable.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0012f0 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_trans_bmap.o
File: ./fs/xfs/xfs_mru_cache.o
File: ./fs/xfs/xfs_stats.o
File: ./fs/xfs/xfs_mount.o
  [10] __jump_table      PROGBITS        0000000000000000 0024b8 000030 18 WAM  0   0  1
File: ./fs/xfs/built-in.o
  [33] __jump_table      PROGBITS        0000000000000000 0f4950 003e10 18 WAM  0   0  1
File: ./fs/xfs/xfs_reflink.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00374c 000318 18 WAM  0   0  1
File: ./fs/xfs/xfs_trans_extfree.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000434 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_super.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0030d8 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_symlink.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001280 000060 18 WAM  0   0  1
File: ./fs/xfs/xfs.o
  [33] __jump_table      PROGBITS        0000000000000000 0f4950 003e10 18 WAM  0   0  1
File: ./fs/xfs/xfs_sysfs.o
File: ./fs/xfs/xfs_trans_buf.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00148c 000168 18 WAM  0   0  1
File: ./fs/xfs/xfs_xattr.o
File: ./fs/xfs/xfs_trans.o
File: ./fs/xfs/kmem.o
File: ./fs/xfs/xfs_rmap_item.o
File: ./fs/xfs/xfs_trans_rmap.o
File: ./fs/xfs/uuid.o
File: ./fs/xfs/xfs_log.o
  [ 7] __jump_table      PROGBITS        0000000000000000 005da0 0001c8 18 WAM  0   0  1
File: ./fs/xfs/xfs_inode_item.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001958 000030 18 WAM  0   0  1
File: ./fs/xfs/xfs_log_cil.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001748 000018 18 WAM  0   0  1
File: ./fs/xfs/xfs_bmap_item.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000aa8 000030 18 WAM  0   0  1
File: ./fs/xfs/xfs_buf_item.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001f80 000180 18 WAM  0   0  1
File: ./fs/xfs/xfs_refcount_item.o
File: ./fs/xfs/xfs_trans_inode.o
File: ./fs/pipe.o
  [33] __jump_table      PROGBITS        0000000000000000 0027c4 000018 18 WAM  0   0  1
File: ./fs/open.o
File: ./fs/file_table.o
File: ./fs/char_dev.o
File: ./fs/read_write.o
File: ./fs/exec.o
  [56] __jump_table      PROGBITS        0000000000000000 0037a0 000060 18 WAM  0   0  1
File: ./fs/super.o
File: ./fs/stat.o
File: ./fs/proc_namespace.o
File: ./fs/eventpoll.o
File: ./fs/aio.o
File: ./fs/bad_inode.o
File: ./fs/namei.o
File: ./fs/signalfd.o
File: ./fs/iomap.o
File: ./fs/mbcache.o
File: ./fs/compat.o
File: ./fs/posix_acl.o
File: ./fs/readdir.o
File: ./fs/ioctl.o
File: ./fs/block_dev.o
File: ./fs/dcookies.o
File: ./fs/select.o
File: ./fs/coredump.o
File: ./fs/inode.o
  [107] __jump_table      PROGBITS        0000000000000000 004aa8 000018 18 WAM  0   0  1
File: ./fs/dcache.o
File: ./fs/binfmt_elf.o
File: ./fs/xattr.o
File: ./fs/binfmt_script.o
File: ./fs/attr.o
File: ./fs/dax.o
  [28] __jump_table      PROGBITS        0000000000000000 004418 000018 18 WAM  0   0  1
File: ./fs/compat_ioctl.o
File: ./fs/file.o
File: ./fs/locks.o
  [58] __jump_table      PROGBITS        0000000000000000 0082e8 000138 18 WAM  0   0  1
File: ./fs/eventfd.o
File: ./fs/built-in.o
  [2070] __jump_table      PROGBITS        0000000000000000 318408 005838 18 WAM  0   0  1
File: ./fs/compat_binfmt_elf.o
File: ./fs/filesystems.o
File: ./fs/splice.o
File: ./fs/buffer.o
  [129] __jump_table      PROGBITS        0000000000000000 008400 000048 18 WAM  0   0  1
File: ./fs/namespace.o
File: ./fs/seq_file.o
File: ./fs/anon_inodes.o
File: ./fs/timerfd.o
File: ./fs/libfs.o
File: ./fs/drop_caches.o
File: ./fs/fs-writeback.o
  [38] __jump_table      PROGBITS        0000000000000000 00b540 000210 18 WAM  0   0  1
File: ./fs/pnode.o
File: ./fs/sync.o
File: ./fs/utimes.o
File: ./fs/stack.o
File: ./fs/direct-io.o
File: ./fs/fs_struct.o
File: ./fs/mpage.o
File: ./fs/fhandle.o
File: ./fs/statfs.o
File: ./fs/fs_pin.o
File: ./fs/fcntl.o
File: ./fs/nsfs.o
File: ./fs/binfmt_misc.o
File: ./fs/binfmt_misc.mod.o
File: ./init/do_mounts_rd.o
File: ./init/do_mounts_initrd.o
File: ./init/do_mounts_md.o
File: ./init/initramfs.o
File: ./init/main.o
File: ./init/do_mounts.o
File: ./init/init_task.o
File: ./init/mounts.o
File: ./init/version.o
File: ./init/built-in.o
File: ./ipc/compat.o
File: ./ipc/util.o
File: ./ipc/msgutil.o
File: ./ipc/msg.o
File: ./ipc/sem.o
File: ./ipc/shm.o
File: ./ipc/syscall.o
File: ./ipc/ipc_sysctl.o
File: ./ipc/mqueue.o
File: ./ipc/compat_mq.o
File: ./ipc/namespace.o
File: ./ipc/mq_sysctl.o
File: ./ipc/built-in.o
File: ./kernel/bpf/core.o
  [30] __jump_table      PROGBITS        0000000000000000 008350 000018 18 WAM  0   0  1
File: ./kernel/bpf/built-in.o
  [28] __jump_table      PROGBITS        0000000000000000 008340 000018 18 WAM  0   0  1
File: ./kernel/user.o
File: ./kernel/events/ring_buffer.o
File: ./kernel/events/callchain.o
File: ./kernel/events/core.o
File: ./kernel/events/hw_breakpoint.o
File: ./kernel/events/built-in.o
File: ./kernel/irq/handle.o
  [15] __jump_table      PROGBITS        0000000000000000 000a36 000030 18 WAM  0   0  1
File: ./kernel/irq/built-in.o
  [185] __jump_table      PROGBITS        0000000000000000 00ee10 000060 18 WAM  0   0  1
File: ./kernel/irq/manage.o
File: ./kernel/irq/spurious.o
File: ./kernel/irq/resend.o
File: ./kernel/irq/chip.o
  [42] __jump_table      PROGBITS        0000000000000000 002340 000030 18 WAM  0   0  1
File: ./kernel/irq/dummychip.o
File: ./kernel/irq/devres.o
File: ./kernel/irq/irqdomain.o
File: ./kernel/irq/proc.o
File: ./kernel/irq/pm.o
File: ./kernel/irq/msi.o
File: ./kernel/irq/affinity.o
File: ./kernel/irq/irqdesc.o
File: ./kernel/locking/rtmutex-debug.o
File: ./kernel/locking/mutex.o
File: ./kernel/locking/semaphore.o
File: ./kernel/locking/spinlock_debug.o
File: ./kernel/locking/rwsem.o
File: ./kernel/locking/percpu-rwsem.o
File: ./kernel/locking/rtmutex.o
File: ./kernel/locking/rwsem-xadd.o
File: ./kernel/locking/mutex-debug.o
File: ./kernel/locking/spinlock.o
File: ./kernel/locking/built-in.o
File: ./kernel/locking/osq_lock.o
File: ./kernel/power/process.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000ae4 000030 18 WAM  0   0  1
File: ./kernel/power/poweroff.o
File: ./kernel/power/qos.o
  [29] __jump_table      PROGBITS        0000000000000000 001d18 000090 18 WAM  0   0  1
File: ./kernel/power/main.o
File: ./kernel/power/console.o
File: ./kernel/power/suspend.o
  [26] __jump_table      PROGBITS        0000000000000000 001748 000120 18 WAM  0   0  1
File: ./kernel/power/built-in.o
  [48] __jump_table      PROGBITS        0000000000000000 0055f8 0001e0 18 WAM  0   0  1
File: ./kernel/printk/printk_safe.o
File: ./kernel/printk/printk.o
  [71] __jump_table      PROGBITS        0000000000000000 006380 000018 18 WAM  0   0  1
File: ./kernel/printk/built-in.o
  [69] __jump_table      PROGBITS        0000000000000000 006c20 000018 18 WAM  0   0  1
File: ./kernel/rcu/sync.o
File: ./kernel/rcu/srcu.o
File: ./kernel/rcu/update.o
File: ./kernel/rcu/tree.o
  [89] __jump_table      PROGBITS        0000000000000000 007f2a 000090 18 WAM  0   0  1
File: ./kernel/rcu/built-in.o
  [173] __jump_table      PROGBITS        0000000000000000 016db0 000090 18 WAM  0   0  1
File: ./kernel/sched/cpupri.o
File: ./kernel/sched/cpudeadline.o
File: ./kernel/sched/topology.o
  [12] __jump_table      PROGBITS        0000000000000000 003800 000018 18 WAM  0   0  1
File: ./kernel/sched/cpuacct.o
File: ./kernel/sched/core.o
  [73] __jump_table      PROGBITS        0000000000000000 013b20 000468 18 WAM  0   0  1
File: ./kernel/sched/debug.o
  [10] __jump_table      PROGBITS        0000000000000000 0059f0 000120 18 WAM  0   0  1
File: ./kernel/sched/loadavg.o
File: ./kernel/sched/idle.o
  [15] __jump_table      PROGBITS        0000000000000000 000ac4 000030 18 WAM  0   0  1
File: ./kernel/sched/cpufreq.o
File: ./kernel/sched/clock.o
File: ./kernel/sched/swait.o
File: ./kernel/sched/cputime.o
File: ./kernel/sched/stats.o
File: ./kernel/sched/idle_task.o
  [ 8] __jump_table      PROGBITS        0000000000000000 00021c 000030 18 WAM  0   0  1
File: ./kernel/sched/fair.o
  [ 8] __jump_table      PROGBITS        0000000000000000 0138a8 0008d0 18 WAM  0   0  1
File: ./kernel/sched/rt.o
  [ 9] __jump_table      PROGBITS        0000000000000000 003580 000060 18 WAM  0   0  1
File: ./kernel/sched/deadline.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0031e8 000048 18 WAM  0   0  1
File: ./kernel/sched/stop_task.o
  [ 8] __jump_table      PROGBITS        0000000000000000 000478 000018 18 WAM  0   0  1
File: ./kernel/sched/wait.o
File: ./kernel/sched/completion.o
File: ./kernel/sched/built-in.o
  [187] __jump_table      PROGBITS        0000000000000000 03f198 000f90 18 WAM  0   0  1
File: ./kernel/time/jiffies.o
File: ./kernel/time/itimer.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000bf4 000048 18 WAM  0   0  1
File: ./kernel/time/built-in.o
  [293] __jump_table      PROGBITS        0000000000000000 0218c0 0002d0 18 WAM  0   0  1
File: ./kernel/time/timer.o
  [68] __jump_table      PROGBITS        0000000000000000 0061b0 000108 18 WAM  0   0  1
File: ./kernel/time/timeconv.o
File: ./kernel/time/timekeeping.o
File: ./kernel/time/ntp.o
File: ./kernel/time/posix-cpu-timers.o
  [ 8] __jump_table      PROGBITS        0000000000000000 002450 000018 18 WAM  0   0  1
File: ./kernel/time/clocksource.o
File: ./kernel/time/time.o
File: ./kernel/time/tick-broadcast-hrtimer.o
File: ./kernel/time/hrtimer.o
  [41] __jump_table      PROGBITS        0000000000000000 002778 0000c0 18 WAM  0   0  1
File: ./kernel/time/timer_list.o
File: ./kernel/time/timekeeping_debug.o
File: ./kernel/time/timecounter.o
File: ./kernel/time/alarmtimer.o
  [38] __jump_table      PROGBITS        0000000000000000 002da8 000060 18 WAM  0   0  1
File: ./kernel/time/posix-clock.o
File: ./kernel/time/tick-sched.o
  [18] __jump_table      PROGBITS        0000000000000000 001819 000018 18 WAM  0   0  1
File: ./kernel/time/posix-timers.o
File: ./kernel/time/clockevents.o
File: ./kernel/time/tick-common.o
  [13] __jump_table      PROGBITS        0000000000000000 001138 000030 18 WAM  0   0  1
File: ./kernel/time/tick-oneshot.o
File: ./kernel/time/tick-broadcast.o
File: ./kernel/trace/blktrace.o
File: ./kernel/trace/trace_printk.o
File: ./kernel/trace/trace_clock.o
File: ./kernel/trace/trace_nop.o
File: ./kernel/trace/ring_buffer.o
File: ./kernel/trace/trace_events.o
File: ./kernel/trace/trace.o
  [54] __jump_table      PROGBITS        0000000000000000 011e40 000030 18 WAM  0   0  1
File: ./kernel/trace/trace_seq.o
File: ./kernel/trace/power-traces.o
File: ./kernel/trace/built-in.o
  [350] __jump_table      PROGBITS        0000000000000000 0409a0 000030 18 WAM  0   0  1
File: ./kernel/trace/trace_stat.o
File: ./kernel/trace/trace_export.o
File: ./kernel/trace/rpm-traces.o
File: ./kernel/trace/trace_sched_switch.o
File: ./kernel/trace/trace_sched_wakeup.o
File: ./kernel/trace/trace_event_perf.o
File: ./kernel/trace/trace_kprobe.o
File: ./kernel/trace/trace_probe.o
File: ./kernel/trace/trace_output.o
File: ./kernel/trace/trace_events_filter.o
File: ./kernel/trace/trace_events_trigger.o
File: ./kernel/cgroup/freezer.o
File: ./kernel/cgroup/cgroup.o
  [57] __jump_table      PROGBITS        0000000000000000 00bd28 000090 18 WAM  0   0  1
File: ./kernel/cgroup/namespace.o
File: ./kernel/cgroup/cgroup-v1.o
  [16] __jump_table      PROGBITS        0000000000000000 002bf0 000048 18 WAM  0   0  1
File: ./kernel/cgroup/cpuset.o
  [16] __jump_table      PROGBITS        0000000000000000 005c70 0000f0 18 WAM  0   0  1
File: ./kernel/cgroup/built-in.o
  [61] __jump_table      PROGBITS        0000000000000000 0159d0 0001c8 18 WAM  0   0  1
File: ./kernel/fork.o
  [34] __jump_table      PROGBITS        0000000000000000 004c18 0000a8 18 WAM  0   0  1
File: ./kernel/exec_domain.o
File: ./kernel/capability.o
File: ./kernel/panic.o
File: ./kernel/sysctl.o
File: ./kernel/cpu.o
  [51] __jump_table      PROGBITS        0000000000000000 009230 000120 18 WAM  0   0  1
File: ./kernel/exit.o
  [21] __jump_table      PROGBITS        0000000000000000 003750 000048 18 WAM  0   0  1
File: ./kernel/resource.o
File: ./kernel/sysctl_binary.o
File: ./kernel/softirq.o
  [32] __jump_table      PROGBITS        0000000000000000 002870 000048 18 WAM  0   0  1
File: ./kernel/user_namespace.o
File: ./kernel/ptrace.o
File: ./kernel/signal.o
  [44] __jump_table      PROGBITS        0000000000000000 007b10 000048 18 WAM  0   0  1
File: ./kernel/taskstats.o
File: ./kernel/seccomp.o
File: ./kernel/sys.o
File: ./kernel/irq_work.o
File: ./kernel/audit_tree.o
File: ./kernel/kmod.o
  [26] __jump_table      PROGBITS        0000000000000000 001670 000018 18 WAM  0   0  1
File: ./kernel/pid.o
File: ./kernel/kexec_file.o
File: ./kernel/audit.o
File: ./kernel/task_work.o
File: ./kernel/notifier.o
File: ./kernel/auditsc.o
File: ./kernel/audit_watch.o
File: ./kernel/extable.o
File: ./kernel/relay.o
File: ./kernel/audit_fsnotify.o
File: ./kernel/params.o
File: ./kernel/workqueue.o
  [68] __jump_table      PROGBITS        0000000000000000 00af20 000078 18 WAM  0   0  1
File: ./kernel/kexec.o
File: ./kernel/auditfilter.o
File: ./kernel/sys_ni.o
File: ./kernel/backtracetest.o
File: ./kernel/utsname.o
File: ./kernel/nsproxy.o
File: ./kernel/dma.o
File: ./kernel/kallsyms.o
File: ./kernel/watchdog.o
File: ./kernel/kthread.o
  [56] __jump_table      PROGBITS        0000000000000000 002480 000030 18 WAM  0   0  1
File: ./kernel/ksysfs.o
File: ./kernel/kprobes.o
File: ./kernel/stop_machine.o
File: ./kernel/jump_label.o
File: ./kernel/compat.o
File: ./kernel/tracepoint.o
File: ./kernel/cred.o
File: ./kernel/reboot.o
File: ./kernel/smpboot.o
File: ./kernel/memremap.o
File: ./kernel/range.o
File: ./kernel/kexec_core.o
File: ./kernel/async.o
File: ./kernel/smp.o
File: ./kernel/tsacct.o
File: ./kernel/hung_task.o
  [15] __jump_table      PROGBITS        0000000000000000 000740 000018 18 WAM  0   0  1
File: ./kernel/ucount.o
File: ./kernel/latencytop.o
File: ./kernel/delayacct.o
File: ./kernel/groups.o
File: ./kernel/stacktrace.o
File: ./kernel/freezer.o
File: ./kernel/pid_namespace.o
File: ./kernel/elfcore.o
File: ./kernel/watchdog_hld.o
File: ./kernel/profile.o
File: ./kernel/crash_dump.o
File: ./kernel/futex.o
File: ./kernel/futex_compat.o
File: ./kernel/module.o
  [56] __jump_table      PROGBITS        0000000000000000 008b98 000078 18 WAM  0   0  1
File: ./kernel/built-in.o
  [2036] __jump_table      PROGBITS        0000000000000000 18fbb8 001b48 18 WAM  0   0  1
File: ./kernel/utsname_sysctl.o
File: ./kernel/membarrier.o
File: ./kernel/configs.o
File: ./lib/842/842_decompress.o
File: ./lib/842/built-in.o
File: ./lib/fonts/font_8x8.o
File: ./lib/fonts/fonts.o
File: ./lib/fonts/font_8x16.o
File: ./lib/fonts/font.o
File: ./lib/fonts/built-in.o
File: ./lib/lz4/lz4_decompress.o
File: ./lib/lz4/built-in.o
File: ./lib/lzo/lzo1x_compress.o
File: ./lib/lzo/lzo1x_decompress_safe.o
File: ./lib/lzo/lzo_compress.o
File: ./lib/lzo/lzo_decompress.o
File: ./lib/lzo/built-in.o
File: ./lib/raid6/algos.o
File: ./lib/raid6/raid6_pq.o
  [50] __jump_table      PROGBITS        0000000000000000 0154f8 000018 18 WAM  0   0  1
File: ./lib/raid6/raid6_pq.mod.o
File: ./lib/raid6/recov.o
File: ./lib/raid6/int1.o
File: ./lib/raid6/int2.o
File: ./lib/raid6/int4.o
File: ./lib/raid6/int8.o
File: ./lib/raid6/int16.o
File: ./lib/raid6/int32.o
File: ./lib/raid6/altivec1.o
  [ 7] __jump_table      PROGBITS        0000000000000000 0001d8 000018 18 WAM  0   0  1
File: ./lib/raid6/altivec2.o
File: ./lib/raid6/altivec4.o
File: ./lib/raid6/altivec8.o
File: ./lib/raid6/tables.o
File: ./lib/xz/xz_dec_stream.o
File: ./lib/xz/xz_dec_lzma2.o
File: ./lib/xz/xz_dec_bcj.o
File: ./lib/xz/xz_dec_syms.o
File: ./lib/xz/xz_dec.o
File: ./lib/xz/built-in.o
File: ./lib/zlib_deflate/deflate.o
File: ./lib/zlib_deflate/deftree.o
File: ./lib/zlib_deflate/deflate_syms.o
File: ./lib/zlib_deflate/zlib_deflate.o
File: ./lib/zlib_deflate/built-in.o
File: ./lib/zlib_inflate/inffast.o
File: ./lib/zlib_inflate/inflate.o
File: ./lib/zlib_inflate/infutil.o
File: ./lib/zlib_inflate/inftrees.o
File: ./lib/zlib_inflate/inflate_syms.o
File: ./lib/zlib_inflate/zlib_inflate.o
File: ./lib/zlib_inflate/built-in.o
File: ./lib/iov_iter.o
File: ./lib/sort.o
File: ./lib/parser.o
File: ./lib/random32.o
File: ./lib/bitmap.o
File: ./lib/kasprintf.o
File: ./lib/find_bit.o
File: ./lib/flex_array.o
File: ./lib/llist.o
File: ./lib/uuid.o
File: ./lib/clz_ctz.o
File: ./lib/list_sort.o
File: ./lib/memweight.o
File: ./lib/debug_locks.o
File: ./lib/bust_spinlocks.o
File: ./lib/lcm.o
File: ./lib/bsearch.o
File: ./lib/lockref.o
File: ./lib/gcd.o
File: ./lib/rhashtable.o
File: ./lib/percpu_ida.o
File: ./lib/bcd.o
File: ./lib/kfifo.o
File: ./lib/div64.o
File: ./lib/scatterlist.o
File: ./lib/nlattr.o
File: ./lib/bug.o
File: ./lib/strnlen_user.o
File: ./lib/percpu-refcount.o
File: ./lib/cpu_rmap.o
File: ./lib/dump_stack.o
File: ./lib/iommu-common.o
File: ./lib/sg_pool.o
File: ./lib/reciprocal_div.o
File: ./lib/net_utils.o
File: ./lib/cpumask.o
File: ./lib/once.o
File: ./lib/refcount.o
File: ./lib/syscall.o
File: ./lib/sbitmap.o
File: ./lib/argv_split.o
File: ./lib/string_helpers.o
File: ./lib/percpu_counter.o
File: ./lib/glob.o
File: ./lib/hexdump.o
File: ./lib/decompress.o
File: ./lib/dec_and_lock.o
File: ./lib/kstrtox.o
File: ./lib/crc16.o
File: ./lib/irq_poll.o
File: ./lib/iomap.o
File: ./lib/libcrc32c.o
File: ./lib/klist.o
File: ./lib/idr.o
File: ./lib/pci_iomap.o
File: ./lib/genalloc.o
File: ./lib/irq_regs.o
File: ./lib/iomap_copy.o
File: ./lib/earlycpio.o
File: ./lib/cmdline.o
File: ./lib/devres.o
File: ./lib/chacha20.o
File: ./lib/iommu-helper.o
File: ./lib/locking-selftest.o
File: ./lib/fdt.o
File: ./lib/hweight.o
File: ./lib/extable.o
File: ./lib/assoc_array.o
File: ./lib/fdt_ro.o
File: ./lib/bitrev.o
File: ./lib/crc32.o
File: ./lib/ctype.o
File: ./lib/strncpy_from_user.o
File: ./lib/dynamic_queue_limits.o
File: ./lib/rbtree.o
File: ./lib/crc-ccitt.o
File: ./lib/crc-t10dif.mod.o
File: ./lib/decompress_bunzip2.o
File: ./lib/timerqueue.o
File: ./lib/oid_registry.o
File: ./lib/decompress_inflate.o
File: ./lib/siphash.o
File: ./lib/decompress_unlz4.o
File: ./lib/plist.o
File: ./lib/decompress_unlzma.o
File: ./lib/vsprintf.o
File: ./lib/decompress_unlzo.o
File: ./lib/decompress_unxz.o
File: ./lib/crc-ccitt.mod.o
File: ./lib/nodemask.o
File: ./lib/fdt_empty_tree.o
File: ./lib/fdt_rw.o
File: ./lib/seq_buf.o
File: ./lib/crc-t10dif.o
  [20] __jump_table      PROGBITS        0000000000000000 00025a 000018 18 WAM  0   0  1
File: ./lib/fdt_strerror.o
File: ./lib/fdt_sw.o
File: ./lib/fdt_wip.o
File: ./lib/built-in.o
File: ./lib/flex_proportions.o
File: ./lib/lib-ksyms.o
File: ./lib/int_sqrt.o
File: ./lib/ioremap.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0005b4 000018 18 WAM  0   0  1
File: ./lib/radix-tree.o
File: ./lib/string.o
File: ./lib/is_single_threaded.o
File: ./lib/kobject.o
File: ./lib/crc-itu-t.o
File: ./lib/ratelimit.o
File: ./lib/kobject_uevent.o
File: ./lib/win_minmax.o
File: ./lib/crc-itu-t.mod.o
File: ./lib/md5.o
File: ./lib/sha1.o
File: ./lib/nmi_backtrace.o
File: ./lib/show_mem.o
File: ./mm/mmzone.o
File: ./mm/filemap.o
  [107] __jump_table      PROGBITS        0000000000000000 006fb8 000090 18 WAM  0   0  1
File: ./mm/vmscan.o
  [22] __jump_table      PROGBITS        0000000000000000 00f238 0002a0 18 WAM  0   0  1
File: ./mm/vmstat.o
File: ./mm/oom_kill.o
  [22] __jump_table      PROGBITS        0000000000000000 003c18 000018 18 WAM  0   0  1
File: ./mm/mempool.o
File: ./mm/shmem.o
  [27] __jump_table      PROGBITS        0000000000000000 00a2f8 000078 18 WAM  0   0  1
File: ./mm/mm_init.o
File: ./mm/maccess.o
File: ./mm/truncate.o
File: ./mm/page-writeback.o
  [57] __jump_table      PROGBITS        0000000000000000 0047b8 000090 18 WAM  0   0  1
File: ./mm/page_alloc.o
  [68] __jump_table      PROGBITS        0000000000000000 00ccd0 0001b0 18 WAM  0   0  1
File: ./mm/util.o
File: ./mm/readahead.o
File: ./mm/swap.o
  [37] __jump_table      PROGBITS        0000000000000000 004320 000030 18 WAM  0   0  1
File: ./mm/ksm.o
  [12] __jump_table      PROGBITS        0000000000000000 004c30 000018 18 WAM  0   0  1
File: ./mm/swap_state.o
File: ./mm/sparse-vmemmap.o
  [10] __jump_table      PROGBITS        0000000000000000 00095c 000018 18 WAM  0   0  1
File: ./mm/page_io.o
File: ./mm/mmu_notifier.o
File: ./mm/backing-dev.o
  [37] __jump_table      PROGBITS        0000000000000000 002200 000048 18 WAM  0   0  1
File: ./mm/memory_hotplug.o
File: ./mm/page_vma_mapped.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000cd8 000090 18 WAM  0   0  1
File: ./mm/khugepaged.o
  [10] __jump_table      PROGBITS        0000000000000000 007020 000228 18 WAM  0   0  1
File: ./mm/mmu_context.o
  [11] __jump_table      PROGBITS        0000000000000000 000254 000030 18 WAM  0   0  1
File: ./mm/dmapool.o
File: ./mm/balloon_compaction.o
File: ./mm/percpu.o
  [26] __jump_table      PROGBITS        0000000000000000 004bb4 000018 18 WAM  0   0  1
File: ./mm/compaction.o
  [20] __jump_table      PROGBITS        0000000000000000 007b08 000150 18 WAM  0   0  1
File: ./mm/pagewalk.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000b20 000060 18 WAM  0   0  1
File: ./mm/fadvise.o
File: ./mm/cma.o
  [12] __jump_table      PROGBITS        0000000000000000 0015d4 000030 18 WAM  0   0  1
File: ./mm/slab_common.o
  [52] __jump_table      PROGBITS        0000000000000000 009048 000018 18 WAM  0   0  1
File: ./mm/pgtable-generic.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000778 0000d8 18 WAM  0   0  1
File: ./mm/memcontrol.o
  [32] __jump_table      PROGBITS        0000000000000000 00cd58 000648 18 WAM  0   0  1
File: ./mm/huge_memory.o
  [21] __jump_table      PROGBITS        0000000000000000 008168 000438 18 WAM  0   0  1
File: ./mm/vmacache.o
File: ./mm/swap_slots.o
File: ./mm/swapfile.o
  [23] __jump_table      PROGBITS        0000000000000000 0067c8 000090 18 WAM  0   0  1
File: ./mm/page_counter.o
File: ./mm/interval_tree.o
File: ./mm/madvise.o
  [ 7] __jump_table      PROGBITS        0000000000000000 001d64 000150 18 WAM  0   0  1
File: ./mm/list_lru.o
  [32] __jump_table      PROGBITS        0000000000000000 001660 000030 18 WAM  0   0  1
File: ./mm/rmap.o
  [17] __jump_table      PROGBITS        0000000000000000 0037f2 000018 18 WAM  0   0  1
File: ./mm/workingset.o
  [12] __jump_table      PROGBITS        0000000000000000 0009a8 000090 18 WAM  0   0  1
File: ./mm/vmpressure.o
File: ./mm/debug.o
File: ./mm/memblock.o
File: ./mm/mmap.o
File: ./mm/gup.o
  [25] __jump_table      PROGBITS        0000000000000000 002df1 000120 18 WAM  0   0  1
File: ./mm/process_vm_access.o
File: ./mm/hugetlb.o
  [24] __jump_table      PROGBITS        0000000000000000 009720 000378 18 WAM  0   0  1
File: ./mm/highmem.o
File: ./mm/init-mm.o
File: ./mm/memory.o
  [48] __jump_table      PROGBITS        0000000000000000 00bd27 000690 18 WAM  0   0  1
File: ./mm/vmalloc.o
  [67] __jump_table      PROGBITS        0000000000000000 005bd8 0000f0 18 WAM  0   0  1
File: ./mm/mincore.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000b84 000078 18 WAM  0   0  1
File: ./mm/migrate.o
  [30] __jump_table      PROGBITS        0000000000000000 005e78 0000f0 18 WAM  0   0  1
File: ./mm/mlock.o
File: ./mm/mempolicy.o
  [23] __jump_table      PROGBITS        0000000000000000 0060c0 0000c0 18 WAM  0   0  1
File: ./mm/msync.o
File: ./mm/mprotect.o
  [ 9] __jump_table      PROGBITS        0000000000000000 001500 000138 18 WAM  0   0  1
File: ./mm/slub.o
  [42] __jump_table      PROGBITS        0000000000000000 00d290 0003f0 18 WAM  0   0  1
File: ./mm/nobootmem.o
File: ./mm/built-in.o
  [698] __jump_table      PROGBITS        0000000000000000 0e2140 002e68 18 WAM  0   0  1
File: ./mm/mremap.o
  [ 7] __jump_table      PROGBITS        0000000000000000 00187c 000138 18 WAM  0   0  1
File: ./mm/swap_cgroup.o
File: ./mm/sparse.o
File: ./mm/page_isolation.o
  [12] __jump_table      PROGBITS        0000000000000000 000ebc 000018 18 WAM  0   0  1
File: ./net/802/p8022.o
File: ./net/802/psnap.o
File: ./net/802/stp.o
File: ./net/802/p8022.mod.o
File: ./net/802/psnap.mod.o
File: ./net/802/stp.mod.o
File: ./net/8021q/vlan.o
File: ./net/8021q/vlan_dev.o
File: ./net/8021q/vlan_netlink.o
File: ./net/8021q/vlanproc.o
File: ./net/8021q/vlan_core.o
File: ./net/8021q/built-in.o
File: ./net/8021q/8021q.o
File: ./net/8021q/8021q.mod.o
File: ./net/bridge/br_stp_timer.o
File: ./net/bridge/br_netlink_tunnel.o
File: ./net/bridge/br_mdb.o
File: ./net/bridge/br_sysfs_if.o
File: ./net/bridge/br_sysfs_br.o
File: ./net/bridge/br.o
File: ./net/bridge/built-in.o
File: ./net/bridge/br_device.o
File: ./net/bridge/br_fdb.o
File: ./net/bridge/br_forward.o
  [17] __jump_table      PROGBITS        0000000000000000 000cf2 000018 18 WAM  0   0  1
File: ./net/bridge/br_if.o
File: ./net/bridge/bridge.o
  [40] __jump_table      PROGBITS        0000000000000000 016fd8 000090 18 WAM  0   0  1
File: ./net/bridge/br_input.o
  [12] __jump_table      PROGBITS        0000000000000000 000b82 000048 18 WAM  0   0  1
File: ./net/bridge/br_ioctl.o
File: ./net/bridge/br_stp.o
File: ./net/bridge/br_multicast.o
  [17] __jump_table      PROGBITS        0000000000000000 0046a1 000018 18 WAM  0   0  1
File: ./net/bridge/br_stp_bpdu.o
  [ 9] __jump_table      PROGBITS        0000000000000000 0008f4 000018 18 WAM  0   0  1
File: ./net/bridge/bridge.mod.o
File: ./net/bridge/br_stp_if.o
File: ./net/bridge/br_netlink.o
File: ./net/core/net_namespace.o
File: ./net/core/tso.o
File: ./net/core/secure_seq.o
  [10] __jump_table      PROGBITS        0000000000000000 0002e0 000030 18 WAM  0   0  1
File: ./net/core/dev.o
  [321] __jump_table      PROGBITS        0000000000000000 012728 000240 18 WAM  0   0  1
File: ./net/core/sock_reuseport.o
File: ./net/core/sock.o
  [177] __jump_table      PROGBITS        0000000000000000 007390 000108 18 WAM  0   0  1
File: ./net/core/flow_dissector.o
  [42] __jump_table      PROGBITS        0000000000000000 002a08 000048 18 WAM  0   0  1
File: ./net/core/request_sock.o
File: ./net/core/sysctl_net_core.o
File: ./net/core/skbuff.o
  [184] __jump_table      PROGBITS        0000000000000000 00b76a 000090 18 WAM  0   0  1
File: ./net/core/gro_cells.o
File: ./net/core/ethtool.o
  [27] __jump_table      PROGBITS        0000000000000000 006348 000018 18 WAM  0   0  1
File: ./net/core/dst_cache.o
File: ./net/core/datagram.o
  [41] __jump_table      PROGBITS        0000000000000000 001dec 000018 18 WAM  0   0  1
File: ./net/core/netevent.o
File: ./net/core/net-procfs.o
File: ./net/core/stream.o
File: ./net/core/sock_diag.o
File: ./net/core/net-traces.o
File: ./net/core/dst.o
File: ./net/core/scm.o
File: ./net/core/built-in.o
  [1129] __jump_table      PROGBITS        0000000000000000 0630c8 000498 18 WAM  0   0  1
File: ./net/core/gen_estimator.o
File: ./net/core/gen_stats.o
File: ./net/core/flow.o
File: ./net/core/rtnetlink.o
File: ./net/core/dev_addr_lists.o
File: ./net/core/utils.o
File: ./net/core/filter.o
File: ./net/core/netpoll.o
  [35] __jump_table      PROGBITS        0000000000000000 002660 000018 18 WAM  0   0  1
File: ./net/core/neighbour.o
File: ./net/core/net-sysfs.o
File: ./net/core/link_watch.o
File: ./net/core/dev_ioctl.o
File: ./net/core/ptp_classifier.o
File: ./net/dns_resolver/dns_key.o
File: ./net/dns_resolver/dns_query.o
File: ./net/dns_resolver/dns_resolver.o
File: ./net/dns_resolver/built-in.o
File: ./net/ethernet/eth.o
File: ./net/ethernet/built-in.o
File: ./net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.o
File: ./net/ipv4/netfilter/nf_nat_masquerade_ipv4.o
File: ./net/ipv4/netfilter/ip_tables.mod.o
File: ./net/ipv4/netfilter/nf_conntrack_proto_icmp.o
File: ./net/ipv4/netfilter/iptable_nat.o
File: ./net/ipv4/netfilter/ip_tables.o
  [27] __jump_table      PROGBITS        0000000000000000 003ab8 000018 18 WAM  0   0  1
File: ./net/ipv4/netfilter/nf_log_ipv4.mod.o
File: ./net/ipv4/netfilter/nf_conntrack_ipv4.o
File: ./net/ipv4/netfilter/nf_nat_l3proto_ipv4.o
File: ./net/ipv4/netfilter/nf_log_arp.mod.o
File: ./net/ipv4/netfilter/ipt_MASQUERADE.o
File: ./net/ipv4/netfilter/nf_nat_proto_icmp.o
File: ./net/ipv4/netfilter/nf_nat_ipv4.o
File: ./net/ipv4/netfilter/nf_defrag_ipv4.o
File: ./net/ipv4/netfilter/iptable_filter.o
File: ./net/ipv4/netfilter/nf_nat_ipv4.mod.o
File: ./net/ipv4/netfilter/nf_log_arp.o
File: ./net/ipv4/netfilter/iptable_mangle.o
File: ./net/ipv4/netfilter/ipt_REJECT.o
File: ./net/ipv4/netfilter/nf_log_ipv4.o
File: ./net/ipv4/netfilter/iptable_nat.mod.o
File: ./net/ipv4/netfilter/nf_reject_ipv4.o
File: ./net/ipv4/netfilter/nf_defrag_ipv4.mod.o
File: ./net/ipv4/netfilter/ipt_MASQUERADE.mod.o
File: ./net/ipv4/netfilter/ipt_REJECT.mod.o
File: ./net/ipv4/netfilter/iptable_filter.mod.o
File: ./net/ipv4/netfilter/iptable_mangle.mod.o
File: ./net/ipv4/netfilter/nf_reject_ipv4.mod.o
File: ./net/ipv4/netfilter/nf_conntrack_ipv4.mod.o
File: ./net/ipv4/netfilter/nf_nat_masquerade_ipv4.mod.o
File: ./net/ipv4/ip_input.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000f04 000048 18 WAM  0   0  1
File: ./net/ipv4/route.o
  [37] __jump_table      PROGBITS        0000000000000000 005e68 000060 18 WAM  0   0  1
File: ./net/ipv4/inetpeer.o
File: ./net/ipv4/inet_timewait_sock.o
File: ./net/ipv4/tcp_input.o
  [31] __jump_table      PROGBITS        0000000000000000 00c9d0 0000f0 18 WAM  0   0  1
File: ./net/ipv4/protocol.o
File: ./net/ipv4/tcp_timer.o
  [15] __jump_table      PROGBITS        0000000000000000 00190d 000048 18 WAM  0   0  1
File: ./net/ipv4/ip_output.o
  [25] __jump_table      PROGBITS        0000000000000000 004419 000078 18 WAM  0   0  1
File: ./net/ipv4/ip_fragment.o
  [18] __jump_table      PROGBITS        0000000000000000 001a10 000018 18 WAM  0   0  1
File: ./net/ipv4/ip_sockglue.o
File: ./net/ipv4/inet_hashtables.o
  [37] __jump_table      PROGBITS        0000000000000000 001f50 000018 18 WAM  0   0  1
File: ./net/ipv4/ip_forward.o
  [ 7] __jump_table      PROGBITS        0000000000000000 000650 000018 18 WAM  0   0  1
File: ./net/ipv4/tcp.o
  [74] __jump_table      PROGBITS        0000000000000000 007377 000078 18 WAM  0   0  1
File: ./net/ipv4/ip_options.o
File: ./net/ipv4/built-in.o
  [734] __jump_table      PROGBITS        0000000000000000 0802d8 000588 18 WAM  0   0  1
File: ./net/ipv4/tcp_ipv4.o
  [52] __jump_table      PROGBITS        0000000000000000 005030 000018 18 WAM  0   0  1
File: ./net/ipv4/tcp_output.o
  [33] __jump_table      PROGBITS        0000000000000000 007529 000078 18 WAM  0   0  1
File: ./net/ipv4/inet_fragment.o
File: ./net/ipv4/ipip.o
File: ./net/ipv4/esp4.o
File: ./net/ipv4/inet_connection_sock.o
File: ./net/ipv4/netfilter.o
File: ./net/ipv4/ip_tunnel_core.o
File: ./net/ipv4/tcp_diag.o
File: ./net/ipv4/ipcomp.mod.o
File: ./net/ipv4/tcp_cubic.o
File: ./net/ipv4/xfrm4_mode_transport.o
File: ./net/ipv4/tcp_cong.o
File: ./net/ipv4/tcp_minisocks.o
File: ./net/ipv4/fib_trie.o
  [20] __jump_table      PROGBITS        0000000000000000 004a10 000030 18 WAM  0   0  1
File: ./net/ipv4/datagram.o
File: ./net/ipv4/xfrm4_policy.o
File: ./net/ipv4/tcp_metrics.o
File: ./net/ipv4/tunnel4.o
File: ./net/ipv4/ah4.mod.o
File: ./net/ipv4/xfrm4_mode_tunnel.o
File: ./net/ipv4/tcp_fastopen.o
  [13] __jump_table      PROGBITS        0000000000000000 000ec8 000018 18 WAM  0   0  1
File: ./net/ipv4/gre_offload.o
File: ./net/ipv4/tcp_rate.o
File: ./net/ipv4/ah4.o
File: ./net/ipv4/tcp_recovery.o
File: ./net/ipv4/xfrm4_state.o
File: ./net/ipv4/tcp_offload.o
File: ./net/ipv4/raw.o
  [36] __jump_table      PROGBITS        0000000000000000 0030e8 000018 18 WAM  0   0  1
File: ./net/ipv4/udp_offload.o
File: ./net/ipv4/ipcomp.o
File: ./net/ipv4/sysctl_net_ipv4.o
File: ./net/ipv4/xfrm4_input.o
  [12] __jump_table      PROGBITS        0000000000000000 000639 000018 18 WAM  0   0  1
File: ./net/ipv4/udplite.o
File: ./net/ipv4/xfrm4_output.o
  [ 9] __jump_table      PROGBITS        0000000000000000 000481 000018 18 WAM  0   0  1
File: ./net/ipv4/inet_diag.o
File: ./net/ipv4/syncookies.o
  [21] __jump_table      PROGBITS        0000000000000000 000e80 000018 18 WAM  0   0  1
File: ./net/ipv4/arp.o
  [22] __jump_table      PROGBITS        0000000000000000 0026a0 000030 18 WAM  0   0  1
File: ./net/ipv4/udp_tunnel.o
File: ./net/ipv4/udp.o
  [85] __jump_table      PROGBITS        0000000000000000 006d48 000090 18 WAM  0   0  1
File: ./net/ipv4/icmp.o
File: ./net/ipv4/esp4.mod.o
File: ./net/ipv4/devinet.o
File: ./net/ipv4/proc.o
File: ./net/ipv4/af_inet.o
  [67] __jump_table      PROGBITS        0000000000000000 003d90 000060 18 WAM  0   0  1
File: ./net/ipv4/xfrm4_protocol.o
File: ./net/ipv4/igmp.o
File: ./net/ipv4/fib_frontend.o
  [22] __jump_table      PROGBITS        0000000000000000 002b68 000018 18 WAM  0   0  1
File: ./net/ipv4/ip_tunnel.o
File: ./net/ipv4/fib_semantics.o
File: ./net/ipv4/ping.o
File: ./net/ipv4/xfrm4_mode_beet.o
File: ./net/ipv4/xfrm4_tunnel.o
File: ./net/ipv4/udp_tunnel.mod.o
File: ./net/ipv4/xfrm4_tunnel.mod.o
File: ./net/ipv6/built-in.o
  [115] __jump_table      PROGBITS        0000000000000000 003870 000060 18 WAM  0   0  1
File: ./net/ipv6/addrconf_core.o
File: ./net/ipv6/exthdrs_core.o
File: ./net/ipv6/protocol.o
File: ./net/ipv6/ip6_checksum.o
File: ./net/ipv6/ip6_offload.o
File: ./net/ipv6/exthdrs_offload.o
File: ./net/ipv6/ip6_icmp.o
File: ./net/ipv6/output_core.o
  [17] __jump_table      PROGBITS        0000000000000000 000718 000060 18 WAM  0   0  1
File: ./net/ipv6/tcpv6_offload.o
File: ./net/key/af_key.o
File: ./net/key/af_key.mod.o
File: ./net/llc/llc_core.o
File: ./net/llc/llc_input.o
File: ./net/llc/llc_output.o
File: ./net/llc/llc.o
File: ./net/llc/llc.mod.o
File: ./net/netfilter/nf_conntrack_helper.o
File: ./net/netfilter/nf_conntrack_proto.o
File: ./net/netfilter/nf_conntrack_ftp.o
File: ./net/netfilter/nf_nat_ftp.o
File: ./net/netfilter/nf_conntrack_l3proto_generic.o
File: ./net/netfilter/nf_conntrack_proto_tcp.o
File: ./net/netfilter/nf_conntrack_extend.o
File: ./net/netfilter/nf_nat_irc.o
File: ./net/netfilter/nf_conntrack_netlink.o
File: ./net/netfilter/nf_nat_core.o
File: ./net/netfilter/core.o
File: ./net/netfilter/nf_nat.mod.o
File: ./net/netfilter/nf_nat_helper.o
File: ./net/netfilter/nf_log.o
File: ./net/netfilter/nf_nat_sip.o
File: ./net/netfilter/nf_nat_proto_udp.o
File: ./net/netfilter/nf_queue.o
File: ./net/netfilter/xt_LOG.mod.o
File: ./net/netfilter/nf_conntrack_core.o
  [79] __jump_table      PROGBITS        0000000000000000 004b78 000018 18 WAM  0   0  1
File: ./net/netfilter/nf_sockopt.o
File: ./net/netfilter/xt_tcpudp.o
File: ./net/netfilter/nf_conntrack_acct.o
File: ./net/netfilter/nfnetlink.o
File: ./net/netfilter/nf_nat.o
File: ./net/netfilter/nfnetlink_log.o
File: ./net/netfilter/nf_log_common.o
File: ./net/netfilter/nf_conntrack_sip.o
File: ./net/netfilter/nf_conntrack_standalone.o
File: ./net/netfilter/nf_conntrack_expect.o
  [33] __jump_table      PROGBITS        0000000000000000 001e18 000018 18 WAM  0   0  1
File: ./net/netfilter/built-in.o
File: ./net/netfilter/nf_conntrack_irc.o
File: ./net/netfilter/netfilter.o
File: ./net/netfilter/nf_conntrack.o
  [214] __jump_table      PROGBITS        0000000000000000 00e8a8 000030 18 WAM  0   0  1
File: ./net/netfilter/nf_conntrack_proto_generic.o
File: ./net/netfilter/nf_conntrack.mod.o
File: ./net/netfilter/nf_conntrack_proto_udp.o
File: ./net/netfilter/nf_conntrack_seqadj.o
File: ./net/netfilter/x_tables.o
File: ./net/netfilter/xt_nat.mod.o
File: ./net/netfilter/nf_nat_proto_unknown.o
File: ./net/netfilter/nf_nat_irc.mod.o
File: ./net/netfilter/xt_conntrack.mod.o
File: ./net/netfilter/nf_nat_proto_common.o
File: ./net/netfilter/nf_nat_sip.mod.o
File: ./net/netfilter/nf_nat_proto_tcp.o
File: ./net/netfilter/nfnetlink_log.mod.o
File: ./net/netfilter/nf_log_common.mod.o
File: ./net/netfilter/nfnetlink.mod.o
File: ./net/netfilter/xt_NFLOG.mod.o
File: ./net/netfilter/x_tables.mod.o
File: ./net/netfilter/xt_TCPMSS.mod.o
File: ./net/netfilter/xt_mark.o
File: ./net/netfilter/xt_nat.o
File: ./net/netfilter/xt_LOG.o
File: ./net/netfilter/xt_state.mod.o
File: ./net/netfilter/xt_NFLOG.o
File: ./net/netfilter/xt_TCPMSS.o
File: ./net/netfilter/xt_addrtype.o
File: ./net/netfilter/xt_addrtype.mod.o
File: ./net/netfilter/xt_conntrack.o
File: ./net/netfilter/xt_policy.o
File: ./net/netfilter/xt_state.o
File: ./net/netfilter/nf_conntrack_ftp.mod.o
File: ./net/netfilter/nf_conntrack_netlink.mod.o
File: ./net/netfilter/nf_conntrack_irc.mod.o
File: ./net/netfilter/nf_conntrack_sip.mod.o
File: ./net/netfilter/xt_mark.mod.o
File: ./net/netfilter/xt_policy.mod.o
File: ./net/netfilter/nf_nat_ftp.mod.o
File: ./net/netfilter/xt_tcpudp.mod.o
File: ./net/netlink/af_netlink.o
File: ./net/netlink/genetlink.o
File: ./net/netlink/built-in.o
File: ./net/packet/af_packet.o
File: ./net/packet/built-in.o
File: ./net/sched/sch_mq.o
File: ./net/sched/sch_generic.o
File: ./net/sched/built-in.o
File: ./net/sunrpc/auth_gss/auth_gss.o
File: ./net/sunrpc/auth_gss/gss_rpc_upcall.o
File: ./net/sunrpc/auth_gss/gss_rpc_xdr.o
File: ./net/sunrpc/auth_gss/gss_generic_token.o
File: ./net/sunrpc/auth_gss/gss_mech_switch.o
File: ./net/sunrpc/auth_gss/svcauth_gss.o
File: ./net/sunrpc/auth_gss/auth_rpcgss.o
File: ./net/sunrpc/auth_gss/built-in.o
File: ./net/sunrpc/xprtrdma/transport.o
File: ./net/sunrpc/xprtrdma/rpc_rdma.o
File: ./net/sunrpc/xprtrdma/verbs.o
File: ./net/sunrpc/xprtrdma/fmr_ops.o
File: ./net/sunrpc/xprtrdma/frwr_ops.o
File: ./net/sunrpc/xprtrdma/svc_rdma.o
File: ./net/sunrpc/xprtrdma/svc_rdma_backchannel.o
File: ./net/sunrpc/xprtrdma/svc_rdma_transport.o
File: ./net/sunrpc/xprtrdma/svc_rdma_marshal.o
File: ./net/sunrpc/xprtrdma/svc_rdma_sendto.o
File: ./net/sunrpc/xprtrdma/svc_rdma_recvfrom.o
File: ./net/sunrpc/xprtrdma/module.o
File: ./net/sunrpc/xprtrdma/rpcrdma.o
File: ./net/sunrpc/xprtrdma/rpcrdma.mod.o
File: ./net/sunrpc/clnt.o
  [79] __jump_table      PROGBITS        0000000000000000 004dd8 000048 18 WAM  0   0  1
File: ./net/sunrpc/svc.o
  [47] __jump_table      PROGBITS        0000000000000000 002bb0 000060 18 WAM  0   0  1
File: ./net/sunrpc/xprt.o
  [58] __jump_table      PROGBITS        0000000000000000 003540 000078 18 WAM  0   0  1
File: ./net/sunrpc/timer.o
File: ./net/sunrpc/stats.o
File: ./net/sunrpc/socklib.o
File: ./net/sunrpc/svc_xprt.o
  [49] __jump_table      PROGBITS        0000000000000000 003a30 000180 18 WAM  0   0  1
File: ./net/sunrpc/xprtsock.o
  [10] __jump_table      PROGBITS        0000000000000000 004c50 0000f0 18 WAM  0   0  1
File: ./net/sunrpc/sched.o
  [50] __jump_table      PROGBITS        0000000000000000 00a3b8 000078 18 WAM  0   0  1
File: ./net/sunrpc/xdr.o
File: ./net/sunrpc/addr.o
File: ./net/sunrpc/xprtmultipath.o
File: ./net/sunrpc/auth_null.o
File: ./net/sunrpc/auth_generic.o
File: ./net/sunrpc/auth_unix.o
File: ./net/sunrpc/rpcb_clnt.o
File: ./net/sunrpc/svcsock.o
File: ./net/sunrpc/auth.o
File: ./net/sunrpc/svcauth.o
File: ./net/sunrpc/svcauth_unix.o
File: ./net/sunrpc/sunrpc.o
  [498] __jump_table      PROGBITS        0000000000000000 035950 000408 18 WAM  0   0  1
File: ./net/sunrpc/sunrpc_syms.o
File: ./net/sunrpc/cache.o
File: ./net/sunrpc/sysctl.o
File: ./net/sunrpc/rpc_pipe.o
File: ./net/sunrpc/built-in.o
  [518] __jump_table      PROGBITS        0000000000000000 0400a0 000408 18 WAM  0   0  1
File: ./net/unix/garbage.o
File: ./net/unix/sysctl_net_unix.o
File: ./net/unix/af_unix.o
File: ./net/unix/unix.o
File: ./net/unix/built-in.o
File: ./net/xfrm/xfrm_state.o
File: ./net/xfrm/xfrm_ipcomp.o
File: ./net/xfrm/xfrm_hash.o
File: ./net/xfrm/xfrm_input.o
File: ./net/xfrm/xfrm_output.o
File: ./net/xfrm/xfrm_sysctl.o
File: ./net/xfrm/xfrm_replay.o
File: ./net/xfrm/built-in.o
File: ./net/xfrm/xfrm_ipcomp.mod.o
File: ./net/xfrm/xfrm_algo.o
File: ./net/xfrm/xfrm_user.mod.o
File: ./net/xfrm/xfrm_user.o
File: ./net/xfrm/xfrm_policy.o
File: ./net/xfrm/xfrm_algo.mod.o
File: ./net/socket.o
File: ./net/compat.o
File: ./net/sysctl_net.o
File: ./net/built-in.o
  [2988] __jump_table      PROGBITS        0000000000000000 172d10 000e88 18 WAM  0   0  1
File: ./scripts/dtc/dtc.o
File: ./scripts/dtc/flattree.o
File: ./scripts/dtc/fstree.o
File: ./scripts/dtc/data.o
File: ./scripts/dtc/livetree.o
File: ./scripts/dtc/treesource.o
File: ./scripts/dtc/srcpos.o
File: ./scripts/dtc/checks.o
File: ./scripts/dtc/util.o
File: ./scripts/dtc/dtc-parser.tab.o
File: ./scripts/dtc/dtc-lexer.lex.o
File: ./scripts/genksyms/genksyms.o
File: ./scripts/genksyms/parse.tab.o
File: ./scripts/genksyms/lex.lex.o
File: ./scripts/kconfig/conf.o
File: ./scripts/kconfig/zconf.tab.o
File: ./scripts/mod/empty.o
File: ./scripts/mod/sumversion.o
File: ./scripts/mod/modpost.o
File: ./scripts/mod/file2alias.o
File: ./security/keys/built-in.o
File: ./security/keys/gc.o
File: ./security/keys/keyctl.o
File: ./security/keys/permission.o
File: ./security/keys/process_keys.o
File: ./security/keys/request_key.o
File: ./security/keys/request_key_auth.o
File: ./security/keys/user_defined.o
File: ./security/keys/compat.o
File: ./security/keys/proc.o
File: ./security/keys/sysctl.o
File: ./security/keys/key.o
File: ./security/keys/keyring.o
File: ./security/commoncap.o
File: ./security/min_addr.o
File: ./security/lsm_audit.o
File: ./security/device_cgroup.o
File: ./security/built-in.o
File: ./usr/initramfs_data.o
File: ./usr/built-in.o
File: ./virt/kvm/vfio.o
File: ./virt/kvm/eventfd.o
  [14] __jump_table      PROGBITS        0000000000000000 001ec2 000018 18 WAM  0   0  1
File: ./virt/kvm/kvm_main.o
  [151] __jump_table      PROGBITS        0000000000000000 00bcf0 000060 18 WAM  0   0  1
File: ./virt/lib/irqbypass.o
File: ./virt/lib/built-in.o
File: ./virt/built-in.o
File: ./vmlinux.o
  [14615] __jump_table      PROGBITS        0000000000000000 d2cd30 00eb08 18 WAM  0   0  1
File: ./.tmp_kallsyms1.o
File: ./.tmp_kallsyms2.o

--Apple-Mail=_30C25DD1-FF6B-4137-800E-C43273DE16C1--
