Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssclK58bLzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:05:49 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id qn10so5842841pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 15:05:49 -0700 (PDT)
Subject: Re: [PATCH] powerpc/pseries: Fix stack corruption in htpe code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <1475760801-10592-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <877f9lo713.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4c2b20a6-28eb-643b-591b-320b58bef711@gmail.com>
Date: Mon, 10 Oct 2016 09:05:44 +1100
MIME-Version: 1.0
In-Reply-To: <877f9lo713.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/10/16 02:02, Aneesh Kumar K.V wrote:
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
>> This commit fixes a stack corruption in the pseries specific code dealing
>> with the huge pages.
>>
>> In __pSeries_lpar_hugepage_invalidate() the buffer used to pass arguments
>> to the hypervisor is not large enough. This leads to a stack corruption
>> where a previously saved register could be corrupted leading to unexpected
>> result in the caller, like the following panic:
>>
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> SMP NR_CPUS=2048 NUMA pSeries
>> Modules linked in: virtio_balloon ip_tables x_tables autofs4
>> virtio_blk 8139too virtio_pci virtio_ring 8139cp virtio
>> CPU: 11 PID: 1916 Comm: mmstress Not tainted 4.8.0 #76
>> task: c000000005394880 task.stack: c000000005570000
>> NIP: c00000000027bf6c LR: c00000000027bf64 CTR: 0000000000000000
>> REGS: c000000005573820 TRAP: 0300   Not tainted  (4.8.0)
>> MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 84822884  XER:
>> 20000000
>> CFAR: c00000000010a924 DAR: 420000000014e5e0 DSISR: 40000000 SOFTE: 1
>> GPR00: c00000000027bf64 c000000005573aa0 c000000000e02800 c000000004447964
>> GPR04: c00000000404de18 c000000004d38810 00000000042100f5 00000000f5002104
>> GPR08: e0000000f5002104 0000000000000001 042100f5000000e0 00000000042100f5
>> GPR12: 0000000000002200 c00000000fe02c00 c00000000404de18 0000000000000000
>> GPR16: c1ffffffffffe7ff 00003fff62000000 420000000014e5e0 00003fff63000000
>> GPR20: 0008000000000000 c0000000f7014800 0405e600000000e0 0000000000010000
>> GPR24: c000000004d38810 c000000004447c10 c00000000404de18 c000000004447964
>> GPR28: c000000005573b10 c000000004d38810 00003fff62000000 420000000014e5e0
>> NIP [c00000000027bf6c] zap_huge_pmd+0x4c/0x470
>> LR [c00000000027bf64] zap_huge_pmd+0x44/0x470
>> Call Trace:
>> [c000000005573aa0] [c00000000027bf64] zap_huge_pmd+0x44/0x470 (unreliable)
>> [c000000005573af0] [c00000000022bbd8] unmap_page_range+0xcf8/0xed0
>> [c000000005573c30] [c00000000022c2d4] unmap_vmas+0x84/0x120
>> [c000000005573c80] [c000000000235448] unmap_region+0xd8/0x1b0
>> [c000000005573d80] [c0000000002378f0] do_munmap+0x2d0/0x4c0
>> [c000000005573df0] [c000000000237be4] SyS_munmap+0x64/0xb0
>> [c000000005573e30] [c000000000009560] system_call+0x38/0x108
>> Instruction dump:
>> fbe1fff8 fb81ffe0 7c7f1b78 7ca32b78 7cbd2b78 f8010010 7c9a2378 f821ffb1
>> 7cde3378 4bfffea9 7c7b1b79 41820298 <e87f0000> 48000130 7fa5eb78 7fc4f378
>>
>> Most of the time, the bug is surfacing in a caller up in the stack from
>> __pSeries_lpar_hugepage_invalidate() which is quite confusing.
>>
>> This bug is pending since v3.11 but was hidden if a caller of the
>> caller of __pSeries_lpar_hugepage_invalidate() has pushed the corruped
>> register (r18 in this case) in the stack and is not using it until
>> restoring it. GCC 6.2.0 seems to raise it more frequently.
>>
>> This commit also change the definition of the parameter buffer in
>> pSeries_lpar_flush_hash_range() to rely on the global define
>> PLPAR_HCALL9_BUFSIZE (no functional change here).
>>
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
>> Fixes: 1a5272866f87 ("powerpc: Optimize hugepage invalidate")
>> Cc: <stable@vger.kernel.org>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
