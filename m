Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <tschaefer@giga-stream.de>
From: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <tschaefer@giga-stream.de>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: fw_setenv problem when calling from expect script
Date: Tue, 8 Jun 2004 14:20:27 +0200
Message-ID: <FIEJJAKAABLMHFKFECNJCEHIHBAA.tschaefer@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using MVL 3.0 (kernel 2.4.18) on a PPC 405GPr custom board. Flash memory
on the board is located in 2 AMD641DH flash chips, which are concatenated on
the mtd layer to one large flash memory area. The flash is divided into 5
partitions (bootloader u-boot, 2 bootloader environment partitions, kernel,
rootfs).

When using the fw_setenv tool that comes with u-boot on the linux console, I
can write the bootloader environment sectors without problems. When calling
fw_setenv from an expect script, which also does some write accesses on the
rootfs partition, I get the following error message when trying to write the
bootloader environmen afterwards:

[root@SERVICE update]# Set the bootloader to flash mode ...
/mnt/install/fw_setenv  "rootfs flash" "kernel flash"
"serverip 192.10.11.95" "ipaddr 10.0.3.14"  "netmask 255.255.255.0"
"gatewayip 10.0.3.25"
Unlocking flash ... Done
Erasing old environment ... Done
CRC write error on /dev/mtd1: Input/output error
Error: can't write fw_env to flash
Writing environment to /dev/mtd1 ... [root@SERVICE update]# ... Timeout.
(child process exited abnormally)

The respective environment sector has been erased, but writing the new
environment didn't work.

If I insert a 'sync' command between writing on the rootfs partition and the
fw_setenv call, writing of the environment sector works, but this is not
really a solution???

When trying the same procedure on another custom board with PPC405GP but
only one flash device and same partition scheme (no concatenation
necessary), everything works without a problem.

Any ideas, comments?

Best regards,

Thomas Schäfer

____________________________________

GIGA STREAM GmbH

Konrad-Zuse-Str. 7
66115 Saarbrücken

Tel.: + 49 (0)681 / 95916 - 203
Fax:  + 49 (0)681 / 95916 - 100
E-mail: tschaefer@giga-stream.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
