Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C5C1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 21:56:44 +1100 (AEDT)
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C5891402BF
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 21:56:42 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 10:56:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id ABFB717D8066
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 10:56:43 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0MAubpm5243256
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 10:56:37 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M9uc1D009566
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 02:56:38 -0700
Subject: Re: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
To: Michael Neuling <michael.neuling@au1.ibm.com>, ian@ozlabs.au.ibm.com,
 linuxppc-dev@ozlabs.org
References: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1453256449.28504.56.camel@au.ibm.com> <56A12814.5080607@linux.vnet.ibm.com>
 <1453423130.4239.51.camel@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56A20AE3.5060709@linux.vnet.ibm.com>
Date: Fri, 22 Jan 2016 11:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <1453423130.4239.51.camel@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/01/2016 01:38, Michael Neuling a écrit :
> On Thu, 2016-01-21 at 19:48 +0100, Frederic Barrat wrote:
>>
>> Le 20/01/2016 03:20, Michael Neuling a écrit :
>>> The only thing I'm a bit concerned about is are we going to end up
>>> duplicating a lot of the linux PCI API, but I guess we are only going
>>> to do this for things the papr HCALL interface mimics.
>>
>> There are actually very few operations we can do on the adapter with
>> hcalls. papr defines 'reset', 'read the VPD' and flashing a new image on
>> the card. So we'll soon run out of APIs to mimic.
>>
>> I guess it means the usage of cxl_get_phys_dev() should be discouraged,
>> since it's going to lead to different behaviors between bare-metal and
>> powerVM guest. Was there another expected use case for a kernel driver
>> other than accessing the VPD?
>
> It was just for VPD.  I figured it was the easiest way to add it. Maybe
> it's worth getting rid of it in favour of VPD only.
>
> If you want to remove it I'd be happy, but you'll need to coordinate
> with the cxlflash driver.  You can probably just write the patch for
> them and then get their ACK on it.

Ok, then I would also be tempted to remove it. I'll sync with cxlflash 
to do so.
Thanks!

   Fred
