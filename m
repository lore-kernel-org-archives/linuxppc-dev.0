Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BF461A1DA7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 08:33:41 +1000 (AEST)
Received: from [192.168.1.139] (ppp-93-104-68-49.dynamic.mnet-online.de
 [93.104.68.49]) by smtp.strato.de (RZmta 37.8 DYNA|AUTH)
 with ESMTPSA id 901001r69MRa2Uo
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 10 Jul 2015 00:27:36 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
To: linuxppc-dev@lists.ozlabs.org
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
Message-ID: <559EF557.4040403@xenosoft.de>
Date: Fri, 10 Jul 2015 00:27:35 +0200
MIME-Version: 1.0
In-Reply-To: <559D653F.2060307@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Many thanks for your help. You're right. It was something wrong with my 
last bisect. I did another bisect. I evaluated the one "sometimes boots" 
with good.

Log:

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git

git bisect start

git bisect good b953c0d234bc72e8489d3bf51a276c5c4ec85345 (Linux 4.1)

git bisect bad d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754 (Linux 4.2-rc1)

Output:

Bisecting: 6261 revisions left to test after this (roughly 13 steps)
[4570a37169d4b44d316f40b2ccc681dc93fedc7b] Merge tag 'sound-4.2-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound

----

git bisect bad

Output:

Bisecting: 3295 revisions left to test after this (roughly 12 steps)
[4e241557fc1cb560bd9e77ca1b4a9352732a5427] Merge tag 'for-linus' of 
git://git.kernel.org/pub/scm/virt/kvm/kvm

----

git bisect bad

Output:

Bisecting: 1625 revisions left to test after this (roughly 11 steps)
[44d21c3f3a2ef2f58b18bda64c52c99e723f3f4a] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6

----

git bisect bad

Output:

Bisecting: 712 revisions left to test after this (roughly 10 steps)
[e75c73ad64478c12b3a44b86a3e7f62a4f65b93e] Merge branch 
'x86-fpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

----

git bisect good

Output:

Bisecting: 343 revisions left to test after this (roughly 9 steps)
[43224b96af3154cedd7220f7b90094905f07ac78] Merge branch 
'timers-core-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

----

git bisect good

Output:

Bisecting: 171 revisions left to test after this (roughly 8 steps)
[056c04ba8bbad4c563c05306cc8a8c66e713f280] crypto: seqiv - Fix module 
unload/reload crash

----

git bisect good

Output:

Bisecting: 85 revisions left to test after this (roughly 7 steps)
[edf18b9108f5025f9e83b2c167c9122954acbc62] crypto: api - Add 
CRYPTO_MINALIGN_ATTR to struct crypto_alg

----

git bisect good

Output:

Bisecting: 41 revisions left to test after this (roughly 6 steps)
[407a2c720556e8e340e06f6a7174f5d6d80cf9ea] Merge branch 
'irq-core-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

----

It didn't boot with the following error messages:

Oops: Kernel access of bad area, sig: 11 [#1]

.sb600_8259_cascade+0x4c/0xac (unreliable)
.kmem_cache_alloc+0x5c/0x1c4 (unreliable)

----

git bisect bad

Output:

Bisecting: 21 revisions left to test after this (roughly 5 steps)
[3b0f95be143bea1aa47beb20134ef82e4e4068dc] irq: Add 
irq_set_chained_handler_and_data()

----

git bisect good

Output:

Bisecting: 12 revisions left to test after this (roughly 4 steps)
[62a993df31f795d87bcb4c6cb005d36f32f6ad55] irqchip: atmel-aic5: Add 
sama5d2 support

----

git bisect good

Output:

Bisecting: 6 revisions left to test after this (roughly 3 steps)
[a614a610ac9b28f195d790d25be72d26f345c53a] genirq: Remove bogus 
restriction in irq_move_mask_irq()

----

It didn't boot with the following error messages:

Oops: Kernel access of bad area, sig: 11 [#1]

.sb600_8259_cascade+0x4c/0xac (unreliable)
.__kernfs_new_node+0x54/0xd8 (unreliable)

----

git bisect bad

Output:

Bisecting: 2 revisions left to test after this (roughly 2 steps)
[0d0b4c866bcce647f40d73efe5e90aeeb079050a] genirq: Introduce struct 
irq_common_data to host shared irq data

----

It didn't boot with the following error messages:

Oops: Kernel access of bad area, sig: 11 [#1]

.sb600_8259_cascade+0x4c/0xac (unreliable)
.schedule+0x74/0x9c (unreliable)

----

git bisect bad

Output:

Bisecting: 0 revisions left to test after this (roughly 1 step)
[77ed42f18edd486e9994ccd1f174076309a6343f] genirq: Prevent crash in 
irq_move_irq()

----

git bisect good

Output:
0d0b4c866bcce647f40d73efe5e90aeeb079050a is the first bad commit
commit 0d0b4c866bcce647f40d73efe5e90aeeb079050a
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Mon Jun 1 16:05:12 2015 +0800

     genirq: Introduce struct irq_common_data to host shared irq data

     With the introduction of hierarchy irqdomain, struct irq_data becomes
     per-chip instead of per-irq and there may be multiple irq_datas
     associated with the same irq. Some per-irq data stored in struct
     irq_data now may get duplicated into multiple irq_datas, and causes
     inconsistent view.

     So introduce struct irq_common_data to host per-irq common data and to
     achieve consistent view among irq_chips.

     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
     Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
     Cc: Tony Luck <tony.luck@intel.com>
     Cc: Bjorn Helgaas <bhelgaas@google.com>
     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
     Cc: Randy Dunlap <rdunlap@infradead.org>
     Cc: Yinghai Lu <yinghai@kernel.org>
     Cc: Borislav Petkov <bp@alien8.de>
     Cc: Jason Cooper <jason@lakedaemon.net>
     Cc: Kevin Cernekee <cernekee@gmail.com>
     Cc: Arnd Bergmann <arnd@arndb.de>
     Cc: Marc Zyngier <marc.zyngier@arm.com>
     Link: 
http://lkml.kernel.org/r/1433145945-789-4-git-send-email-jiang.liu@linux.intel.com
     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:040000 040000 4cb60e0b1d4beb046834e75c66b5d0a0613935b9 
df0b465b70ec087560482267cca2d9ff54d92c49 M    include
:040000 040000 3808922cd797449f8f9b33300064a2ff1727f3a6 
25a75bf65be0ba9e397151de0ed1beb1695fddb2 M    kernel

----

Rgds,

Christian
