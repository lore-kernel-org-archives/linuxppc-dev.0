Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB69C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43108206BB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43108206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZZpM1z38zDqKT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 03:48:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZZky2K69zDqf3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 03:46:02 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x09GdDf7009067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2019 11:45:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pwjn9xuhx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 11:45:59 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Wed, 9 Jan 2019 16:45:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Jan 2019 16:45:55 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x09GjsFq63504504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 16:45:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 796A811C058;
 Wed,  9 Jan 2019 16:45:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39BDA11C064;
 Wed,  9 Jan 2019 16:45:54 +0000 (GMT)
Received: from [9.145.74.170] (unknown [9.145.74.170])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jan 2019 16:45:54 +0000 (GMT)
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
To: Greg Kurz <groug@kaod.org>
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 9 Jan 2019 17:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109172529.10c45ce6@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010916-0012-0000-0000-000002E57172
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010916-0013-0000-0000-0000211C7445
Message-Id: <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-09_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090138
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 09/01/2019 à 17:25, Greg Kurz a écrit :
> On Wed,  9 Jan 2019 16:13:42 +0100
> Frederic Barrat <fbarrat@linux.ibm.com> wrote:
> 
>> With a recent change around IOMMU group, a system with an opencapi
>> adapter is no longer booting and we get a kernel oops:
>>
>> BUG: Kernel NULL pointer dereference at 0x00000028
>> Faulting instruction address: 0xc0000000000aa38c
>> Oops: Kernel access of bad area, sig: 7 [#1]
>> LE SMP NR_CPUS=2048 NUMA PowerNV
>> Modules linked in:
>> CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e94bec12
>> NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
>> REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001-g3bd6
>> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  XER: 20
>> CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK: 0
>> GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf761860
>> GPR04: 0000000000000000 c000000005783834 0000000000000000 0000000000000000
>> GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 9000000002001003
>> GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 0000000000000000
>> GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000a0000
>> GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000ced978
>> GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 0000000000000000
>> GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf761860
>> NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
>> LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
>> Call Trace:
>> [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0x60/0x
>> [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
>> [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0x31c
>> [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
>> [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
>> [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
>> [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
>> [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
>>
>> An opencapi device is using a device PE, so the current code breaks
>> because pe->pbus is not defined.
>>
>> More generally, there's no need to define an IOMMU group for opencapi,
>> as the device sends real addresses directly (admittedly, the
>> virtualization story is yet to be written). So let's fix it by
> 
> Current plan is to go for mediated VFIO. The real HW stays under the control
> of the host ocxl driver, and we still don't need an IOMMU group.
> 
>> skipping the IOMMU group setup for opencapi PHBs.
>>
>> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> ---
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> and
> 
> Cc: stable@vger.kernel.org      # v4.20

Thanks for the review! But why did you add stable? that problem is only 
seen on 5.0-rc1, isn't it?

   Fred


>>   arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 1d6406a051f1..7db3119f8a5b 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2681,7 +2681,8 @@ static void pnv_pci_ioda_setup_iommu_api(void)
>>   	list_for_each_entry(hose, &hose_list, list_node) {
>>   		phb = hose->private_data;
>>   
>> -		if (phb->type == PNV_PHB_NPU_NVLINK)
>> +		if (phb->type == PNV_PHB_NPU_NVLINK ||
>> +		    phb->type == PNV_PHB_NPU_OCAPI)
>>   			continue;
>>   
>>   		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> 

