MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15984.43692.736225.647094@gargle.gargle.HOWL>
Date: Thu, 13 Mar 2003 16:58:36 +0100
From: mikpe@csd.uu.se
To: Olaf Hering <olh@suse.de>
Cc: mikpe@csd.uu.se, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
In-Reply-To: <20030313152506.GB28311@suse.de>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	<20030313152506.GB28311@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:
 >  On Thu, Mar 13, mikpe@csd.uu.se wrote:
 >
 > > vmlinux.coff built from 2.4.20-ben8 fails immediately at boot
 > > on my old-world PowerMac 4400 (OF 2.0.2) with a CLAIM error:
 > >
 > > 0> boot fd:vmlinux.coff root=/dev/hda8 loading XCOFF
 > > tsize=5E40 dsize=C500C bsize=215DC entry=500000
 > > SECTIONS:
 > > .text	00500000 00500000 00005E40 000000D4
 > > .data	00506000 00506000 000C500C 00005F14
 > > .bss	005CB000 005CB000 000215DC 00000000
 > > loading .text, done..
 > > loading .data, done..
 > > clearing .bssCLAIM failed
 >
 > Can you provide the 'printenv' output? Does flushing the pram help?
 > And my patch does fix the 'loading .data' error, your bug is different.
 >
 > Does the vmlinux.coff from http://penguinppc.org/~olaf/2.4.6/ boot?

Yes! Your 2.4.6 vmlinux.coff booted from floppy without problems.

My nvsetenv output is below; all values are at their defaults, except
for the obvious tweaks to auto-boot?, input-device, and output-device.

little-endian?  false
real-mode?      false
auto-boot?      false
diag-switch?    false
fcode-debug?    false
oem-banner?     false
oem-logo?       false
use-nvramrc?    true
real-base       0xffffffff
real-size       0x100000
virt-base       0xffffffff
virt-size       0x100000
load-base       0x4000
pci-probe-list  0xffffffff
screen-#columns 0x64
screen-#rows    0x28
selftest-#megs  0x0
boot-device     /AAPL,ROM
boot-file
diag-device     fd:diags
diag-file
input-device    kbd
output-device   /bandit/ATY,264VT
oem-banner
oem-logo
nvramrc         ' byte-load-file d na+  ' or  blpatch  ' byte-load-file? d na+  ' or  blpatch
boot-command    boot

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
