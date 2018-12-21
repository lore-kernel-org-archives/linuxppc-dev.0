Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3B9C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 00:48:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65E8218E2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 00:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E8218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LVNs0NbYzDr7x
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 11:48:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=michaele@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LVLN3Fq8zDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 11:46:17 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBL0hYHB117886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:46:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pgnahh496-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:46:14 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Fri, 21 Dec 2018 00:46:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Dec 2018 00:46:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBL0k8Ii9044406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Dec 2018 00:46:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE5944C044;
 Fri, 21 Dec 2018 00:46:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98E834C040;
 Fri, 21 Dec 2018 00:46:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Dec 2018 00:46:07 +0000 (GMT)
Received: from localhost (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A6003A0220;
 Fri, 21 Dec 2018 11:46:04 +1100 (AEDT)
From: Michael Ellerman <michaele@au1.ibm.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v7 20/20] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] subdriver
In-Reply-To: <20181220163006.GA31987@kermit-br-ibm-com.br.ibm.com>
References: <20181220082350.58113-1-aik@ozlabs.ru>
 <20181220082350.58113-21-aik@ozlabs.ru>
 <20181220163006.GA31987@kermit-br-ibm-com.br.ibm.com>
Date: Fri, 21 Dec 2018 11:46:04 +1100
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18122100-0028-0000-0000-0000032D7B8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122100-0029-0000-0000-000023E9E383
Message-Id: <87y38jpv03.fsf@concordia.ellerman.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210003
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
Cc: Reza Arbab <arbab@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Leonardo Augusto =?utf-8?Q?Guimar=C3=A3es?= Garcia <lagarcia@br.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Thu, Dec 20, 2018 at 07:23:50PM +1100, Alexey Kardashevskiy wrote:
...
>> diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
>> new file mode 100644
>> index 0000000..b80d2d3
>> --- /dev/null
>> +++ b/drivers/vfio/pci/trace.h
...
>> +TRACE_EVENT(vfio_pci_npu2_mmap,
>> +	TP_PROTO(struct pci_dev *pdev, unsigned long hpa, unsigned long ua,
>> +			unsigned long size, int ret),
>> +	TP_ARGS(pdev, hpa, ua, size, ret),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char *, name)
>> +		__field(unsigned long, hpa)
>> +		__field(unsigned long, ua)
>> +		__field(unsigned long, size)
>> +		__field(int, ret)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = dev_name(&pdev->dev),
>> +		__entry->hpa = hpa;
>> +		__entry->ua = ua;
>> +		__entry->size = size;
>> +		__entry->ret = ret;
>> +	),
>> +
>> +	TP_printk("%s: %lx -> %lx size=%lx ret=%d", __entry->name, __entry->hpa,
>> +			__entry->ua, __entry->size, __entry->ret)
>> +);
>> +
>> +#endif /* _TRACE_SUBSYS_H */
>
> I think it's too late but this line I guess should read:
>
>   #endif /* _TRACE_VFIO_PCI_H */

Thanks I'll fix it up.

cheers

