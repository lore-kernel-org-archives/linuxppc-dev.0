Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15C851A074A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 22:17:13 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 18 Nov 2015 11:17:10 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9CB3D17D8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 11:17:29 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAIBH7xT62259258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 11:17:07 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAIBH6ZO013320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 04:17:07 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1447838334.1564.2.camel@ellerman.id.au>
 <564C5BBC.8020701@linux.vnet.ibm.com>
 <1447845043.7303.1.camel@ellerman.id.au>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <564C5E31.70200@linux.vnet.ibm.com>
Date: Wed, 18 Nov 2015 12:17:05 +0100
MIME-Version: 1.0
In-Reply-To: <1447845043.7303.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/11/2015 12:10, Michael Ellerman wrote:
> On Wed, 2015-11-18 at 12:06 +0100, Laurent Dufour wrote:
>> On 18/11/2015 10:18, Michael Ellerman wrote:
>>> Hi folks,
>>>
>>> I'm intermittently seeing the following oops on at least one powerpc box.
>>>
>>> The BUG_ON() is from:
>>>
>>> static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
>>> {
>>> 	...
>>> 	count = blk_rq_map_sg(req->q, req, sdb->table.sgl);
>>> 	BUG_ON(count > sdb->table.nents);
>>>
>>> Looking at the dump it looks like count was 2, I can't work out what nents was.
>>>
>>> The machine's just a fairly boring bare metal setup, with a single IPR adapter:
>>>
>>> 0001:08:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 02)
>>> 	Subsystem: IBM PCIe3 x8 SAS RAID Internal Adapter 6Gb (57D7)
>>> 	Flags: bus master, fast devsel, latency 0
>>> 	Kernel driver in use: ipr
>>>
>>>
>>> Anyone seen it before or have any ideas?
>>
>> Hi Michael,
>>
>> I'm facing the same panic on my bare metal system.
>>
>> Sounds to be raised by the latest update to 4.4-rc1
> 
> Yeah I think it's new since 4.3.
> 
> Do you see it regularly, or just every now and then?

I got it almost every time I'm stressing the system's memory, but I
can't state if it's tied or not.

I can't remember having seeing it with 4.3, I'll double check that and
getting back to you.

Laurent.
