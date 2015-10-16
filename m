Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3703D1A0754
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 05:19:47 +1100 (AEDT)
Received: by yknn9 with SMTP id n9so41769505ykn.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 11:19:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56211459.1060006@linux.vnet.ibm.com>
References: <20151016102327.6010.50184.stgit@hegdevasant.in.ibm.com>
 <CAOJe8K03v_0MULL_pxX=CgSaFTTDmS8aJe1j+aFO9HHxhZ7d4Q@mail.gmail.com>
 <56211459.1060006@linux.vnet.ibm.com>
Date: Fri, 16 Oct 2015 21:19:45 +0300
Message-ID: <CAOJe8K0Mva7+12k1eJjineUTfaPQiyae9HEnxRG+=2FkyrnmVA@mail.gmail.com>
Subject: Re: [PATCH] rtas: Validate rtas entry before calling enter_rtas
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> On 10/16/2015 04:02 PM, Denis Kirjanov wrote:
>> On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
>>> Currently we do not validate rtas entry before calling enter_rtas().
>>> This
>>> is resulting in a kernel oops (see below) when user space calls rtas
>>> system
>>> call on PowerNV platform. We hit below oops when we ran trinity (system
>>> call
>>> fuzzer) on PowerNV. This patch adds code to validate rtas entry before
>>> making
>>> enter_rtas() call.
>>
>> Hi,
>> have you figured out why we have null entry?
>
> Denis,
>
> Yes... On PowerNV platform we don't have RTAS.. Hence it's not initialized.
But why do we have CONFIG_PPC_RTAS on OPAL machines then?


>
> -Vasant
>
>>
>> Thanks!
>>>
>>> dmesg:
>>> -----
>>> [22061.541428] Oops: Exception in kernel mode, sig: 4 [#1]
>>> [22061.541446] SMP NR_CPUS=1024 NUMA PowerNV
>>> [22061.541453] Modules linked in: rfcomm bnep nfnetlink
>>> scsi_transport_iscsi
>>> hidp nfc af_802154 ieee802154 bluetooth rfkill pppoe pppox ppp_generic
>>> slhc
>>> irda crc_ccitt af_key sctp libcrc32c atm appletalk ipx p8023 psnap p8022
>>> ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_CHECKSUM tun ip6t_rpfilter
>>> ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack
>>> ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables
>>> ip6table_mangle ip6table_security ip6table_raw ip6table_filter
>>> ip6_tables
>>> iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat
>>> nf_conntrack
>>> iptable_mangle iptable_security iptable_raw windfarm_smu_sat ses
>>> enclosure
>>> windfarm_pid shpchp i2c_opal i2c_core kvm_hv kvm_pr dm_multipath kvm
>>> lpfc
>>> tg3 ptp pps_core scsi_transport_fc
>>> [22061.541561] CPU: 40 PID: 57748 Comm: trinity-c11 Not tainted
>>> 3.18.17-340.el7_1.pkvm3_1_0.2400.1.ppc64le #1
>>> [22061.541566] task: c000000004294b80 ti: c0000007e1a78000 task.ti:
>>> c0000007e1a78000
>>> [22061.541570] NIP: 0000000000000000 LR: 0000000000009c14 CTR:
>>> c000000000423140
>>> [22061.541573] REGS: c0000007e1a7b920 TRAP: 0e40   Not tainted
>>> (3.18.17-340.el7_1.pkvm3_1_0.2400.1.ppc64le)
>>> 	[22061.541577] MSR: 1000000000081000 <HV,ME>  CR: 00000000  XER:
>>> 00000000
>>> 	[22061.541585] CFAR: c000000000009c0c SOFTE: 0
>>> 	GPR00: 9000000000001031 c0000007e1a7bba0 c0000000012b1d00
>>> 0000000001338840
>>> 	GPR04: 0000000000000000 0000000000000000 1000000000001000
>>> 9000000000001033
>>> 	GPR08: 0000000040000000 8000000000002933 00003fff9e9d0068
>>> 0000000000000000
>>> 	GPR12: 00000000000000ff c000000007db7c00 0000000000000000
>>> 0000000000000000
>>> 	GPR16: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000
>>> 	GPR20: 0000000000000000 0000000000000000 0000000000000000
>>> 0000000000000000
>>> 	GPR24: 0000000000000000 000000000000dc58 0000000000000001
>>> c000001ee716e000
>>> 	GPR28: 0000000000000000 c000000001338840 00003fff9db30000
>>> 0000000000000000
>>> 	[22061.541629] NIP [0000000000000000]           (null)
>>> 	[22061.541637] LR [0000000000009c14] 0x9c14
>>> 	[22061.541640] Call Trace:
>>> 	[22061.541649] [c0000007e1a7bba0] [c00000000041a7f4]
>>> avc_has_perm_noaudit+0x54/0x110 (unreliable)
>>> 	[22061.541657] [c0000007e1a7bd80] [c00000000002ddc0]
>>> ppc_rtas+0x150/0x2d0
>>> 	[22061.541662] [c0000007e1a7be30] [c000000000009358]
>>> syscall_exit+0x0/0x98
>>> 	[22061.541666] Instruction dump:
>>> 	[22061.541669] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>>> XXXXXXXX XXXXXXXX
>>> 	[22061.541675] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 60000000
>>> 60000000 60000000
>>> 	[22061.541688] ---[ end trace 6f9bf0b3d32096aa ]---
>>>
>>> Reported-by: NAGESWARA R. SASTRY <nasastry@in.ibm.com>
>>> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/rtas.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>>> index 84bf934..5a753fa 100644
>>> --- a/arch/powerpc/kernel/rtas.c
>>> +++ b/arch/powerpc/kernel/rtas.c
>>> @@ -1043,6 +1043,9 @@ asmlinkage int ppc_rtas(struct rtas_args __user
>>> *uargs)
>>>  	if (!capable(CAP_SYS_ADMIN))
>>>  		return -EPERM;
>>>
>>> +	if (!rtas.entry)
>>> +		return -EINVAL;
>>> +
>>>  	if (copy_from_user(&args, uargs, 3 * sizeof(u32)) != 0)
>>>  		return -EFAULT;
>>>
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>
>
