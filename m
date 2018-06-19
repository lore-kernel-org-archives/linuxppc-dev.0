Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4196xP2CdDzF0wb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:40:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 5/6] powerpc/pkeys: make protection key 0 less special
In-Reply-To: <1528936144-6696-6-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-6-git-send-email-linuxram@us.ibm.com>
Date: Tue, 19 Jun 2018 22:40:08 +1000
Message-ID: <8736xjx847.fsf@concordia.ellerman.id.au>
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
> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close to
> providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0 to
> the address range.
>
> Lets make pkey-0 less special and treat it almost like any other key.
> Thus it can be explicitly associated with any address range, and can be
> freed. This gives the application more flexibility and power.  The
> ability to free pkey-0 must be used responsibily, since pkey-0 is
> associated with almost all address-range by default.
>
> Even with this change pkey-0 continues to be slightly more special
> from the following point of view.
> (a) it is implicitly allocated.
> (b) it is the default key assigned to any address-range.
> (c) its permissions cannot be modified by userspace.
>
> NOTE: (c) is specific to powerpc only. pkey-0 is associated by default
> with all pages including kernel pages, and pkeys are also active in
> kernel mode. If any permission is denied on pkey-0, the kernel running
> in the context of the application will be unable to operate.

We could fix that by saving/restoring the AMR when we come into the
kernel, and switching to a kernel-AMR with all keys accessible.

We'd then need to think about copy_to/from_user() gup etc. So maybe we
don't want to do that. But it's not set in stone.

Are we calling this a bug fix?

cheers
