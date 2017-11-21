Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygzbS6tnFzDrTs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 19:41:56 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAL8ddwN127033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 03:41:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ece900ffb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 03:41:53 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Nov 2017 08:41:51 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/16] Remove hash page table slot tracking from linux PTE
In-Reply-To: <20171027054136.GC27483@fergus.ozlabs.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
 <20171027043430.GA27483@fergus.ozlabs.ibm.com>
 <adf2d270-29df-701f-206e-0d8a35084e47@linux.vnet.ibm.com>
 <20171027054136.GC27483@fergus.ozlabs.ibm.com>
Date: Tue, 21 Nov 2017 14:11:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sks10s7.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:
> On pseries, performance is about 2.4% worse without new hcalls, but
> that is less than 1 standard deviation.  With new hcalls, performance
> is 0.95% worse, only a third of a standard deviation.  I think we need
> to do more measurements to try to get a more accurate picture here.
>
> Were the pseries numbers done on KVM or PowerVM?  Could you do a set
> of measurements on the other one too please?  (I assume the numbers
> with the new hcall were done on KVM, and can't be done on PowerVM.)
>

I got ebizzy and kernel compile run on powernv and powervm config. You
can find the numbers below. I did 10 iterations and only added stdev and
median below. I do find powernv do better with patch series.

ebizzy run
-----------
PowerNV (ebizzy -m -n 1000 -P -s 512000 -S 100 -t 100):
With patches, 10 iterations results records/sec.
stdev =	37.60
median = 7411.5

Without patch:
stdev = 23.071
median = 7350

PowerVM numbers(./ebizzy -m -n 1000 -P -s 512000 -S 100 -t 30):
With patch (no new hcalls):
stdev = 20.721
median = 6955.5
	
Without patch	
stdev =	35.049
median = 7081

kernel compile:(time -p)
---------------------------
PowerNV:
With patches:
Real	
----	
stdev = 1.624
median = 61.56
	
User:	
stdev =	61.204
median = 4816.73
	
Sys:	
stdev =	4.367
median = 387.575

Without patches:
Real:	
stdev =	1.318
median = 63.635
	
User:	
stdev =	50.531
median = 4820.51
	
	
Sys:	
stdev =	6.409
median = 389.765

PowerVM numbers:
-------------------
With patches (no new hcalls):
Real:	
stdev =	3.016
median = 442.745
	
	
User:	
stdev =	9.738
median = 5507.87
	
Sys:	
stdev =	0.223
median = 176.455

Witout patches:
Real:
stdev = 0.720
median = 442.445

User:
stdev = 8.621
median = 5501.615

Sys:
stdev = 0.189
median = 173.3
