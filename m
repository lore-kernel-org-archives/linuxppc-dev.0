Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x235.google.com (mail-yw0-x235.google.com
 [IPv6:2607:f8b0:4002:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxqlL69dDzDr2Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 01:36:14 +1000 (AEST)
Received: by mail-yw0-x235.google.com with SMTP id l21so4939155ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 08:36:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Jun 2017 11:36:08 -0400
From: Tejun Heo <tj@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, mpe <mpe@ellerman.id.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, ego <ego@linux.vnet.ibm.com>,
 Li Zefan <lizefan@huawei.com>
Subject: Re: [next-20170609] Oops while running CPU off-on
 (cpuset.c/cpuset_can_attach)
Message-ID: <20170627153608.GD2289@htj.duckdns.org>
References: <1497266622.15415.39.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497266622.15415.39.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Abdul.

Sorry about the long delay.

On Mon, Jun 12, 2017 at 04:53:42PM +0530, Abdul Haleem wrote:
> linux-next kernel crashed while running CPU offline and online.
> 
> Machine: Power 8 LPAR
> Kernel : 4.12.0-rc4-next-20170609
> gcc : version 5.2.1
> config: attached
> testcase: CPU off/on
> 
> for i in $(seq 100);do 
>     for j in $(seq 0 15);do 
>         echo 0 >  /sys/devices/system/cpu/cpu$j/online
>         sleep 5
>         echo 1 > /sys/devices/system/cpu/cpu$j/online
>     done
> done
> 
...
> NIP [c0000000001d6868] cpuset_can_attach+0x58/0x1b0

Can you please map this to the source line?

> LR [c0000000001d6858] cpuset_can_attach+0x48/0x1b0
> Call Trace:
> [c00000000c72b9a0] [c0000000001d6858] cpuset_can_attach+0x48/0x1b0
> (unreliable)
> [c00000000c72ba00] [c0000000001cbe80] cgroup_migrate_execute+0xb0/0x450
> [c00000000c72ba80] [c0000000001d3754] cgroup_transfer_tasks+0x1c4/0x360
> [c00000000c72bba0] [c0000000001d923c] cpuset_hotplug_workfn+0x86c/0xa20
> [c00000000c72bca0] [c00000000011aa44] process_one_work+0x1e4/0x580
> [c00000000c72bd30] [c00000000011ae78] worker_thread+0x98/0x5c0
> [c00000000c72bdc0] [c000000000124058] kthread+0x168/0x1b0
> [c00000000c72be30] [c00000000000b2e8] ret_from_kernel_thread+0x5c/0x74
> Instruction dump:
> f821ffa1 7c7d1b78 60000000 60000000 38810020 7fa3eb78 3f42ffed 4bff4c25 
> 60000000 3b5a0448 3d420020 eb610020 <e9230960> 7f43d378 e9290000
> f92af200 

Thanks.

-- 
tejun
