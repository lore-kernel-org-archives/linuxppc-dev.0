Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp7K02PSBzDrL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 16:49:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u945mfvQ119497
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 01:49:21 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25uy9mek8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 01:49:21 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 4 Oct 2016 11:19:18 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 06C733940033
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:19:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u945nEV74325536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 11:19:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u945nDD5012774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Oct 2016 11:19:14 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cxl: Flush PSL cache before resetting the adapter
In-Reply-To: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1475523362-4419-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Tue, 04 Oct 2016 11:19:09 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wphowtnu.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fred,

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

>
> +	/* the adapter is about to be reset, so ignore errors */
> +	cxl_data_cache_flush(adapter);
> +
Will be a good idea if we return error and not let the reset to proceed,
if cxl_data_cache_flush returns EBUSY as continuing again may cause the
UE error.

~ Vaibhav
