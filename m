Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtN6X1jXpzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 10:40:52 +1000 (AEST)
Date: Thu, 22 Jun 2017 10:40:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, ego <ego@linux.vnet.ibm.com>, Abdul
 Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [next-20170609] Oops while running CPU off-on
 (cpuset.c/cpuset_can_attach)
Message-ID: <20170622104051.32ab5a45@canb.auug.org.au>
In-Reply-To: <20170613135641.GA28327@htj.duckdns.org>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
 <20170613135641.GA28327@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On Tue, 13 Jun 2017 09:56:41 -0400 Tejun Heo <tj@kernel.org> wrote:
>
> (forwarding to Li w/ full body)
> 
> Li, can you please take a look at this?
> 
> Thanks.
> 
> On Mon, Jun 12, 2017 at 04:53:42PM +0530, Abdul Haleem wrote:
> > Hi,
> > 
> > linux-next kernel crashed while running CPU offline and online.
> > 
> > Machine: Power 8 LPAR
> > Kernel : 4.12.0-rc4-next-20170609
> > gcc : version 5.2.1
> > config: attached
> > testcase: CPU off/on
> > 
> > for i in $(seq 100);do 
> >     for j in $(seq 0 15);do 
> >         echo 0 >  /sys/devices/system/cpu/cpu$j/online
> >         sleep 5
> >         echo 1 > /sys/devices/system/cpu/cpu$j/online
> >     done
> > done
> > 
> > kernel trace:
> > --------------
> > Unable to handle kernel paging request for data at address 0x00000960
> > Faulting instruction address: 0xc0000000001d6868
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > SMP NR_CPUS=2048
> > NUMA
> > pSeries
> > Modules linked in: dlci mpls_router af_key 8021q garp mrp nfc af_alg
> > caif_socket caif pn_pep phonet fcrypt pcbc rxrpc hidp hid cmtp
> > kernelcapi bnep rfcomm bluetooth ecdh_generic can_bcm can_raw can pptp
> > gre l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppoe
> > pppox irda xfrm_user xfrm_algo nfnetlink scsi_transport_iscsi dn_rtmsg
> > llc2 dccp_ipv6 atm appletalk ipx p8023 p8022 psnap sctp dccp_ipv4 dccp
> > xt_addrtype xt_conntrack ipt_MASQUERADE nf_nat_masquerade_ipv4
> > iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 iptable_filter
> > ip_tables x_tables nf_nat nf_conntrack bridge stp llc dm_thin_pool
> > dm_persistent_data dm_bio_prison dm_bufio libcrc32c rtc_generic
> > vmx_crypto pseries_rng autofs4
> > CPU: 14 PID: 16947 Comm: kworker/14:0 Tainted: G        W
> > 4.12.0-rc4-next-20170609 #2
> > Workqueue: events cpuset_hotplug_workfn
> > task: c00000000ca60580 task.stack: c00000000c728000
> > NIP: c0000000001d6868 LR: c0000000001d6858 CTR: c0000000001d6810
> > REGS: c00000000c72b720 TRAP: 0300   Tainted: G        W
> > (4.12.0-rc4-next-20170609)
> > MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>
> >   CR: 44722422  XER: 20000000  
> > CFAR: c000000000008710 DAR: 0000000000000960 DSISR: 40000000 SOFTE: 1 
> > GPR00: c0000000001d6858 c00000000c72b9a0 c000000001536e00
> > 0000000000000000 
> > GPR04: c00000000c72b9c0 0000000000000000 c00000000c72bad0
> > c000000766367678 
> > GPR08: c000000766366d10 c00000000c72b958 c000000001736e00
> > 0000000000000000 
> > GPR12: c0000000001d6810 c00000000e749300 c000000000123ef8
> > c000000775af4180 
> > GPR16: 0000000000000000 0000000000000000 c00000075480e9c0
> > c00000075480e9e0 
> > GPR20: c00000075480e8c0 0000000000000001 0000000000000000
> > c00000000c72ba20 
> > GPR24: c00000000c72baa0 c00000000c72bac0 c000000001407248
> > c00000000c72ba20 
> > GPR28: c00000000141fc80 c00000000c72bac0 c00000000c6bc790
> > 0000000000000000 
> > NIP [c0000000001d6868] cpuset_can_attach+0x58/0x1b0
> > LR [c0000000001d6858] cpuset_can_attach+0x48/0x1b0
> > Call Trace:
> > [c00000000c72b9a0] [c0000000001d6858] cpuset_can_attach+0x48/0x1b0
> > (unreliable)
> > [c00000000c72ba00] [c0000000001cbe80] cgroup_migrate_execute+0xb0/0x450
> > [c00000000c72ba80] [c0000000001d3754] cgroup_transfer_tasks+0x1c4/0x360
> > [c00000000c72bba0] [c0000000001d923c] cpuset_hotplug_workfn+0x86c/0xa20
> > [c00000000c72bca0] [c00000000011aa44] process_one_work+0x1e4/0x580
> > [c00000000c72bd30] [c00000000011ae78] worker_thread+0x98/0x5c0
> > [c00000000c72bdc0] [c000000000124058] kthread+0x168/0x1b0
> > [c00000000c72be30] [c00000000000b2e8] ret_from_kernel_thread+0x5c/0x74
> > Instruction dump:
> > f821ffa1 7c7d1b78 60000000 60000000 38810020 7fa3eb78 3f42ffed 4bff4c25 
> > 60000000 3b5a0448 3d420020 eb610020 <e9230960> 7f43d378 e9290000
> > f92af200 
> > ---[ end trace dcaaf98fb36d9e64 ]---

Has there been any progress on this?
-- 
Cheers,
Stephen Rothwell
