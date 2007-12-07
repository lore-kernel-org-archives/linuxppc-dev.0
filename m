Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD9ACDDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:26:41 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7MQcNw016184
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:26:38 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7MQbIg137106
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:26:37 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7MQbAa014890
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:26:37 -0500
Message-ID: <4759C89B.9000709@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:56:35 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207221106.GH16824@localdomain>
In-Reply-To: <20071207221106.GH16824@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Hi Balbir-
> 
> Balbir Singh wrote:
>>
>> Here's a dumb simple implementation of fake NUMA nodes for PowerPC. Fake
>> NUMA nodes can be specified using the following command line option
>>
>> numa=fake=<node range>
>>
>> node range is of the format <range1>,<range2>,...<rangeN>
>>
>> Each of the rangeX parameters is passed using memparse(). I find the patch
>> useful for fake NUMA emulation on my simple PowerPC machine. I've tested it
>> on a non-numa box with the following arguments
>>
>> numa=fake=1G
>> numa=fake=1G,2G
>> name=fake=1G,512M,2G
>> numa=fake=1500M,2800M mem=3500M
>> numa=fake=1G mem=512M
>> numa=fake=1G mem=1G
> 
> So this doesn't appear to allow one to assign cpus to fake nodes?  Do
> all cpus just get assigned to node 0 with numa=fake?
> 

Yes, they all appear on node 0. We could have tweaks to distribute CPU's
as well.

> A different approach that occurs to me is to use kexec with a doctored
> device tree (i.e. with the ibm,associativity properties modified to
> reflect your desired topology).  Perhaps a little bit obscure, but it
> seems more flexible.
> 

That would be interesting, but it always means that we need to run
kexec, which might involve two boots.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
