Return-Path: <nfont@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A11321A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 14:06:43 +1100 (AEDT)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E6AE31400D2
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 14:06:42 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 20:06:41 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3B2671FF0041
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 19:55:22 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB436bUD49807592
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 20:06:37 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB436atd002794
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 20:06:37 -0700
Message-ID: <547FCFBB.8000408@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 21:06:35 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Right location in sysfs for dlpar file
References: <1417057941.5089.81.camel@kernel.crashing.org>
 <547C8C0F.5070701@linux.vnet.ibm.com> <1417496963.31336.6.camel@concordia>
In-Reply-To: <1417496963.31336.6.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 11:09 PM, Michael Ellerman wrote:
> On Mon, 2014-12-01 at 09:41 -0600, Nathan Fontenot wrote:
>> On 11/26/2014 09:12 PM, Benjamin Herrenschmidt wrote:
>>> Hi Greg,
>>>
>>> So Nathan is working on a patch series to cleanup and improve our
>>> "DLPAR" infrastructure which is basically our hotplug mechanism when
>>> running under the PowerVM (aka pHyp) and KVM hypervisors.
>>
>> The cleanup to the dlpar infrastructure will move the entire operation
>> of hotplugging a device to the kernel instead of doing it partially in
>> userspace and partially in the kernel as is currently done.
>>
> ...
>>
>> For PowerVM systems we need this sysfs file to deliver what is
>> essentially a binary blob (specifically a rtas error log) to the
>> kernel.
> 
> Those two statements don't really agree with each other. ie. "move the entire
> operation .. to the kernel", but then we need a sysfs file so userspace can
> deliver us a blob?
> 
> I think what you mean is that all the actual logic will move into the kernel,
> and the only thing userspace will do (on PowerVM) is write the blog to kick off
> the process.
> 
> On PowerKVM the entire process will be handled in the kernel (after some
> additional patches to hook up the rtas event to the hotplug).
> 

This is correct. I should have explained it better.

> 
> As ugly as it is, we already have /proc/rtas, which includes a bunch of files,
> including error_log, which is where you can *read* the RTAS error logs from.
>

I have no problem making this a writeable file. I think keeping all of the rtas
error log communication between the kernel userspace in one place would be a good
idea.
 
> So maybe we just extend that, either a new file, or just by making error_log
> writable?
> 
> It'd be nice to drop all that rtas gunk and move to something cleaner in /sys,
> but I don't think we can realistically do that any time soon anyway?
> 

Perhaps doing this at a later time would be worthwhile.

-Nathan
