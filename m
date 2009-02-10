Return-Path: <tobias.knutsson@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 58AFCDDDA9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 00:07:56 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2552971wfd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 05:07:54 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 10 Feb 2009 14:07:54 +0100
Message-ID: <ccb913ac0902100507x69113827m757f3b8fbd0ac6f4@mail.gmail.com>
Subject: writel hangs system
From: Tobias Knutsson <tobias.knutsson@gmail.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm in the process of porting a PCI-driver for a dsp-board from 2.4 to
2.6. The probing of the driver goes well, IRQs are setup, resources
are claimed and remapped without any problems. Reading from I/O
regions also works well. However, when i try to read or write to a
memory region using readl/writel, the system instantly hangs. No
stacktrace or anything, it just stops.

My question is what could cause the writel operation to hang the
system? As far as I can tell, writel is a macro that expands to:

*(volatile unsigned int*)(addr) =3D val;

The addresses returned by io_remap are as follows:

[   13.200287] c64x.c: probing C64X board at pci slot 0000:00:17.0
[   13.206263] c64x.c: BAR0: (0x52000000-0x523fffff) 0x21208
[   13.211705] c64x.c: BAR1: (0x50000000-0x507fffff) 0x20200
[   13.217152] c64x.c: BAR2: (0x1000-0x100f) 0x20101
[   13.221899] c64x.c: BAR3: (0x0-0x0) 0x0
[   13.225787] c64x.c: BAR4: (0x0-0x0) 0x0
[   13.229670] c64x.c: BAR5: (0x0-0x0) 0x0
[   13.233765] BAR0 mapped to c9100000
[   13.237622] BAR1 mapped to c9580000
[   13.241286] c64x.c: board c64x0 registered
[   13.248924] c64x.c: probing C64X board at pci slot 0000:00:18.0
[   13.254888] c64x.c: BAR0: (0x52400000-0x527fffff) 0x21208
[   13.260328] c64x.c: BAR1: (0x50800000-0x50ffffff) 0x20200
[   13.265776] c64x.c: BAR2: (0x1010-0x101f) 0x20101
[   13.270528] c64x.c: BAR3: (0x0-0x0) 0x0
[   13.274415] c64x.c: BAR4: (0x0-0x0) 0x0
[   13.278302] c64x.c: BAR5: (0x0-0x0) 0x0
[   13.282389] BAR0 mapped to c9e00000
[   13.286250] BAR1 mapped to ca280000
[   13.289845] c64x.c: board c64x1 registered
[   13.297468] c64x.c: probing C64X board at pci slot 0000:00:19.0
[   13.303434] c64x.c: BAR0: (0x52800000-0x52bfffff) 0x21208
[   13.308885] c64x.c: BAR1: (0x51000000-0x517fffff) 0x20200
[   13.314328] c64x.c: BAR2: (0x1020-0x102f) 0x20101
[   13.319079] c64x.c: BAR3: (0x0-0x0) 0x0
[   13.322966] c64x.c: BAR4: (0x0-0x0) 0x0
[   13.326855] c64x.c: BAR5: (0x0-0x0) 0x0
[   13.330939] BAR0 mapped to cab00000
[   13.334797] BAR1 mapped to caf80000
[   13.338392] c64x.c: board c64x2 registered
[   13.346017] c64x.c: probing C64X board at pci slot 0000:00:1a.0
[   13.351983] c64x.c: BAR0: (0x52c00000-0x52ffffff) 0x21208
[   13.357435] c64x.c: BAR1: (0x51800000-0x51ffffff) 0x20200
[   13.362877] c64x.c: BAR2: (0x1030-0x103f) 0x20101
[   13.367627] c64x.c: BAR3: (0x0-0x0) 0x0
[   13.371521] c64x.c: BAR4: (0x0-0x0) 0x0
[   13.375409] c64x.c: BAR5: (0x0-0x0) 0x0
[   13.379489] BAR0 mapped to cb800000
[   13.383355] BAR1 mapped to cbc80000
[   13.386953] c64x.c: board c64x3 registered

The system is MPC5200b-based. lspci is not available, but the
resources are located in the following manner:

# cat /sys/bus/pci/devices/0000\:00\:17.0/resource
0x0000000052000000 0x00000000523fffff 0x0000000000021208
0x0000000050000000 0x00000000507fffff 0x0000000000020200
0x0000000000001000 0x000000000000100f 0x0000000000020101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
# cat /sys/bus/pci/devices/0000\:00\:18.0/resource
0x0000000052400000 0x00000000527fffff 0x0000000000021208
0x0000000050800000 0x0000000050ffffff 0x0000000000020200
0x0000000000001010 0x000000000000101f 0x0000000000020101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
# cat /sys/bus/pci/devices/0000\:00\:19.0/resource
0x0000000052800000 0x0000000052bfffff 0x0000000000021208
0x0000000051000000 0x00000000517fffff 0x0000000000020200
0x0000000000001020 0x000000000000102f 0x0000000000020101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
# cat /sys/bus/pci/devices/0000\:00\:1a.0/resource
0x0000000052c00000 0x0000000052ffffff 0x0000000000021208
0x0000000051800000 0x0000000051ffffff 0x0000000000020200
0x0000000000001030 0x000000000000103f 0x0000000000020101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000


--=20

H=E4lsningar/Regards
Tobias Knutsson
