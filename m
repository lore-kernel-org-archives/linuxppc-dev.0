Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK4DR3tqwzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 18:04:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4583n0B085838
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 04:04:16 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a8hw3rtgs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 04:04:11 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 5 May 2017 17:47:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v457ksDs43319418
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 17:47:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v457kTFQ014097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 17:46:29 +1000
Subject: Re: [PATCH] cxl: Unlock on error in probe
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170505053622.0670F124037@b01ledav002.gho.pok.ibm.com>
 <a4c0a3f6-f631-0998-ddd0-ca2efd4f1bfd@au1.ibm.com>
 <20170505073800.4F753124037@b01ledav002.gho.pok.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 5 May 2017 17:46:05 +1000
MIME-Version: 1.0
In-Reply-To: <20170505073800.4F753124037@b01ledav002.gho.pok.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c275cb27-e31c-78a8-3672-85014b9c7776@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/17 17:37, Dan Carpenter wrote:
> On Fri, May 05, 2017 at 05:14:15PM +1000, Andrew Donnellan wrote:
>> sem is a global and it looks like it's intended to be held after
>> device_open() returns and only released in device_close(), so this looks
>> wrong.
>>
>
> This doesn't affect the success path, it only means that if
> device_open() fails because we don't have enough free memory or whatever
> then we can try again later.

Argh, I completely missed the "return 0" above err1 and thought the 
success path fell through. My mistake, that's what I get for trying to 
review patches after staring at hardware simulation logs all day...

In that case, the patch looks fine to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
