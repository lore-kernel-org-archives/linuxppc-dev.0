Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfb0T1PL9zF0ZJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 04:10:32 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1BH9B6H137367
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 12:10:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g2ewh6b2b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 12:10:30 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Sun, 11 Feb 2018 17:10:28 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 2/3] cxl: Introduce module parameter 'enable_psltrace'
In-Reply-To: <a3880a5d-6ccb-9a90-14e5-d48376e4c8e0@linux.vnet.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
 <20180209042535.16845-3-vaibhav@linux.vnet.ibm.com>
 <a3880a5d-6ccb-9a90-14e5-d48376e4c8e0@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 22:40:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a7wf4flx.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing the patch Christophe,

christophe lombard <clombard@linux.vnet.ibm.com> writes:
>> +bool cxl_enable_psltrace = true;
>> +module_param_named(enable_psltrace, cxl_enable_psltrace, bool, 0600);
>> +MODULE_PARM_DESC(enable_psltrace, "Set PSL traces on probe. default: on");
>> +
> I am not too agree to add a new parameter. This can cause doubts.
> PSL team has confirmed that enabling traces has no impact.
> Do you see any reason to disable the traces ?

Traces on PSL follow a 'set and fetch' model. So once the trace buffer for
a specific array is full it will stop and switch to 'FIN' state and at
that point we need to fetch the trace-data and reinit the array to
re-arm it.

There might be some circumstances where this model may lead to confusion
specifically when AFU developers assume that the trace arrays are
already armed and dont re-arm it causing miss of trace data.

So this module param is a compromise to keep the old behaviour of traces
array intact where in the arming/disarming of the trace arrays is
controlled completely by userspace tooling and not by cxl.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
