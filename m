Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F977C282C7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 11:50:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96304218B0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 11:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96304218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mvN54BqGzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 22:50:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mvLJ4XhMzDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 22:48:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0QBdPmU063543
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 06:48:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q8kr7deje-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 06:48:54 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Sat, 26 Jan 2019 11:48:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 26 Jan 2019 11:48:49 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0QBmm6V62521576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 26 Jan 2019 11:48:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EC285204F;
 Sat, 26 Jan 2019 11:48:48 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.91.68])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C60605204E;
 Sat, 26 Jan 2019 11:48:44 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Sat, 26 Jan 2019 17:18:43 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Wrap iterations over afu slices inside
 'afu_list_lock'
In-Reply-To: <4a90ada0-99dc-df32-7331-ffb3191ebf40@linux.ibm.com>
References: <20190125044052.32059-1-vaibhav@linux.ibm.com>
 <4a90ada0-99dc-df32-7331-ffb3191ebf40@linux.ibm.com>
Date: Sat, 26 Jan 2019 17:18:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012611-0028-0000-0000-0000033E7892
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012611-0029-0000-0000-000023FBC043
Message-Id: <87zhrnabc4.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901260089
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks for reviewing this patch Fred,

Frederic Barrat <fbarrat@linux.ibm.com> writes:

>>   
>>   		afu_result = cxl_vphb_error_detected(afu, state);
>>   
>> -		cxl_context_detach_all(afu);
>> -		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>> -		pci_deconfigure_afu(afu);
>> +		if (afu != NULL) {
>> +			cxl_context_detach_all(afu);
>> +			cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
>> +			pci_deconfigure_afu(afu);
>> +		}
>
> I can see you're also checking if cxl_vphb_error_detected() is called 
> with a NULL afu from within the function, but why not move the call to 
> cxl_vphb_error_detected() within that "if (afu != NULL)...  " statement? 
> Otherwise, it looks suspicious when reading the code.
Yes, agree. However this was triggerring gcc compile warning
'maybe-uninitialized' for 'afu_result', hence removed the call to
cxl_vphb_error_detected() outside the branch. Have fixed this in v2 with
an explicit initialization of 'afu_result'.

>
>
>> @@ -2051,10 +2067,11 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>>   	 * This is not the place to be checking if everything came back up
>>   	 * properly, because there's no return value: do that in slot_reset.
>>   	 */
>> +	spin_lock(&adapter->afu_list_lock);
>>   	for (i = 0; i < adapter->slices; i++) {
>>   		afu = adapter->afu[i];
>>   
>> -		if (afu->phb == NULL)
>> +		if (afu || afu->phb == NULL)
>>   			continue;
>
>
> if (afu == NULL ...
Thanks for catching this. Have fixed this in v2.
-- 
Vaibhav Jain <vaibhav@linux.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

