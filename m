Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BT8s71ywzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 03:24:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5LHOC1J126881
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 13:24:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jrekb4km2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 13:24:42 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 21 Jun 2018 18:24:40 +0100
Date: Thu, 21 Jun 2018 10:24:29 -0700
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
 <20180619142537.GC5294@ram.oc3035372033.ibm.com>
 <878t78wzb6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <878t78wzb6.fsf@concordia.ellerman.id.au>
Message-Id: <20180621172429.GJ5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 21, 2018 at 02:14:53PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > On Tue, Jun 19, 2018 at 10:39:52PM +1000, Michael Ellerman wrote:
> >> Ram Pai <linuxram@us.ibm.com> writes:
> >> 
> >> > In a multithreaded application, a key allocated by one thread must
> >> > be activate and usable on all threads.
> >> >
> >> > Currently this is not the case, because the UAMOR bits for all keys are
> >> > disabled by default. When a new key is allocated in one thread, though
> >> > the corresponding UAMOR bits for that thread get enabled, the UAMOR bits
> >> > for all other existing threads continue to have their bits disabled.
> >> > Other threads have no way to set permissions on the key, effectively
> >> > making the key useless.
> >> 
> >> This all seems a bit strongly worded to me. It's arguable whether a key
> >> should be usable by the thread that allocated it or all threads.
> >> 
> >> You could conceivably have a design where threads are blocked from using
> >> a key until they're given permission to do so by the thread that
> >> allocated the key.
> >> 
> >> But we're changing the behaviour to match x86 and because we don't have
> >> an API to grant another thread access to a key. Right?
> >
> > correct. The other threads have no way to access or change the
> > permissions on the key.
> 
> OK.
> 
> Though prior to patch 6 all threads have read/write permissions for all
> keys, so they don't necessarily need to change permissions on a key
> allocated by another thread.
> 
> >> > Enable the UAMOR bits for all keys, at process creation. Since the
> >> > contents of UAMOR are inherited at fork, all threads are capable of
> >> > modifying the permissions on any key.
> >> >
> >> > BTW: changing the permission on unallocated keys has no effect, till
> >> > those keys are not associated with any PTEs. The kernel will anyway
> >> > disallow to association of unallocated keys with PTEs.
> >> 
> >> This is an ABI change, which is bad, but I guess we call it a bug fix
> >> because things didn't really work previously?
> >
> > Yes its a behaviorial change for the better. There is no downside
> > to the change because no applications should break. Single threaded
> > apps will continue to just work fine. Multithreaded applications,
> > which were unable to consume the API/ABI, will now be able to do so.
> 
> Multi-threaded applications were able to use the API, as long as they
> were satisfied with the semantics it provided, ie. that restrictions on
> a key were only possible on the thread that allocated the key.
> 
> I'm not trying to argue for the sake of it, it's important that we
> understand the subtleties of what we're changing and how it affects
> existing software - even if we think there is essentially no existing
> software.
> 
> I'll try and massage the change log to capture it.
> 
> I ended up with what's below.
> 
> cheers
> 
>   powerpc/pkeys: Give all threads control of their key permissions
>   
>   Currently in a multithreaded application, a key allocated by one
>   thread is not usable by other threads. By "not usable" we mean that
>   other threads are unable to change the access permissions for that
>   key for themselves.
>   
>   When a new key is allocated in one thread, the corresponding UAMOR
>   bits for that thread get enabled, however the UAMOR bits for that key
>   for all other threads remain disabled.
>   
>   Other threads have no way to set permissions on the key, and the
>   current default permissions are that read/write is enabled for all
>   keys, which means the key has no effect for other threads. Although
>   that may be the desired behaviour in some circumstances, having all
>   threads able to control their permissions for the key is more
>   flexible.
>   
>   The current behaviour also differs from the x86 behaviour, which is
>   problematic for users.
>   
>   To fix this, enable the UAMOR bits for all keys, at process
>   creation (in start_thread(), ie exec time). Since the contents of
>   UAMOR are inherited at fork, all threads are capable of modifying the
>   permissions on any key.
>   
>   This is technically an ABI break on powerpc, but pkey support is
>   fairly new on powerpc and not widely used, and this brings us into
>   line with x86.

Wow! yes it crisply captures the subtle API change and the reasoning
behind it.

RP
