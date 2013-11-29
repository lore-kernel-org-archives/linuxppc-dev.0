Return-Path: <Bharat.Bhushan@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 25A542C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 15:38:59 +1100 (EST)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: "agraf@suse.de" <agraf@suse.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Error in frreing hugepages with preemption enabled
Date: Fri, 29 Nov 2013 04:38:43 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07238568@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alex,

I am running KVM guest with host kernel having CONFIG_PREEMPT enabled. With=
 allocated pages things seems to work fine but I uses hugepages for guest I=
 see below prints when "quit" from qemu.

(qemu) QEMU waiting for connection on: telnet:0.0.0.0:4444,server
qemu-system-ppc64: pci_add_option_rom: failed to find romfile "efi-virtio.r=
om"
q
debug_smp_processor_id: 15 callbacks suppressed
BUG: using smp_processor_id() in preemptible [00000000] code: qemu-system-p=
pc/2504
caller is .free_hugepd_range+0xb0/0x21c
CPU: 1 PID: 2504 Comm: qemu-system-ppc Not tainted 3.12.0-rc3-07733-gabf490=
7 #175
Call Trace:
[c0000000fb433400] [c000000000007d38] .show_stack+0x7c/0x1cc (unreliable)
[c0000000fb4334d0] [c0000000005e8ce0] .dump_stack+0x9c/0xf4
[c0000000fb433560] [c0000000002de5ec] .debug_smp_processor_id+0x108/0x11c
[c0000000fb4335f0] [c000000000025e10] .free_hugepd_range+0xb0/0x21c
[c0000000fb433680] [c0000000000265bc] .hugetlb_free_pgd_range+0x2c8/0x3b0
[c0000000fb4337a0] [c0000000000e428c] .free_pgtables+0x14c/0x158
[c0000000fb433840] [c0000000000ef320] .exit_mmap+0xec/0x194
[c0000000fb433960] [c00000000004d780] .mmput+0x64/0x124
[c0000000fb4339e0] [c000000000051f40] .do_exit+0x29c/0x9c8
[c0000000fb433ae0] [c0000000000527c8] .do_group_exit+0x50/0xc4
[c0000000fb433b70] [c0000000000606a0] .get_signal_to_deliver+0x21c/0x5d8
[c0000000fb433c70] [c000000000009b08] .do_signal+0x54/0x278
[c0000000fb433db0] [c000000000009e50] .do_notify_resume+0x64/0x78
[c0000000fb433e30] [c000000000000b44] .ret_from_except_lite+0x70/0x74


This mean that free_hugepd_range() must be called with preemption enabled.
I tried below change and this seems to work fine (I am not having expertise=
 in this area so not sure this is correct way)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d67db4b..6bf8459 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -563,8 +563,10 @@ static void hugetlb_free_pmd_range(struct mmu_gather *=
tlb, pud_t *pud,
                 */
                next =3D addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
 #endif
+               preempt_disable();
                free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
                                  addr, next, floor, ceiling);
+               preempt_enable();
        } while (addr =3D next, addr !=3D end);
=20
        start &=3D PUD_MASK;


Thanks
-Bharat
