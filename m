Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6r4k16RgzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2016 14:21:10 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r6r4j3Ndsz9t5c
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:21:09 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 15 May 2016 09:51:07 +0530
Subject: Re: [PATCH 2/3] powerpc/book3s: Fix TB corruption in guest exit path
 on HMI interrupt.
To: Paul Mackerras <paulus@ozlabs.org>
References: <20160114031457.1287.32132.stgit@mars>
 <20160114031503.1287.54860.stgit@mars>
 <20160318045132.GB1393@fergus.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 KVM-PPC <kvm-ppc@vger.kernel.org>, KVM <kvm@vger.kernel.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Message-ID: <5737F92F.6090202@linux.vnet.ibm.com>
Date: Sun, 15 May 2016 09:51:03 +0530
MIME-Version: 1.0
In-Reply-To: <20160318045132.GB1393@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/18/2016 10:21 AM, Paul Mackerras wrote:
> On Thu, Jan 14, 2016 at 08:45:04AM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> When a guest is assigned to a core it converts the host Timebase (TB)
>> into guest TB by adding guest timebase offset before entering into
>> guest. During guest exit it restores the guest TB to host TB. This means
>> under certain conditions (Guest migration) host TB and guest TB can differ.
>>
>> When we get an HMI for TB related issues the opal HMI handler would
>> try fixing errors and restore the correct host TB value. With no guest
>> running, we don't have any issues. But with guest running on the core
>> we run into TB corruption issues.
>>
>> If we get an HMI while in the guest, the current HMI handler invokes opal
>> hmi handler before forcing guest to exit. The guest exit path subtracts
>> the guest TB offset from the current TB value which may have already
>> been restored with host value by opal hmi handler. This leads to incorrect
>> host and guest TB values.
>>
>> With split-core, things become more complex. With split-core, TB also gets
>> split and each subcore gets its own TB register. When a hmi handler fixes
>> a TB error and restores the TB value, it affects all the TB values of
>> sibling subcores on the same core. On TB errors all the thread in the core
>> gets HMI. With existing code, the individual threads call opal hmi handle
>> independently which can easily throw TB out of sync if we have guest
>> running on subcores. Hence we will need to co-ordinate with all the
>> threads before making opal hmi handler call followed by TB resync.
>>
>> This patch introduces a sibling subcore state structure (shared by all
>> threads in the core) in paca which holds information about whether sibling
>> subcores are in Guest mode or host mode. An array in_guest[] of size
>> MAX_SUBCORE_PER_CORE=4 is used to maintain the state of each subcore.
>> The subcore id is used as index into in_guest[] array. Only primary
>> thread entering/exiting the guest is responsible to set/unset its
>> designated array element.
>>
>> On TB error, we get HMI interrupt on every thread on the core. Upon HMI,
>> this patch will now force guest to vacate the core/subcore. Primary
>> thread from each subcore will then turn off its respective bit
>> from the above bitmap during the guest exit path just after the
>> guest->host partition switch is complete.
>>
>> All other threads that have just exited the guest OR were already in host
>> will wait until all other subcores clears their respective bit.
>> Once all the subcores turn off their respective bit, all threads will
>> will make call to opal hmi handler.
>>
>> It is not necessary that opal hmi handler would resync the TB value for
>> every HMI interrupts. It would do so only for the HMI caused due to
>> TB errors. For rest, it would not touch TB value. Hence to make things
>> simpler, primary thread would call TB resync explicitly once for each
>> core immediately after opal hmi handler instead of subtracting guest
>> offset from TB. TB resync call will restore the TB with host value.
>> Thus we can be sure about the TB state.
>>
>> One of the primary threads exiting the guest will take up the
>> responsibility of calling TB resync. It will use one of the top bits
>> (bit 63) from subcore state flags bitmap to make the decision. The first
>> primary thread (among the subcores) that is able to set the bit will
>> have to call the TB resync. Rest all other threads will wait until TB
>> resync is complete.  Once TB resync is complete all threads will then
>> proceed.

Hi Paul,

I am extremely sorry for late reply. This mail somehow slipped under my
nose.

> 
> This patch looks pretty good; the one nit that I can see is that you
> have a vcpu parameter to kvmppc_realmode_hmi_handler which is
> completely unused; which is just as well, because you get it from r9
> at the point where it is called, but at that point r9 may or may not
> contain a vcpu pointer, depending on the path we take to get there.
> 
> Why not just remove the vcpu argument?
> 
> Also, patch 3/3 seems like it is just something that was missed from
> this patch (2/3).  Why not fold it in?

Agree. I have sent out v2 with above changes:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-May/143148.html

Thanks,
-Mahesh.
