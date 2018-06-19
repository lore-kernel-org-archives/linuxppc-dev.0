Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4199HP6py8zF0wy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 00:25:53 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JEO8Im077228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 10:25:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq34e9j4k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 10:25:50 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Jun 2018 15:25:47 +0100
Date: Tue, 19 Jun 2018 07:25:37 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 1/6] powerpc/pkeys: Enable all user-allocatable pkeys
 at init.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-2-git-send-email-linuxram@us.ibm.com>
 <878t7bx84n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <878t7bx84n.fsf@concordia.ellerman.id.au>
Message-Id: <20180619142537.GC5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:39:52PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > In a multithreaded application, a key allocated by one thread must
> > be activate and usable on all threads.
> >
> > Currently this is not the case, because the UAMOR bits for all keys are
> > disabled by default. When a new key is allocated in one thread, though
> > the corresponding UAMOR bits for that thread get enabled, the UAMOR bits
> > for all other existing threads continue to have their bits disabled.
> > Other threads have no way to set permissions on the key, effectively
> > making the key useless.
> 
> This all seems a bit strongly worded to me. It's arguable whether a key
> should be usable by the thread that allocated it or all threads.
> 
> You could conceivably have a design where threads are blocked from using
> a key until they're given permission to do so by the thread that
> allocated the key.
> 
> But we're changing the behaviour to match x86 and because we don't have
> an API to grant another thread access to a key. Right?
> 

correct. The other threads have no way to access or change the
permissions on the key.


> > Enable the UAMOR bits for all keys, at process creation. Since the
> > contents of UAMOR are inherited at fork, all threads are capable of
> > modifying the permissions on any key.
> >
> > BTW: changing the permission on unallocated keys has no effect, till
> > those keys are not associated with any PTEs. The kernel will anyway
> > disallow to association of unallocated keys with PTEs.
> 
> This is an ABI change, which is bad, but I guess we call it a bug fix
> because things didn't really work previously?

Yes its a behaviorial change for the better. There is no downside
to the change because no applications should break. Single threaded
apps will continue to just work fine. Multithreaded applications,
which were unable to consume the API/ABI, will now be able to do so.

> 
> I'll tag it:
> 
>   Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
>   Cc: stable@vger.kernel.org # v4.16+

thanks,
RP
