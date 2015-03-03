Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53BF21A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 08:19:01 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 3 Mar 2015 16:18:59 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 64BE738C8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 16:18:56 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t23LIuCs31195148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Mar 2015 21:18:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t23LIsii031777
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Mar 2015 16:18:55 -0500
Message-ID: <54F6253E.5000109@linux.vnet.ibm.com>
Date: Tue, 03 Mar 2015 13:18:54 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/pseries: Expose post-migration in kernel
 device tree update to drmgr
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425363843.20929.2.camel@ellerman.id.au>
In-Reply-To: <1425363843.20929.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2015 10:24 PM, Michael Ellerman wrote:
> On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
>> Traditionally after a migration operation drmgr has coordinated the device tree
>> update with the kernel in userspace via the ugly /proc/ppc64/ofdt interface. This
>> can be better done fully in the kernel where support already exists. Currently,
>> drmgr makes a faux ibm,suspend-me RTAS call which we intercept in the kernel so
>> that we can check VASI state for suspendability. After the LPAR resumes and
>> returns to drmgr that is followed by the necessary update-nodes and
>> update-properties RTAS calls which are parsed and communitated back to the kernel
>> through /proc/ppc64/ofdt for the device tree update. The drmgr tool should
>> instead initiate the migration using the already existing
>> /sysfs/kernel/mobility/migration entry that performs all this work in the kernel.
>>
>> This patch adds a show function to the sysfs "migration" attribute that returns
>> 1 to indicate the kernel will perform the device tree update after a migration
>> operation and that drmgr should initiated the migration through the sysfs
>> "migration" attribute.
> 
> I don't understand why we need this?
> 
> Can't drmgr just check if /sysfs/kernel/mobility/migration exists, and if so it
> knows it should use it and that the kernel will handle the whole procedure?

The problem is that this sysfs entry was originally added with the
remainder of the in kernel device tree update code in 2.6.37, but drmgr
was never modified to use it. By the time I started looking at the
in-kernel device tree code I found it very broken. I had bunch of fixes
to get it working that went into 3.12.

So, if somebody were to use a newer version of drmgr that simply checks
for the existence of the migration sysfs entry on a pre-3.12 kernel
their device-tree update experience is going to be sub-par.

The approach taken here is identical to what was done in 9da3489 when we
hooked the device tree update code into the suspend code. However, in
that case we were already using the sysfs entry to trigger the suspend
and legitimately needed a way to tell drmgr the kernel was now taking
care of updating the device tree. Here we are really just trying to
inform drmgr that it is running on a new enough kernel that the kernel
device tree code actually works properly.

Now, I don't really care for this approach, but the only other thought I
had was to change the sysfs entry from "migration" to "migrate".

-Tyrel

> 
> cheers
> 
> 
