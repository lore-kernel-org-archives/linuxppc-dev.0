Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78458ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 01:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A571C2145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 01:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A571C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b9rp1nxVzF3TP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 12:07:54 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b9ph00QrzF3S2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 12:06:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9I141Td079753
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:06:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n6ee7bsha-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:06:00 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair@popple.id.au>;
 Thu, 18 Oct 2018 02:05:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Oct 2018 02:05:55 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9I15sI97537052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Oct 2018 01:05:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA9D75204F;
 Thu, 18 Oct 2018 01:05:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B22D52052;
 Thu, 18 Oct 2018 01:05:54 +0000 (GMT)
Received: from townsend.localnet (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0CE1CA021A;
 Thu, 18 Oct 2018 12:05:53 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/ioda/npu: Call skiboot's hot reset hook
 when disabling NPU2
Date: Thu, 18 Oct 2018 12:05:52 +1100
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <45098cfd-5420-f4bd-f7fe-394ce2c704d0@ozlabs.ru>
References: <20181002032021.7126-1-aik@ozlabs.ru>
 <2086775.d8i5QI7OoB@new-mexico>
 <45098cfd-5420-f4bd-f7fe-394ce2c704d0@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18101801-0028-0000-0000-00000308FDF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101801-0029-0000-0000-000023C412B0
Message-Id: <11968808.7zhiiyAbUF@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-17_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810180009
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
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Alexey,

> > wouldn't you also need to do that somewhere? Unless the driver
> > does it at startup?
> 
> VFIO performs GPU reset so I'd expect the GPUs to flush its caches
> without any software interactions. Am I hoping for too much here?

Sadly you are. It's not the GPU caches that need flushing, it's the CPU caches. 
This needs to happen as part of the reset sequence, so I guess you would need 
to add it to the VFIO driver.

- Alistair

> 
> > - Alistair
> > 
> >>> - Alistair
> >>> 
> >>>>> - Alistair
> >>>>> 
> >>>>>>> - Alistair
> >>>>>>> 
> >>>>>>> On Monday, 15 October 2018 6:17:51 PM AEDT Alexey Kardashevskiy 
wrote:
> >>>>>>>> Ping?
> >>>>>>>> 
> >>>>>>>> On 02/10/2018 13:20, Alexey Kardashevskiy wrote:
> >>>>>>>>> The skiboot firmware has a hot reset handler which fences the
> >>>>>>>>> NVIDIA V100
> >>>>>>>>> GPU RAM on Witherspoons and makes accesses no-op instead of
> >>>>>>>>> throwing HMIs:
> >>>>>>>>> https://github.com/open-power/skiboot/commit/fca2b2b839a67
> >>>>>>>>> 
> >>>>>>>>> Now we are going to pass V100 via VFIO which most certainly
> >>>>>>>>> involves
> >>>>>>>>> KVM guests which are often terminated without getting a chance to
> >>>>>>>>> offline
> >>>>>>>>> GPU RAM so we end up with a running machine with misconfigured
> >>>>>>>>> memory.
> >>>>>>>>> Accessing this memory produces hardware management interrupts
> >>>>>>>>> (HMI)
> >>>>>>>>> which bring the host down.
> >>>>>>>>> 
> >>>>>>>>> To suppress HMIs, this wires up this hot reset hook to
> >>>>>>>>> vfio_pci_disable()
> >>>>>>>>> via pci_disable_device() which switches NPU2 to a safe mode and
> >>>>>>>>> prevents
> >>>>>>>>> HMIs.
> >>>>>>>>> 
> >>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>>>> ---
> >>>>>>>>> Changes:
> >>>>>>>>> v2:
> >>>>>>>>> * updated the commit log
> >>>>>>>>> ---
> >>>>>>>>> 
> >>>>>>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
> >>>>>>>>>  1 file changed, 10 insertions(+)
> >>>>>>>>> 
> >>>>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>> b/arch/powerpc/platforms/powernv/pci-ioda.c index
> >>>>>>>>> cde7102..e37b9cc 100644
> >>>>>>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >>>>>>>>> @@ -3688,6 +3688,15 @@ static void pnv_pci_release_device(struct
> >>>>>>>>> pci_dev *pdev)>>>>>>>>> 
> >>>>>>>>>  		pnv_ioda_release_pe(pe);
> >>>>>>>>>  
> >>>>>>>>>  }
> >>>>>>>>> 
> >>>>>>>>> +static void pnv_npu_disable_device(struct pci_dev *pdev)
> >>>>>>>>> +{
> >>>>>>>>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> >>>>>>>>> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> >>>>>>>>> +
> >>>>>>>>> +	if (eehpe && eeh_ops && eeh_ops->reset)
> >>>>>>>>> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> 
> >>>>>>>>>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
> >>>>>>>>>  {
> >>>>>>>>>  
> >>>>>>>>>  	struct pnv_phb *phb = hose->private_data;
> >>>>>>>>> 
> >>>>>>>>> @@ -3732,6 +3741,7 @@ static const struct pci_controller_ops
> >>>>>>>>> pnv_npu_ioda_controller_ops = {>>>>>>>>> 
> >>>>>>>>>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> >>>>>>>>>  	.dma_set_mask		= pnv_npu_dma_set_mask,
> >>>>>>>>>  	.shutdown		= pnv_pci_ioda_shutdown,
> >>>>>>>>> 
> >>>>>>>>> +	.disable_device		= pnv_npu_disable_device,
> >>>>>>>>> 
> >>>>>>>>>  };
> >>>>>>>>>  
> >>>>>>>>>  static const struct pci_controller_ops
> >>>>>>>>>  pnv_npu_ocapi_ioda_controller_ops = {


