Message-Id: <200302261329.OAA20902@hzsms01.nl.lucent.com>
Date: Wed, 26 Feb 2003 14:29:54 +0100 (MET)
From: Jaap-Jan Boor <jjboor@lucent.com>
Reply-To: Jaap-Jan Boor <jjboor@lucent.com>
Subject: Re: MTD problem for Intel Flash
To: rshen@udtech.com.cn
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Shenrong,

I have the same problem. I solved it by making a rather ugly
patch. I changed the 8xx reset vector code to first put flash
in Ready state (reset the flash state machine by writing 0x5050)

Jaap-Jan

>
> Hi,
>
> I met a problem when using JFFS2/MTD with Intel CFI Flash.I mount
> JFFS2 fs on a MTD partition and copy a file to JFFS2 fs, then umount
> the JFFS2 fs and reboot the system. The bootloader(PPCBoot) crashes
> around the first instruction. I check the Flash with BDI, and find the Flash
> in
> the Status state(i.e. 0x00800080). The Intel CFI Flash is supported in file
> cfi_cmdset_0001.c. After the read/write/erase operations, the Flash is not
> reset to Ready state(what I think is for increasing the performance). This
> doesn't
> happen with AMD CFI Flash(impled in cfi_cmdset_0002.c). Even the umount
> operation(with cfi_intelext_sync() called ) won't reset the Flash to Ready
> state.
> So run from Flash after reboot won't success except Hard reset.
>
> I think the Flash should be reset to Ready state at least in
> cfi_intelext_sync(), which
> will be called whenever the MTD partition is closed. Maybe I have missed
> sth.
> Any ideas? Thanks.
>
> Shenrong
>
>
>

---
J.G.J. Boor
Lucent Technologies Nederland b.v.	Room:  BE-525
Optical Networking Group TMS Data 	Phone: +31 (0)35 687 4721
Larenseweg 50, P.O. Box 1168, 		Fax:   +31 (0)35 687 5976
1200 BD, Hilversum, The Netherlands	mailto:jjboor@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
