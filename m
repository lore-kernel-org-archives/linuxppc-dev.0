Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4196x660TrzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:39:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 1/6] powerpc/pkeys: Enable all user-allocatable pkeys
 at init.
In-Reply-To: <1528936144-6696-2-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-2-git-send-email-linuxram@us.ibm.com>
Date: Tue, 19 Jun 2018 22:39:52 +1000
Message-ID: <878t7bx84n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> In a multithreaded application, a key allocated by one thread must
> be activate and usable on all threads.
>
> Currently this is not the case, because the UAMOR bits for all keys are
> disabled by default. When a new key is allocated in one thread, though
> the corresponding UAMOR bits for that thread get enabled, the UAMOR bits
> for all other existing threads continue to have their bits disabled.
> Other threads have no way to set permissions on the key, effectively
> making the key useless.

This all seems a bit strongly worded to me. It's arguable whether a key
should be usable by the thread that allocated it or all threads.

You could conceivably have a design where threads are blocked from using
a key until they're given permission to do so by the thread that
allocated the key.

But we're changing the behaviour to match x86 and because we don't have
an API to grant another thread access to a key. Right?

> Enable the UAMOR bits for all keys, at process creation. Since the
> contents of UAMOR are inherited at fork, all threads are capable of
> modifying the permissions on any key.
>
> BTW: changing the permission on unallocated keys has no effect, till
> those keys are not associated with any PTEs. The kernel will anyway
> disallow to association of unallocated keys with PTEs.

This is an ABI change, which is bad, but I guess we call it a bug fix
because things didn't really work previously?

I'll tag it:

  Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
  Cc: stable@vger.kernel.org # v4.16+


cheers
