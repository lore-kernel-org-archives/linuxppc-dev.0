Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ABECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 01:49:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAEA20866
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 01:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAEA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bpjy3GxSzF3KF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bpgk6YjpzF3KL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 12:47:14 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9J1dLwJ126246
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 21:47:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n747pkg5w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 21:47:12 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair@popple.id.au>;
 Fri, 19 Oct 2018 02:47:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Oct 2018 02:47:08 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9J1l76S66060444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Oct 2018 01:47:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A64F42047;
 Fri, 19 Oct 2018 01:47:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F01942041;
 Fri, 19 Oct 2018 01:47:06 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Oct 2018 01:47:06 +0000 (GMT)
Received: from townsend.localnet (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 696CFA018C;
 Fri, 19 Oct 2018 12:47:05 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
Date: Fri, 19 Oct 2018 12:47:05 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <87caa06c-0f67-f2f1-6bc0-215f5c672bd8@ozlabs.ru>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <11968808.7zhiiyAbUF@townsend>
 <87caa06c-0f67-f2f1-6bc0-215f5c672bd8@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18101901-0028-0000-0000-000003099A67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101901-0029-0000-0000-000023C4B4CE
Message-Id: <513336724.BjiWrP5dVC@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-18_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190014
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
Cc: Reza Arbab <arbab@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sam Bobroff <sam.bobroff@au1.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> >>> wouldn't you also need to do that somewhere? Unless the driver
> >>> does it at startup?
> >> 
> >> VFIO performs GPU reset so I'd expect the GPUs to flush its caches
> >> without any software interactions. Am I hoping for too much here?
> > 
> > Sadly you are. It's not the GPU caches that need flushing, it's the CPU
> > caches. This needs to happen as part of the reset sequence, so I guess
> > you would need to add it to the VFIO driver.
> 
> Well, ok. Caches need flushing, will look into this but this fencing is
> still needed, is not it?

Yes. Although without the flushing I think you may get HMI's on any subsequent 
driver loads.

So from the point of view of what happens on the Skiboot/HW side this looks ok 
so long as all links on an NPU are assigned to the same guest (as this call 
resets every link on a given NPU).

Acked-by: Alistair Popple <alistair@popple.id.au>
 
> > - Alistair
> > 
> >>> - Alistair
> >>> 
> >>>>> - Alistair
> >>>>> 
> >>>>>>> - Alistair
> >>>>>>> 
> >>>>>>>>> - Alistair
> >>>>>>>>> 
> >>>>>>>>> On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy
> > 
> > wrote:
> >>>>>>>>>> Ping?
> >>>>>>>>>> 
> >>>>>>>>>> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
> >>>>>>>>>>> The skiboot firmware has a hot reset handler which fences the
> >>>>>>>>>>> NVIDIA V100
> >>>>>>>>>>> GPU RAM on Witherspoons and makes accesses no-op instead of
> >>>>>>>>>>> throwing HMIs:
> >>>>>>>>>>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
> >>>>>>>>>>> 
> >>>>>>>>>>> Now we are going to pass V100 via VFIO which most certainly
> >>>>>>>>>>> involves
> >>>>>>>>>>> KVM guests which are often terminated without getting a chance
> >>>>>>>>>>> to
> >>>>>>>>>>> offline
> >>>>>>>>>>> GPU RAM so we end up with a running machine with misconfigured
> >>>>>>>>>>> memory.
> >>>>>>>>>>> Accessing this memory produces hardware management interrupts
> >>>>>>>>>>> (HMI)
> >>>>>>>>>>> which bring the host down.
> >>>>>>>>>>> 
> >>>>>>>>>>> To suppress HMIs, this wires up this hot reset hook to
> >>>>>>>>>>> vfio_pci_disable()
> >>>>>>>>>>> via pci_disable_device() which switches NPU2 to a safe mode and
> >>>>>>>>>>> prevents
> >>>>>>>>>>> HMIs.
> >>>>>>>>>>> 
> >>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>>>>>> ---
> >>>>>>>>>>> Changes:
> >>>>>>>>>>> v2:
> >>>>>>>>>>> * updated the commit log
> >>>>>>>>>>> ---
> >>>>>>>>>>> 
> >>>>>>>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
> >>>>>>>>>>>  1 file changed, 10 insertions(+)
> >>>>>>>>>>> 
> >>>>>>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>>>> b/arch/powerpc/platforms/powernv/pci-ioda.c index
> >>>>>>>>>>> cde7102..e37b9cc 100644
> >>>>>>>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>>>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct
> >>>>>>>>>>> pci_dev *pdev)>>>>>>>>>
> >>>>>>>>>>> 
> >>>>>>>>>>>  		pnv_ioda_release_pe(pe);
> >>>>>>>>>>>  
> >>>>>>>>>>>  }
> >>>>>>>>>>> 
> >>>>>>>>>>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> >>>>>>>>>>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> >>>>>>>>>>> +
> >>>>>>>>>>> +	if (eehpe && eeh_ops && eeh_ops->reset)
> >>>>>>>>>>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> >>>>>>>>>>> +}
> >>>>>>>>>>> +
> >>>>>>>>>>> 
> >>>>>>>>>>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> >>>>>>>>>>>  {
> >>>>>>>>>>>  
> >>>>>>>>>>>  	struct pnv_phb *phb = hose->private_data;
> >>>>>>>>>>> 
> >>>>>>>>>>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops
> >>>>>>>>>>> pnv_npu_ioda_controller_ops = {>>>>>>>>>
> >>>>>>>>>>> 
> >>>>>>>>>>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> >>>>>>>>>>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
> >>>>>>>>>>>  	.shutdown		= pnv_pci_ioda_shutdown,
> >>>>>>>>>>> 
> >>>>>>>>>>> +	.disable_device		= pnv_npu_disable_device,
> >>>>>>>>>>> 
> >>>>>>>>>>>  };
> >>>>>>>>>>>  
> >>>>>>>>>>>  static const struct pci_controller_ops
> >>>>>>>>>>>  pnv_npu_ocapi_ioda_controller_ops = {


