Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D1C7618F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 16:44:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B4A21849
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B4A21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qKj90HHDzDqfN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 02:44:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qKfc25nLzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 02:41:59 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6IGarCF005490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 12:41:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ttum1je26-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 12:41:56 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 18 Jul 2019 17:41:55 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Jul 2019 17:41:50 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6IGfmwM34341242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2019 16:41:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B510CC6057;
 Thu, 18 Jul 2019 16:41:48 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8093CC6095;
 Thu, 18 Jul 2019 16:41:44 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Jul 2019 16:41:44 +0000 (GMT)
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
 <20190718032858.28744-7-bauerman@linux.ibm.com>
 <20190718084456.GE24562@lst.de>
User-agent: mu4e 1.2.0; emacs 26.2
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 6/6] s390/mm: Remove sev_active() function
In-reply-to: <20190718084456.GE24562@lst.de>
Date: Thu, 18 Jul 2019 13:41:25 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071816-0016-0000-0000-000009D1B85B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011452; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01234001; UDB=6.00650264; IPR=6.01015328; 
 MB=3.00027782; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 16:41:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071816-0017-0000-0000-00004412E0B8
Message-Id: <87d0i747nu.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-18_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180174
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
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Lendacky <Thomas.Lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Alexey Dobriyan <adobriyan@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Christoph Hellwig <hch@lst.de> writes:

>> -/* are we a protected virtualization guest? */
>> -bool sev_active(void)
>> -{
>> -	return is_prot_virt_guest();
>> -}
>> -
>>  bool force_dma_unencrypted(struct device *dev)
>>  {
>> -	return sev_active();
>> +	return is_prot_virt_guest();
>>  }
>
> Do we want to keep the comment for force_dma_unencrypted?
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you for your review on al these patches.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

