Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRwk52mSTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 07:50:05 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KKhkJ9096789
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 15:50:03 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3p82exh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 15:50:03 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 15:50:02 -0500
Subject: Re: [PATCH v7 2/4] powerpc/pseries: Revert 'Auto-online hotplugged
 memory'
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87wpcqkb3k.fsf@concordia.ellerman.id.au>
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 14:49:58 -0600
MIME-Version: 1.0
In-Reply-To: <87wpcqkb3k.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <fd545562-0e8c-f98e-2620-4c34752424c2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2017 10:34 PM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> 
>> Revert the patch patch to auto-online hotplugged memory, commit
>> id ec999072442a. Using the auto-online acpability does online added
>> memory but does not update the associated device struct to
>> indicate that the memory is online. The result of this is that
>> memoryXX/online file in sysfs still reports the memory as being offline.
> 
> Isn't that just a bug in the auto-online code?

After digging through the code some more and reading some of the email
chain when the auto-online feature was submitted I can't decide if this
is a bug or if this is by design. The fact that they only other users
of this appear to be balloon drivers (hv and xen) makes me think this
may be by design.

Changing the auto-online capability to call device_offline() instead
would appear to also require changes to the hv and xen balloon
drivers for the new behavior.

> 
> If I'm reading it right it's calling online_memory_block(). If that
> doesn't cause the memory_block to be online that would puzzle me.

The memory is online and usuable when the dlpar operation completes. I
was mistaken in my original note though, the state file in sysfs does report
the memory as being online. The underlying issue is that the device struct
does not get updated (dev->offline) when using the auto-online capability.
The result is that trying to remove a LMB a second time fails when we call
device_offline() which checks the dev->offline flag and returns failure.

I think reverting the patch to use the auto-online capability may be the
way to go. This would restore the code so that we call device_online and
device_offline for add and remove respectively, and not rely on what the 
auto-online code is doing.

Thoughts?

> 
> Also commit ec999072442a went into v4.8, so is memory hotplug broken
> since then? If so we need to backport this or whatever fix we come up.

Yes, we need to backport whatever fix we do.

-Nathan
> 
> cheers
> 
