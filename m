To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Merge of dmasound back-port and BK 2.4.1p4 dmasound driver
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 20 Jan 2001 13:12:26 +0100
Message-ID: <4v3deewhg5.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Iain,

thanks for the new version of dmasound. I went through the tests with
stest you suggest and all passed well on my pismo. However I had one
kernel oops which is listed below if you can find any useful info from
it. I tried with more recent ksymoops, the warnings about reliability
are still there and the report is different.
cheers
        Jiri

PowerMac (AWACS rev 3 [screamer]) DMA sound driver:
Hardware supported formats: [signed 16 bit BE]
Hardware supports the following sample rates:
44100 22050
current settings:
sound.format = 0x20 (signed 16 bit BE)(Phys: signed 16 bit BE)
  sound.speed = 44100Hz (phys. 44100Hz)
  sound.stereo = 0x1 (stereo)
  write_sq.block_size = 16384 write_sq.max_count = 4
  write_sq.max_active = 2
  write_sq.count = 2 write_sq.rear_size = 16384
  write_sq.active = 2 write_sq.syncing = 0
  read_sq.block_size = 16384 read_sq.max_count = 0 read_sq.max_active
= 2
  read_sq.count = 0 read_sq.rear_size = 0
  read_sq.active = 0 read_sq.syncing = 0

Linux version 2.4.1-pre8 (root@pceple53) (gcc version 2.95.3 20010101
(prerelease)) #1 Fri Jan 19 21:25:45 CET 2001

ksymoops 2.3.4 on ppc 2.4.1-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre8/ (default)
     -m /boot/System.map-2.4.1-pre8 (specified)

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000c2e8, System.map says c0006874.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol awacs_device_id  , dmasound_pmac says c581be48, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c168.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol bs_val  , dmasound_pmac says c581be1c, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c13c.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol has_iic  , dmasound_pmac says c581be50, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c170.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol has_perch  , dmasound_pmac says c581be4c, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c16c.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol is_burgundy  , dmasound_pmac says c581be44, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c164.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol is_screamer  , dmasound_pmac says c581be40, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c160.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol needs_amp_switch_on  , dmasound_pmac says c581be54, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c581c174.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol dmasound_catchRadius  , dmasound_core says c5813770, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_core.o says c5813794.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_core.o entry
Warning (compare_maps): mismatch on symbol entry_lock  , hfs says c590638c, /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o says c5906c90.  Ignoring /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o entry
Warning (compare_maps): mismatch on symbol hfs_version  , hfs says c5906390, /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o says c5906c94.  Ignoring /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o entry
Jan 19 22:48:43 pceple53 kernel: Oops: kernel access of bad area, sig: 11
Jan 19 22:48:43 pceple53 kernel: NIP: C58183DC XER: 00000000 LR: C58183B0 SP: C3747E00 REGS: c3747d50 TRAP: 0300
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
Jan 19 22:48:43 pceple53 kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan 19 22:48:43 pceple53 kernel: TASK = c3746000[1213] 'plaympeg' Last syscall: 54
Jan 19 22:48:43 pceple53 kernel: last math c3746000 last altivec 00000000
Jan 19 22:48:43 pceple53 kernel: GPR00: 00000004 C3747E00 C3746000 C370F6A0 C01C0000 00002030 00000000 C5810000
Jan 19 22:48:43 pceple53 kernel: GPR08: C5813B7C 00000000 00000000 00000000 02000000 1001B510 00000000 00000000
Jan 19 22:48:43 pceple53 kernel: GPR16: 00000000 00000000 00000000 10010000 00009032 03747E80 00000000 C00042B0
Jan 19 22:48:43 pceple53 kernel: GPR24: C0003FE0 10002DB8 7FFFF268 00000002 C5813B20 C5810000 7FFFEE38 C370F6A0
Jan 19 22:48:43 pceple53 kernel: Call backtrace:
Jan 19 22:48:43 pceple53 kernel: C0644760 C58116DC C5812524 C004D760 C000403C 0FED6814 0FF0FBEC
Jan 19 22:48:43 pceple53 kernel: 0FF1008C 0FF0CC6C 0FF90734 0FF8A96C 0FF898EC 0FF89718 0FF8FE7C
Jan 19 22:48:43 pceple53 kernel: 10002690 0FD5CCC8 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c58183dc <[dmasound_pmac]PMacReadSqSetup+60/154>   <=====
Trace; c0644760 <_end+3fab70/55c4470>
Trace; c58116dc <[dmasound_core]sq_setup+70/80>
Trace; c5812524 <[dmasound_core]sq_ioctl+660/740>
Trace; c004d760 <sys_ioctl+268/28c>
Trace; c000403c <ret_from_syscall_1+0/b4>
Trace; 0fed6814 Before first symbol
Trace; 0ff0fbec Before first symbol
Trace; 0ff1008c Before first symbol
Trace; 0ff0cc6c Before first symbol
Trace; 0ff90734 Before first symbol
Trace; 0ff8a96c Before first symbol
Trace; 0ff898ec Before first symbol
Trace; 0ff89718 Before first symbol
Trace; 0ff8fe7c Before first symbol
Trace; 10002690 Before first symbol
Trace; 0fd5ccc8 Before first symbol
Trace; 00000000 Before first symbol


12 warnings issued.  Results may not be reliable.

ksymoops 2.3.7 on ppc 2.4.1-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre8/ (default)
     -m /boot/System.map-2.4.1-pre8 (specified)

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000c2e8, System.map says c0006874.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol entry_lock  , hfs says c591c38c, /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o says c591cc90.  Ignoring /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o entry
Warning (compare_maps): mismatch on symbol hfs_version  , hfs says c591c390, /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o says c591cc94.  Ignoring /lib/modules/2.4.1-pre8/kernel/fs/hfs/hfs.o entry
Warning (compare_maps): mismatch on symbol awacs_device_id  , dmasound_pmac says c5902e48, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c5903168.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol bs_val  , dmasound_pmac says c5902e1c, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c590313c.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol has_iic  , dmasound_pmac says c5902e50, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c5903170.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol has_perch  , dmasound_pmac says c5902e4c, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c590316c.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol is_burgundy  , dmasound_pmac says c5902e44, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c5903164.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol is_screamer  , dmasound_pmac says c5902e40, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c5903160.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol needs_amp_switch_on  , dmasound_pmac says c5902e54, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o says c5903174.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_pmac.o entry
Warning (compare_maps): mismatch on symbol dmasound_catchRadius  , dmasound_core says c58fa770, /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_core.o says c58fa794.  Ignoring /lib/modules/2.4.1-pre8/kernel/drivers/sound/dmasound/dmasound_core.o entry
Jan 19 22:48:43 pceple53 kernel: Oops: kernel access of bad area, sig: 11
Jan 19 22:48:43 pceple53 kernel: NIP: C58183DC XER: 00000000 LR: C58183B0 SP: C3747E00 REGS: c3747d50 TRAP: 0300
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
Jan 19 22:48:43 pceple53 kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Jan 19 22:48:43 pceple53 kernel: TASK = c3746000[1213] 'plaympeg' Last syscall: 54
Jan 19 22:48:43 pceple53 kernel: last math c3746000 last altivec 00000000
Jan 19 22:48:43 pceple53 kernel: GPR00: 00000004 C3747E00 C3746000 C370F6A0 C01C0000 00002030 00000000 C5810000
Jan 19 22:48:43 pceple53 kernel: GPR08: C5813B7C 00000000 00000000 00000000 02000000 1001B510 00000000 00000000
Jan 19 22:48:43 pceple53 kernel: GPR16: 00000000 00000000 00000000 10010000 00009032 03747E80 00000000 C00042B0
Jan 19 22:48:43 pceple53 kernel: GPR24: C0003FE0 10002DB8 7FFFF268 00000002 C5813B20 C5810000 7FFFEE38 C370F6A0
Jan 19 22:48:43 pceple53 kernel: Call backtrace:
Jan 19 22:48:43 pceple53 kernel: C0644760 C58116DC C5812524 C004D760 C000403C 0FED6814 0FF0FBEC
Jan 19 22:48:43 pceple53 kernel: 0FF1008C 0FF0CC6C 0FF90734 0FF8A96C 0FF898EC 0FF89718 0FF8FE7C
Jan 19 22:48:43 pceple53 kernel: 10002690 0FD5CCC8 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c58183dc <_end+55ce7ec/56ab470>   <=====
Trace; c0644760 <_end+3fab70/56ab470>
Trace; c58116dc <_end+55c7aec/56ab470>
Trace; c5812524 <_end+55c8934/56ab470>
Trace; c004d760 <sys_ioctl+268/28c>
Trace; c000403c <ret_from_syscall_1+0/b4>
Trace; 0fed6814 Before first symbol
Trace; 0ff0fbec Before first symbol
Trace; 0ff1008c Before first symbol
Trace; 0ff0cc6c Before first symbol
Trace; 0ff90734 Before first symbol
Trace; 0ff8a96c Before first symbol
Trace; 0ff898ec Before first symbol
Trace; 0ff89718 Before first symbol
Trace; 0ff8fe7c Before first symbol
Trace; 10002690 Before first symbol
Trace; 0fd5ccc8 Before first symbol
Trace; 00000000 Before first symbol


12 warnings issued.  Results may not be reliable.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
