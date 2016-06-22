Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZR8n1BK9zDqlL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 00:01:28 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDxS9b002693
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:01:27 -0400
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6ym1bsg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:01:26 -0400
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 15:01:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E53512190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:00:50 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5ME1KH316318902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 14:01:20 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5ME1JPF015244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 10:01:19 -0400
Date: Wed, 22 Jun 2016 16:02:55 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 mrochs@linux.vnet.ibm.com, imunsie@au1.ibm.com, manoj@linux.vnet.ibm.com
Subject: Re: [v6, 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
 <87k2hkgs6v.fsf@vajain21.in.ibm.com>
In-Reply-To: <87k2hkgs6v.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Message-Id: <576A9A8F.1080602@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Should also check against the length of user-buffer (count) provided in the read
> call.Ideally this condition check should be moved to the read call where
> you have access to the count variable.
> 
> Right now libcxl is using a harcoded value of CXL_READ_MIN_SIZE to
> issue the read call and in kernel code we have a check to ensure that
> read buffer is atleast CXL_READ_MIN_SIZE in size.
> 
> But it might be a good idea to decouple driver from
> CXL_MAX_EVENT_DATA_SIZE. Ideally the maximum event size that we can
> support should be dependent on the amount user buffer we receive in the
> read call. That way future libcxl can support larger event_data without
> needing a change to the cxl.h
> 
[...]
>>+#define CXL_MAX_EVENT_DATA_SIZE 128
>>+
> 
> 
> Agree with Matt's earlier comments. 128 is very small and I would prefer
> for atleast a page size (4k/64K) limit.
> 

afu_read() enforces a minimum buffer size of CXL_READ_MIN_SIZE = 4K, as documented in Documentation/powerpc/cxl.txt. This information is missing from the man pages of the libcxl functions cxl_read_event/cxl_read_expected_event. I will fix these.

Regarding the maximum event size, as afu_read returns one event per call, and as there is no API to tell userland the maximum size of a cxl event, I think that we should simply use (and document) the same value (4K) as the maximum cxl event size.

Philippe
