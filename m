Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419D7y3sd3zF0wq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:34:38 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JGYCMd075619
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:34:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jq2tvqucu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:34:35 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Jun 2018 17:34:33 +0100
Date: Tue, 19 Jun 2018 09:34:24 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 5/6] powerpc/pkeys: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-6-git-send-email-linuxram@us.ibm.com>
 <8736xjx847.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <8736xjx847.fsf@concordia.ellerman.id.au>
Message-Id: <20180619163424.GF5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:40:08PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > Applications need the ability to associate an address-range with some
> > key and latter revert to its initial default key. Pkey-0 comes close to
> > providing this function but falls short, because the current
> > implementation disallows applications to explicitly associate pkey-0 to
> > the address range.
> >
> > Lets make pkey-0 less special and treat it almost like any other key.
> > Thus it can be explicitly associated with any address range, and can be
> > freed. This gives the application more flexibility and power.  The
> > ability to free pkey-0 must be used responsibily, since pkey-0 is
> > associated with almost all address-range by default.
> >
> > Even with this change pkey-0 continues to be slightly more special
> > from the following point of view.
> > (a) it is implicitly allocated.
> > (b) it is the default key assigned to any address-range.
> > (c) its permissions cannot be modified by userspace.
> >
> > NOTE: (c) is specific to powerpc only. pkey-0 is associated by default
> > with all pages including kernel pages, and pkeys are also active in
> > kernel mode. If any permission is denied on pkey-0, the kernel running
> > in the context of the application will be unable to operate.
> 
> We could fix that by saving/restoring the AMR when we come into the
> kernel, and switching to a kernel-AMR with all keys accessible.
> 
> We'd then need to think about copy_to/from_user() gup etc. So maybe we
> don't want to do that. But it's not set in stone.
> 
> Are we calling this a bug fix?

Actually, I call it borderline bug fix. Its more of a feature.

RP
