Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F59C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:01:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD7D20879
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 13:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD7D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b5hp56zszDqdM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 00:00:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b5f92yPPzDqVl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 23:58:40 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0ACmx8x062227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 07:58:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2px5w5sr3j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 07:58:38 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Thu, 10 Jan 2019 12:58:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Jan 2019 12:58:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0ACwWUq61014206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 12:58:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5804552050;
 Thu, 10 Jan 2019 12:58:32 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C2415204E;
 Thu, 10 Jan 2019 12:58:32 +0000 (GMT)
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
To: Michael Ellerman <mpe@ellerman.id.au>, Greg Kurz <groug@kaod.org>,
 greg@kroah.com
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
 <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
 <20190109175622.75525ff8@bahia.lan> <87h8egsnrs.fsf@concordia.ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 10 Jan 2019 13:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87h8egsnrs.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011012-0028-0000-0000-000003371560
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011012-0029-0000-0000-000023F42A2E
Message-Id: <d597e75e-ee71-3c1b-fcd9-2a6d65d2d251@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-10_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100105
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/01/2019 à 13:25, Michael Ellerman a écrit :
> Greg Kurz <groug@kaod.org> writes:
>> On Wed, 9 Jan 2019 17:45:53 +0100
>> Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>>
>>> Le 09/01/2019 à 17:25, Greg Kurz a écrit :
>>>> On Wed,  9 Jan 2019 16:13:42 +0100
>>>> Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>>>>    
>>>>> With a recent change around IOMMU group, a system with an opencapi
>>>>> adapter is no longer booting and we get a kernel oops:
>>>>>
>>>>> BUG: Kernel NULL pointer dereference at 0x00000028
>>>>> Faulting instruction address: 0xc0000000000aa38c
>>>>> Oops: Kernel access of bad area, sig: 7 [#1]
>>>>> LE SMP NR_CPUS=2048 NUMA PowerNV
>>>>> Modules linked in:
>>>>> CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e94bec12
>>>>> NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
>>>>> REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001-g3bd6
>>>>> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  XER: 20
>>>>> CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK: 0
>>>>> GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf761860
>>>>> GPR04: 0000000000000000 c000000005783834 0000000000000000 0000000000000000
>>>>> GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 9000000002001003
>>>>> GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 0000000000000000
>>>>> GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000a0000
>>>>> GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000ced978
>>>>> GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 0000000000000000
>>>>> GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf761860
>>>>> NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
>>>>> LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
>>>>> Call Trace:
>>>>> [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0x60/0x
>>>>> [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
>>>>> [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0x31c
>>>>> [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
>>>>> [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
>>>>> [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
>>>>> [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
>>>>> [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
>>>>>
>>>>> An opencapi device is using a device PE, so the current code breaks
>>>>> because pe->pbus is not defined.
>>>>>
>>>>> More generally, there's no need to define an IOMMU group for opencapi,
>>>>> as the device sends real addresses directly (admittedly, the
>>>>> virtualization story is yet to be written). So let's fix it by
>>>>
>>>> Current plan is to go for mediated VFIO. The real HW stays under the control
>>>> of the host ocxl driver, and we still don't need an IOMMU group.
>>>>    
>>>>> skipping the IOMMU group setup for opencapi PHBs.
>>>>>
>>>>> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
>>>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>>>> ---
>>>>
>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>>
>>>> and
>>>>
>>>> Cc: stable@vger.kernel.org      # v4.20
>>>
>>> Thanks for the review! But why did you add stable? that problem is only
>>> seen on 5.0-rc1, isn't it?
>>
>> Based on the fact that 0bd971676e68 was committed in 4.20... but I haven't
>> tested :)
> 
> It was committed to a branch based off 4.20-rc2, but it wasn't merged
> into the 4.20 release.
> 
>    $ git describe --match "v[0-9]*" --contains 0bd971676e68
>    v5.0-rc1~137^2~15
> 
> So it doesn't need to go to stable.

Which makes me wonder if Greg (KH) was really talking about that 
original patch and whether something worthwhile was dropped from stable 
by mistake?

   Fred

