Message-ID: <000b01c2dd98$a7811fa0$11f196d3@justin>
From: "Shenrong" <rshen@udtech.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MTD problem for Intel Flash
Date: Wed, 26 Feb 2003 21:12:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I met a problem when using JFFS2/MTD with Intel CFI Flash.I mount
JFFS2 fs on a MTD partition and copy a file to JFFS2 fs, then umount
the JFFS2 fs and reboot the system. The bootloader(PPCBoot) crashes
around the first instruction. I check the Flash with BDI, and find the Flash
in
the Status state(i.e. 0x00800080). The Intel CFI Flash is supported in file
cfi_cmdset_0001.c. After the read/write/erase operations, the Flash is not
reset to Ready state(what I think is for increasing the performance). This
doesn't
happen with AMD CFI Flash(impled in cfi_cmdset_0002.c). Even the umount
operation(with cfi_intelext_sync() called ) won't reset the Flash to Ready
state.
So run from Flash after reboot won't success except Hard reset.

I think the Flash should be reset to Ready state at least in
cfi_intelext_sync(), which
will be called whenever the MTD partition is closed. Maybe I have missed
sth.
Any ideas? Thanks.

Shenrong


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
