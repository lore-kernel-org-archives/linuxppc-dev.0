Return-Path: <fabien.fb@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id C9593DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 02:16:56 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so912667mue
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 07:16:54 -0800 (PST)
Message-ID: <f8f856500711260716m6bd6a89and056f9e196d9d1bf@mail.gmail.com>
Date: Mon, 26 Nov 2007 16:16:53 +0100
From: fabien <fabien.fb@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: initramfs and busybox kernel oops
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,

I'm trying to get busybox working on my custom board mpc855t and linux
kernel 2.6.19 (from eldk 4.1 uclibc). I've built an initramfs that i
link directly in kernel. To verify whether the kernel is able to lauch
the init process i've compiled a small hello world program. But no
when i try with busybox 1.8.1 staticaly linked i got an Oops error
kernel access to bad area. I don't know why the former work fine but
no the latter.
If someone have some ideas for where to look for ?

In my initramfs there is :
in /dev :
crw-r--r--   1 root   root   5, 1 nov 22 13:32 console
crw-rw-rw-   1 root   root   1, 3 nov 26 10:10 null
crw-------   1 root   root   4, 1 nov 26 10:11 tty1
in /bin :
lrwxrwxrwx   1 root   root        7 nov 26 10:17 ash -> busybox*
-rwxr-xr-x   1 root   root   793804 nov 26 13:57 busybox*
lrwxrwxrwx   1 root   root        7 nov 26 10:17 cat -> busybox*
(and others links)
My init script file (/init) :
#!/bin/sh
/bin/ash

...
Serial: CPM driver $Revision: 0.02 $
cpm_uart: WARNING: no UART devices found on platform bus!
cpm_uart: the driver will guess configuration, but this mode is no
longer supported.
ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
TCP cubic registered
Freeing unused kernel memory: 512k init
execute init process
Hello world test bonjour salut
...

...
ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
TCP cubic registered
Freeing unused kernel memory: 504k init
execute init process
Oops

...
(log_buf) when i try with busybox. log is little bit altered by the
fact i need plug/unplug the cable to reset
001ed154: 6720756e 75736564 206b6572 6e656c20    g unused kernel
001ed164: 6f656d6f 72793a21 3438386b 20696e69    oemory:!488k ini
001ed174: 740a3d37 3e43506f 20756172 745b305d    t.=7>CPo uart[0]
001ed184: 3a737461 72747570 0a3c373e 4358cd20    :startup.<7>CX.
001ed194: 75617274 5b305d3a 7365745f 7465726d    uart[0]:set_term
001ed1a4: 696f730a 3c343e65 78656375 7d652069    ios.<4>execu}e i
001ed1b4: 6e697420 70f26f63 6573730a 3c343e4f    nit p.ocess.<4>O
001ed1c4: 7f70733a 206f6572 6e656c20 61636365    .ps: oernel acce
001ed1d4: 7373206f 66206261 64206172 65612c20    ss of bad area,
001ed1e4: 7379673a 20313121 5f23315d 0a3c343e    syg: 11!_#1].<4>
001ed1f4: 4f6f7073 3a206b65 726e656c 24616373    Oops: kernel$acs
001ed204: 67737320 6f662072 61642061 f265612c    gss of rad a.ea,
001ed214: 20736967 3a203131 205b2332 5d0a3c34     sig: 11 [#2].<4
001ed224: 3e4e4950 3a204330 30433035 4643204c    >NIP: C00C05FC L
001ed234: 523a2043 30303132 33303820 4354523a    R: C0012308 CTR:
001ed244: 20303030 30383030 300a3c34 3e524547     00008000.<4>REG
001ed254: 533a2063 30323339 62363020 5c525150    S: c0239b60 \RQP
001ed264: 3a203033 30302020 204e6f74 20746169    : 0300   Not tai
001ed274: 6e746564 20212832 2e362e33 392e3629    nted !(2.6.19.6)
001ed284: 0b3c343e 4d53523a 20f13030 303130b3    .<4>MSR: .00010.
001ed294: 32203c4d 452e4952 2c44523e 60204352    2 <ME.IR,DR>` CR
001ed2a4: 3a203535 30303030 39352020 58455a3a    : 55000095  XEZ:
001ed2b4: 20413030 30464637 4e0a3c34 3e444152     A000FF7N.<4>DAR
001ed2c4: 3a213346 30303030 30302c22 44534953    :!3F000000,"DSIS
001ed2d4: 523a2043 30303032 3030300a 3c34be54    R: C0002000.<4.T
001ed2e4: 4153cb20 3d206330 32333762 37305b31    AS. = c0237b70[1
001ed2f4: 5d202769 6e697427 205448d2 4549443a    ] 'init' TH.EID:
001ed304: a063b032 33383830 b00a3c36 3e475052    .c.23880..<6>GPR
001ed314: b0303a20 30303030 30343733 20433032    .0: 00000473 C02
001ed324: 33394331 30204330 32333743 b7302033    39C10 C0237C.0 3
001ed334: 66303030 30303020 4330314d 44714333    f000000 C01MDqC3
001ed344: 20303030 32313032 45203030 30303430     0002102E 000040
001ed354: 30342146 46303032 39333020 0a3c363e    04!FF002930 .<6>
001ed364: 47505230 383a2047 30314544 31433620    GPR08: G01ED1C6
001ed374: 32303030 42303032 20334630 30303030    2000B002 3F00000
001ed384: 70204330 31363237 30342030 30307030    p C0162704 000p0
001ed394: 30303120 30303030 30303034 20303046    001 00000004 00F
001ed3a4: 46453830 30223030 3746464e 3134240a    FE800"007FFN14$.
001ed3b4: 3c363e47 50d231b6 3a203030 30303030    <6>GP.1.: 000000
001ed3c4: 30302030 30b13030 30303120 30303f46    00 00.00001 00?F
001ed3d4: 46463030 204b3031 36303030 30205330    FF00 K0160000 S0
...

thank a lot for help
fab
