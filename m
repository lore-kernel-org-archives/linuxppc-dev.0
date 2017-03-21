Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnKpb5cPrzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:39:19 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L4XjFb002295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:39:10 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29aeacbtd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:39:10 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 10:09:07 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L4d3xX10354886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 10:09:03 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L4d2aK017880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 10:09:03 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] cxl: Re-factor cxl_pci_afu_read_err_buffer()
In-Reply-To: <e3ef0cc6-9b37-c237-47ca-fd1d0e169411@au1.ibm.com>
References: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
 <20170314040606.16894-2-vaibhav@linux.vnet.ibm.com>
 <e3ef0cc6-9b37-c237-47ca-fd1d0e169411@au1.ibm.com>
Date: Tue, 21 Mar 2017 10:08:56 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvcfw8f3.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing Andrew !!

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

>> +
>> +	/* max we can copy in one read is PAGE_SIZE */
>> +	if (aligned_length > ERR_BUFF_MAX_COPY_SIZE) {
>
> I'm not sure if the name ERR_BUFF_MAX_COPY_SIZE makes sense here any
> more.

It might make sense to change to PAGE_SIZE. Will do the change in
susequent revision.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
