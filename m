Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kWrN5zHMzF3HJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 19:02:43 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w768xUOf068550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2018 05:02:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kphp0v7h4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 05:02:40 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Aug 2018 10:02:38 +0100
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
 Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au,
 linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
 haren@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 6 Aug 2018 14:32:28 +0530
MIME-Version: 1.0
In-Reply-To: <20180805032355-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
>> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
>>>>>> Please go through these patches and review whether this approach broadly
>>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
>>>>>> the patches or the approach in general. Thank you.
>>>>>
>>>>> Jason did some work on profiling this. Unfortunately he reports
>>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
>>>>
>>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
>>>> guest and measure PPS on tap on host.
>>>>
>>>> Thanks
>>>
>>> Could you supply host configuration involved please?
>>
>> I wonder how much of that could be caused by Spectre mitigations
>> blowing up indirect function calls...
>>
>> Cheers,
>> Ben.
> 
> I won't be surprised. If yes I suggested a way to mitigate the overhead.

Did we get better results (lower regression due to indirect calls) with
the suggested mitigation ? Just curious.
