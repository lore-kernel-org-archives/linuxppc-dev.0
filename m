Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdjD205DDzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 16:45:22 +1000 (AEST)
Date: Mon, 4 Apr 2016 16:44:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras
 <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: PR KVM and TM issues
Message-ID: <20160404164457.539a55f0@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I can't get an Ubuntu Wily guest to boot on an Ubuntu Wily host in PR KVM
mode. The kernel in both cases is 4.2. To reproduce:

wget -N https://cloud-images.ubuntu.com/wily/current/wily-server-cloudimg-ppc64el-disk1.img

qemu-system-ppc64 -cpu POWER8 -enable-kvm -machine pseries,kvm-type=PR -m 4G -nographic -vga none -drive file=wily-server-cloudimg-ppc64el-disk1.img,if=virtio

Should TM work inside a PR KVM guest?

Anton
--

[    1.662872] zswap: using lzo compressor
[    1.674628] Facility 'TM' unavailable, exception at 0x3fffb540c054, MSR=b00000014000d033
[    1.674684] modprobe[49]: unhandled signal 4 at 00003fffb540c054 nip 00003fffb540c054 lr 00003fffb540c138 code 30001
[    1.682516] Facility 'TM' unavailable, exception at 0x3fff9d32c054, MSR=b00000014280f033
[    1.682571] modprobe[51]: unhandled signal 4 at 00003fff9d32c054 nip 00003fff9d32c054 lr 00003fff9d32c138 code 30001
[    1.686893] Key type trusted registered
[    1.693929] Facility 'TM' unavailable, exception at 0x3fffa868c054, MSR=b00000014280f033
[    1.693983] modprobe[55]: unhandled signal 4 at 00003fffa868c054 nip 00003fffa868c054 lr 00003fffa868c138 code 30001
[    1.701959] Facility 'TM' unavailable, exception at 0x3fff87fbc054, MSR=b00000014280f033
[    1.702016] modprobe[57]: unhandled signal 4 at 00003fff87fbc054 nip 00003fff87fbc054 lr 00003fff87fbc138 code 30001
[    1.710380] sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x cd/rw xa/form2 cdda tray
[    1.710435] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.710659] sr 0:0:2:0: Attached scsi generic sg0 type 5
[    1.713262] Facility 'TM' unavailable, exception at 0x3fff787fc054, MSR=b00000014280f033
[    1.713319] modprobe[61]: unhandled signal 4 at 00003fff787fc054 nip 00003fff787fc054 lr 00003fff787fc138 code 30001
[    1.716327] Facility 'TM' unavailable, exception at 0x3fff8d2cc054, MSR=b00000014280f033
[    1.716381] modprobe[63]: unhandled signal 4 at 00003fff8d2cc054 nip 00003fff8d2cc054 lr 00003fff8d2cc138 code 30001
[    1.716830] Key type encrypted registered
[    1.716867] AppArmor: AppArmor sha1 policy hashing enabled
[    1.716903] ima: No TPM chip found, activating TPM-bypass!
[    1.716950] evm: HMAC attrs: 0x1
[    1.717134] hctosys: unable to open rtc device (rtc0)
[    1.718082] Freeing unused kernel memory: 6016K (c000000000e30000 - c000000001410000)
[    1.720662] Facility 'TM' unavailable, exception at 0x3fffa9141d00, MSR=b00000014280f033
[    1.720718] init[1]: unhandled signal 4 at 00003fffa9141d00 nip 00003fffa9141d00 lr 0000000010005f34 code 30001
[    1.721092] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[    1.721092] 
[    1.721154] CPU: 0 PID: 1 Comm: init Not tainted 4.2.0-18-generic #22-Ubuntu
[    1.721199] Call Trace:
[    1.721219] [c0000000fe963a50] [c000000000aa3d68] dump_stack+0x90/0xbc (unreliable)
[    1.721272] [c0000000fe963a80] [c000000000aa0028] panic+0x100/0x2b0
[    1.721320] [c0000000fe963b10] [c0000000000b98bc] do_exit+0xc3c/0xc40
[    1.721363] [c0000000fe963be0] [c0000000000b99a4] do_group_exit+0x64/0x100
[    1.721409] [c0000000fe963c20] [c0000000000cab5c] get_signal+0x52c/0x770
[    1.721455] [c0000000fe963d10] [c000000000017274] do_signal+0x54/0x2b0
[    1.721501] [c0000000fe963e00] [c0000000000176bc] do_notify_resume+0xac/0xc0
[    1.721546] [c0000000fe963e30] [c000000000009838] ret_from_except_lite+0x64/0x68
[    1.724068] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
