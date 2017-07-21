Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDCZb5mYVzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 11:18:31 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6L1GORi037274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 21:18:29 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu259vbmg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 21:18:29 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Thu, 20 Jul 2017 22:18:26 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6L1IPlO17039494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 22:18:25 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6L1IP1b002593
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 22:18:25 -0300
Date: Thu, 20 Jul 2017 22:18:18 -0300
From: joserz@linux.vnet.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, oohall@gmail.com
Subject: Re: KVM guests freeze under upstream kernel
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca>
 <20170720052159.GB8602@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170720052159.GB8602@fergus.ozlabs.ibm.com>
Message-Id: <20170721011818.GC13187@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 03:21:59PM +1000, Paul Mackerras wrote:
> On Thu, Jul 20, 2017 at 12:02:23AM -0300, joserz@linux.vnet.ibm.com wrote:
> > On Thu, Jul 20, 2017 at 09:42:50AM +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2017-07-19 at 16:46 -0300, joserz@linux.vnet.ibm.com wrote:
> > > > Hello!
> > > > 
> > > > We're not able to boot any KVM guest using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4.13.0-rc1+).
> > > > After reaching the SLOF initial counting, the guest simply freezes:
> > > 
> > > Can you send our .config ?
> > 
> > Sure,
> > 
> > Answering Michael as well:
> > 
> > It's a P9 with RHEL kernel 4.11.0-10.el7a.ppc64le installed. The problem
> > was noticed with kernel > 4.13 (I'm currently running 4.13.0-rc1+).
> > 
> > QEMU is https://github.com/dgibson/qemu (ppc-for-2.10) but I gave the
> > default packaged Qemu a try.
> > 
> > For the guest, I tried both a vanilla Ubuntu 17.04 and the host kernel.
> > But they had never a chance to run since the freezing happened in SLOF.
> > 
> > Note that using the 4.11.0-10.el7a.ppc64le kernel it works fine
> > (for any of these Qemu/Guest setup). With 4.13.0-rc1 I have it run after
> > reverting that referred commit.
> 
> Is the host kernel running in radix mode?

yes

> 
> Did you check the host kernel logs for any oops messages?

dmesg was clean but after sometime waiting (I forgot QEMU running in
another terminal) I got the oops below (after rebooting the host I 
couldn't reproduce it again).

Another test that I did was:
Compile with transparent huge pages disabled: KVM works fine
Compile with transparent huge pages enabled: doesn't work
  + disabling it in /sys/kernel/mm/transparent_hugepage: doesn't work

Just out of my own curiosity I made this small change:

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
b/arch/powerpc/include
index c0737c8..f94a3b6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -80,7 +80,7 @@
 
  #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software dirty
  tracking 
   #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
   -#define _PAGE_DEVMAP           _RPAGE_SW1 /* software: ZONE_DEVICE page */
   +#define _PAGE_DEVMAP           _RPAGE_RSV3
    #define __HAVE_ARCH_PTE_DEVMAP

and it works. I chose _RPAGE_RSV3 because it uses the same value that
x86 uses (0x0400000000000000UL) but I don't if it could have any side
effect


SLOF
**********************************************************************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
  FW Version = git-66d250ef0fd06bb8
   Press "s" to enter Open Firmware.

   [  105.604333] Unable to handle kernel paging request for data at
   address 0x00000000
   [  105.604448] Faulting instruction address: 0xc000000000910b28
   [  105.604526] Oops: Kernel access of bad area, sig: 11 [#1]
   [  105.604585] SMP NR_CPUS=2048 
   [  105.604588] NUMA 
   [  105.604633] PowerNV
   [  105.604697] Modules linked in: xt_CHECKSUM ipt_MASQUERADE
   nf_nat_masquerade_ipv4 tun ip6t_rpfilter ipt_REJECT nf_reject_ipv4
   ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat
   ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6
   nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security
   ip6table_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
   nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw
   ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
   kvm_hv kvm i2c_dev at24 ghash_generic ses enclosure gf128mul
   scsi_transport_sas xts sg ctr ipmi_powernv ipmi_devintf shpchp
   opal_prd vmx_crypto ipmi_msghandler uio_pdrv_genirq uio ofpart
   powernv_flash i2c_opal ibmpowernv mtd nfsd auth_rpcgss nfs_acl lockd
   grace sunrpc ip_tables xfs libcrc32c
   [  105.605561]  sd_mod ast i2c_algo_bit drm_kms_helper syscopyarea
   sysfillrect sysimgblt fb_sys_fops ttm drm i40e i2c_core aacraid ptp
   pps_core dm_mirror dm_region_hash dm_log dm_mod
   [  105.605759] CPU: 0 PID: 6 Comm: kworker/u32:0 Not tainted
   4.13.0-rc1+ #57
   [  105.605836] Workqueue: netns cleanup_net
   [  105.605880] task: c000000ff6404200 task.stack: c000000ff648c000
   [  105.605947] NIP: c000000000910b28 LR: c0000000007cd6ec CTR:
   c0000000007cd5d0
   [  105.606026] REGS: c000000ff648f7d0 TRAP: 0300   Not tainted
   (4.13.0-rc1+)
   [  105.606090] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
   [  105.606111]   CR: 88002048  XER: 20000000
   [  105.606203] CFAR: c0000000007cd6e8 DAR: 0000000000000000 DSISR:
   40000000 SOFTE: 1 
   [  105.606203] GPR00: c0000000007cd6ec c000000ff648fa50
   c000000000f5c600 0000000000000000 
   [  105.606203] GPR04: c000000ff6404cc0 c000000ff6404280
   00000000782ccd5c 00000000cc908fe7 
   [  105.606203] GPR08: ffffffffffffffff c000000ff648c000
   0000000080000000 0000000000000000 
   [  105.606203] GPR12: c0000000007cd5d0 c00000000fb00000
   c0000000001050f8 c000000ffa150ec0 
   [  105.606203] GPR16: 0000000000000000 0000000000000000
   0000000000000000 c000000ffa1602a8 
   [  105.606203] GPR20: c000000ffa160078 c000000ff648fc20
   c000000000f03f68 c000000000f04080 
   [  105.606203] GPR24: 0000000001c9d4d8 0000000000000000
   0000000000000000 c000000ff951a280 
   [  105.606203] GPR28: c000000ffa202510 c000200e56e19bd0
   c000200e5bb48000 0000000000000000 
   [  105.606942] NIP [c000000000910b28] _raw_spin_lock_bh+0x38/0xd0
   [  105.607012] LR [c0000000007cd6ec] netlink_release+0x11c/0x5d0
   [  105.607078] Call Trace:
   [  105.607112] [c000000ff648fa50] [c000000ff648fb50]
   0xc000000ff648fb50 (unreliable)
   [  105.607196] [c000000ff648fa80] [c0000000007cd6ec]
   netlink_release+0x11c/0x5d0
   [  105.607278] [c000000ff648faf0] [c000000000752564]
   sock_release+0x44/0x100
   [  105.607353] [c000000ff648fb60] [c0000000007ca37c]
   netlink_kernel_release+0x2c/0x40
   [  105.607437] [c000000ff648fb80] [c00000000086eaa8]
   xfrm_user_net_exit+0x88/0xc0
   [  105.607519] [c000000ff648fbb0] [c00000000076d76c]
   ops_exit_list.isra.7+0x9c/0xc0
   [  105.607601] [c000000ff648fbf0] [c00000000076e450]
   cleanup_net+0x250/0x3d0
   [  105.607695] [c000000ff648fca0] [c0000000000fd240]
   process_one_work+0x180/0x460
   [  105.607778] [c000000ff648fd30] [c0000000000fd5a8]
   worker_thread+0x88/0x500
   [  105.607849] [c000000ff648fdc0] [c000000000105250]
   kthread+0x160/0x1a0
   [  105.607922] [c000000ff648fe30] [c00000000000b3a4]
   ret_from_kernel_thread+0x5c/0xb8
   [  105.608001] Instruction dump:
   [  105.608044] 7c0802a6 fbe1fff8 7c7f1b78 78290464 f8010010 f821ffd1
   8149000c 394a0200 
   [  105.608136] 9149000c 39400000 994d028c 814d0008 <7d201829>
   2c090000 40c20010 7d40192d 
   [  105.608234] ---[ end trace 58bb750815698d9b ]---
   [  107.018194] 
   [  109.018391] Kernel panic - not syncing: Fatal exception in
   interrupt
   [  110.234517] Rebooting in 10 seconds..
   [  120.253605] Trying to free IRQ 496 from IRQ context!
   [  120.253707] ------------[ cut here ]------------


> 
> Paul.
> 
