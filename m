Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHns80lFdzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:12:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M94Aoa057678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:12:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y4q68mfh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:12:24 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 10:12:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DF081B08061
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 10:13:58 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M9CJBQ65601780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 09:12:19 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M9CJRE009092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 03:12:19 -0600
Subject: Re: TM Bad Thing exception easily raised from userspace
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
 <20160819202331.GA18558@gate.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Simon Guo <wei.guo.simon@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 11:12:17 +0200
MIME-Version: 1.0
In-Reply-To: <20160819202331.GA18558@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <01a2fdc9-4cf7-a1d9-72bf-c22f7bb7865d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/08/2016 22:23, Segher Boessenkool wrote:
> Completely off-topic, but...
> 
> On Fri, Aug 19, 2016 at 07:21:44PM +0200, Laurent Dufour wrote:
>>     asm __volatile__(
>> 	"li		3,1		;"
>> 	"tbegin.			;"
>> 	"beq		1f		;"
>> 	"li		3,0		;"
>> 	"tsuspend.			;"
>> 	"1:				;"
>> 	"std		3, %[ret]	;"
>> 	: [ret]"=m"(ret)
>> 	:
>> 	: "memory", "3");
> 
> This asm clobbers CR0, so you should add a "cc" or "cr0" clobber here.
> When you use "m" you need "%X" as well, i.e.
> 	std%X[ret] 3,%[ret]
> 
> (Nowadays you only need "%U" if you use "m<>", but you still need "%X".
> Come to think of it, the kernel supports really old GCC, right?  So you
> need "std%U[ret]%X[ret] 3,%[ret]").

Thanks Segher for these advices, I'll keep them in mind.
