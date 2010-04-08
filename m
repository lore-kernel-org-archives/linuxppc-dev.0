Return-Path: <canella.fe@gmail.com>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218]) by ozlabs.org (Postfix) with ESMTP id A1B2AB7CF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Apr 2010 18:58:20 +1000 (EST)
Received: by bwz10 with SMTP id 10so1558287bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Apr 2010 01:58:17 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Apr 2010 10:58:16 +0200
Message-ID: <i2sd5c0c6721004080158hd55e45abl1b13e8a8cb746172@mail.gmail.com>
Subject: Big file copy problem
From: Matteo Canella <canella.fe@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I found out this strange behavior on my system.

I=92m working on an embedded device with a linux kernel 2.6.24.6, we=92re
using a modified =C5ngstr=F6m distribution with BusyBox v1.13.2



I=92m having problem when I try to copy files larger than 52 Megabytes.
The system hangs and I have a kernel panic.



If I create a 52 megs file:

# dd if=3D/dev/zero of=3Da.log bs=3D1M count=3D52

52+0 records in

52+0 records out



# ls -lh

-rw-r--r- 1 root root 52.0M Apr 7 09:32 a.log



# cp a.log b.log

# ls lh

-rw-r--r- 1 root root 52.0M Apr 7 09:32 a.log

rw-r--r- 1 root root 52.0M Apr 7 09:33 b.log



and this is good.

Now if a try with a larger file:

# dd if=3D/dev/zero of=3Da.log bs=3D1M count=3D53



And try to copy it:



# cp a.log b.log

[ 2130.744406] Bad page state in process 'cp'

[ 2130.744422] page:c060f2a0 flags:0x00000000 mapping:00000000
mapcount:1 count:0 [ 2130.744433] Trying to fix it up, but a reboot is
needed [ 2130.744443] Backtrace:

[ 2130.764626] Call Trace:

[ 2130.770277] [cd04bae0] [c000803c]=A0 (unreliable) [ 2130.778301]
[cd04bb20] [c0050e44] [ 2130.782140] [cd04bb30] [c0051da8] [
2130.788572] [cd04bba0] [c0051ee0] [ 2130.795085] [cd04bc00]
[c004bd88] [ 2130.798925] [cd04bc30] [c00de4b4] [ 2130.805376]
[cd04bca0] [c004cf54] [ 2130.809206] [cd04bd30] [c004d734] [
2130.815687] [cd04bda0] [c004da20] [ 2130.822253] [cd04bdd0]
[c00dd158] [ 2130.826090] [cd04be30] [c00691a0] [ 2130.832440]
[cd04bef0] [c0069b48] [ 2130.836296] [cd04bf10] [c006a134] [
2130.842845] [cd04bf40] [c000fb0c] [ 2130.849256] --- Exception:
c01<0>Bad page state in process 'cp'

[ 2130.858964] page:c060f3e0 flags:0x00000000 mapping:00000000
mapcount:1 count:0 [ 2130.858982] Trying to fix it up, but a reboot is
needed [ 2130.858991] Backtrace:

[ 2130.878082] Call Trace:

[ 2130.883516] [cd04bae0] [c000803c]=A0 (unreliable) [ 2130.891486]
[cd04bb20] [c0050e44] [ 2130.895321] [cd04bb30] [c0051da8] [
2130.901771] [cd04bba0] [c0051ee0] [ 2130.905611] [cd04bc00]
[c004bd88] [ 2130.912044] [cd04bc30] [c00de4b4] [ 2130.915886]
[cd04bca0] [c004cf54] [ 2130.922466] [cd04bd30] [c004d734] [
2130.928907] [cd04bda0] [c004da20] [ 2130.932751] [cd04bdd0]
[c00dd158] [ 2130.939215] [cd04be30] [c00691a0] [ 2130.945655]
[cd04bef0] [c0069b48] [ 2130.949492] [cd04bf10] [c006a134] [
2130.955967] [cd04bf40] [c000fb0c] [ 2130.962463] --- Exception:
c01<1>Unable to handle kernel paging request for data at address
0x00000004 [ 2130.972445] Faulting instruction address: 0xc004fd78 [
2130.977442] Oops: Kernel access of bad area, sig: 11 [#1] [
2130.982879] PREEMPT MPC5121 ADS [ 2130.986044] NIP: c004fd78 LR:
c0050444 CTR: 00000006

[ 2130.991055] REGS: cd04ba10 TRAP: 0300=A0=A0 Tainted: G=A0=A0=A0 B
(2.6.24.6-svn-458:464M)

[ 2130.998687] MSR: 00001032 <ME,IR,DR>=A0 CR: 22222448=A0 XER: 20000000 [
2131.004836] DAR: 00000004, DSISR: 22000000 [ 2131.008964] TASK =3D
cfa57b40[1624] 'cp' THREAD: cd04a000 [ 2131.014056] GPR00: c060f418
cd04bac0 cfa57b40 000000dc c060f400 00000010 00000005 00100100 [
2131.022486] GPR08: c060f418 00000000 00000000 00200200 22222448
100be260 00000000 001200d2 [ 2131.030916] GPR16: c02f7848 00000044
00000000 00000000 00089cf1 00200200 00100100 c02f7054 [ 2131.039347]
GPR24: 00024000 cd04a000 c02f7030 00000000 00000000 00000002 00000000
c02f7030 [ 2131.047954] Call Trace:

[ 2131.050414] [cd04bac0] [00004c00]=A0 (unreliable) [ 2131.054980]
[cd04bad0] [10000000] [ 2131.058404] [cd04bb00] [c0050880] [
2131.061830] [cd04bb30] [c0051dd4] [ 2131.065255] [cd04bba0]
[c0051ee0] [ 2131.068679] [cd04bc00] [c004bd88] [ 2131.072104]
[cd04bc30] [c00de4b4] [ 2131.075529] [cd04bca0] [c004cf54] [
2131.078954] [cd04bd30] [c004d734] [ 2131.082379] [cd04bda0]
[c004da20] [ 2131.085804] [cd04bdd0] [c00dd158] [ 2131.089229]
[cd04be30] [c00691a0] [ 2131.092654] [cd04bef0] [c0069b48] [
2131.096078] [cd04bf10] [c006a134] [ 2131.099504] [cd04bf40]
[c000fb0c] [ 2131.102928] --- Exception: c01Instruction dump:

[ 2131.107495] 38210010 4e800020 7d251a14 3ce00010 7d29fa14 3d600020
81090040 60e70100 [ 2131.115309] 616b0200 3888ffe8 8144001c 81240018
<91490004> 912a0000 7d43fa14 9164001c [ 2131.123314] ---[ end trace
ae01d3c49bf93795 ]--- [ 2131.127959] note: cp[1624] exited with
preempt_count 2 [ 2131.133311] BUG: scheduling while atomic:
cp/1624/0x10000003 [ 2131.138978] Call Trace:

[ 2131.141426] [cd04b7f0] [c000803c]=A0 (unreliable) [ 2131.145979]
[cd04b830] [c001abf0] [ 2131.149403] [cd04b840] [c0275744] [
2131.152829] [cd04b880] [c001ae20] [ 2131.156253] [cd04b890]
[c0275d60] [ 2131.159678] [cd04b8a0] [c005b95c] [ 2131.163103]
[cd04b920] [c005f45c] [ 2131.166528] [cd04b950] [c001d848] [
2131.169953] [cd04b960] [c0021a74] [ 2131.173378] [cd04b980]
[c00236f0] [ 2131.176825] [cd04b9c0] [c000dad4] [ 2131.180227]
[cd04b9f0] [c0012540] [ 2131.183653] [cd04ba00] [c000ffac] [
2131.187076] --- Exception: 300[cd04bac0] [00004c00]=A0 (unreliable) [
2131.193225] [cd04bad0] [10000000] [ 2131.196661] [cd04bb00]
[c0050880] [ 2131.200074] [cd04bb30] [c0051dd4] [ 2131.203501]
[cd04bba0] [c0051ee0] [ 2131.206924] [cd04bc00] [c004bd88] [
2131.210349] [cd04bc30] [c00de4b4] [ 2131.213774] [cd04bca0]
[c004cf54] [ 2131.217199] [cd04bd30] [c004d734] [ 2131.220624]
[cd04bda0] [c004da20] [ 2131.224048] [cd04bdd0] [c00dd158] [
2131.227474] [cd04be30] [c00691a0] [ 2131.230899] [cd04bef0]
[c0069b48] [ 2131.234324] [cd04bf10] [c006a134] [ 2131.237748]
[cd04bf40] [c000fb0c] [ 2131.241173] --- Exception: c01<1>Unable to
handle kernel paging request for data at address 0x00000004 [
2131.251024] Faulting instruction address: 0xc004fd78 [ 2131.256035]
Oops: Kernel access of bad area, sig: 11 [#2] [ 2131.261470] PREEMPT
MPC5121 ADS [ 2131.264635] NIP: c004fd78 LR: c0050444 CTR: 00000006

[ 2131.269646] REGS: cfbb7be0 TRAP: 0300=A0=A0 Tainted: G=A0=A0=A0 B D
(2.6.24.6-svn-458:464M)

[ 2131.277279] MSR: 00001032 <ME,IR,DR>=A0 CR: 22222448=A0 XER: 20000000 [
2131.283427] DAR: 00000004, DSISR: 22000000 [ 2131.287556] TASK =3D
cfb123c0[410] 'watchdog' THREAD: cfbb6000 [ 2131.293086] GPR00:
c060f418 cfbb7c90 cfb123c0 000000dc c060f400 00000010 00000005
00100100 [ 2131.301516] GPR08: c060f418 00000000 00000000 00200200
22228448 10029a9c 00000000 001200d2 [ 2131.309947] GPR16: c02f7848
00000044 00000000 00000000 00089cf1 00200200 00100100 c02f7054 [
2131.318378] GPR24: 00024000 cfbb6000 c02f7030 00000000 00000000
00000002 00000000 c02f7030 [ 2131.326984] Call Trace:

[ 2131.329444] [cfbb7c90] [c0084610]=A0 (unreliable) [ 2131.334010]
[cfbb7ca0] [cf9fb680] [ 2131.337435] [cfbb7cd0] [c0050880] [
2131.340860] [cfbb7d00] [c0051cc8] [ 2131.344284] [cfbb7d70]
[c0051ee0] [ 2131.347710] [cfbb7dd0] [c005ab60] [ 2131.351135]
[cfbb7e10] [c00128e8] [ 2131.354559] [cfbb7f40] [c000ff3c] [
2131.357984] --- Exception: 301Instruction dump:

[ 2131.362550] 38210010 4e800020 7d251a14 3ce00010 7d29fa14 3d600020
81090040 60e70100 [ 2131.370366] 616b0200 3888ffe8 8144001c 81240018
<91490004> 912a0000 7d43fa14 9164001c [ 2131.378361] ---[ end trace
ae01d3c49bf93795 ]--- [ 2131.383014] note: watchdog[410] exited with
preempt_count 2 [ 2131.388650] Eeek! page_mapcount(page) went
negative! (-1)

[ 2131.394077]=A0=A0 page pfn =3D 30f

[ 2131.396975]=A0=A0 page->flags =3D 4

[ 2131.399960]=A0=A0 page->count =3D ffffffff

[ 2131.403562]=A0=A0 page->mapping =3D 00000000

[ 2131.407357] ------------[ cut here ]------------ [ 2131.411993]
Kernel BUG at c0062ac8 [verbose debug info unavailable] [ 2131.418320]
Oops: Exception in kernel mode, sig: 5 [#3] [ 2131.423583] PREEMPT
MPC5121 ADS [ 2131.426748] NIP: c0062ac8 LR: c0062ac8 CTR: c015564c

[ 2131.431755] REGS: cfbb79b0 TRAP: 0700=A0=A0 Tainted: G=A0=A0=A0 B D
(2.6.24.6-svn-458:464M)

[ 2131.439391] MSR: 00021032 <ME,IR,DR>=A0 CR: 24224422=A0 XER: 00000000 [
2131.445540] TASK =3D cfb123c0[410] 'watchdog' THREAD: cfbb6000 [
2131.451070] GPR00: c0062ac8 cfbb7a60 cfb123c0 0000002d 00005159
ffffffff c0318eb8 00004000 [ 2131.459502] GPR08: d1010b90 00000000
00005159 d1010b00 84224422 10029a9c 00103000 cfaa9000 [ 2131.467932]
GPR16: c0310000 cfb0b000 cfaa9000 cfb20340 c0315584 00000000 ffffffff
00000000 [ 2131.476362] GPR24: 00103000 0030f305 00007000 cfbb6000
00101000 fffffffd c05091e0 c05091e0 [ 2131.484968] Call Trace:

[ 2131.487428] [cfbb7a60] [c0062ac8]=A0 (unreliable) [ 2131.491995]
[cfbb7a70] [c005b630] [ 2131.495420] [cfbb7af0] [c005f45c] [
2131.498845] [cfbb7b20] [c001d848]



And it continues to reset and print kernel oops.

This happens in all the partitions we have (an UBI partition on a NAND
flash device, on an USB stick FAT formatted or on the NFS filesistem).


Anyone can help me on this problem?
Are there any known issues?

Thank you very much.

=A0Matteo Canella
