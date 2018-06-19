Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419DDN16wlzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:38:27 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JGYFxl078545
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:38:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq1sju2nq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:38:25 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Jun 2018 17:38:22 +0100
Date: Tue, 19 Jun 2018 09:38:13 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 4/6] powerpc/pkeys: Preallocate execute-only key
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-5-git-send-email-linuxram@us.ibm.com>
 <871sd3x842.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <871sd3x842.fsf@concordia.ellerman.id.au>
Message-Id: <20180619163813.GG5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:40:13PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > execute-only key is allocated dynamically. This is a problem.  When a
> > thread implicitly creates a execute-only key, and resets UAMOR for that
> > key, the UAMOR value does not percolate to all the other threads.  Any
> > other thread may ignorantly change the permissions on the key.  This can
> > cause the key to be not execute-only for that thread.
> >
> > Preallocate the execute-only key and ensure that no thread can change
> > the permission of the key, by resetting the corresponding bit in UAMOR.
> 
> OK this is a non-ABI changing bug fix AFAICS.
> 
> I'll add:
> 
>   Fixes: 5586cf61e108 ("powerpc: introduce execute-only pkey")
>   Cc: stable@vger.kernel.org # v4.16+
> 
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index b681bec..1f2389f 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -25,6 +25,7 @@
> >  #define IAMR_EX_BIT 0x1UL
> >  #define PKEY_REG_BITS (sizeof(u64)*8)
> >  #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
> > +#define EXECUTE_ONLY_KEY 2
> 
> Do we ensure we have at least 3 keys anywhere?

No. Good to add. Can this be different patch?

However we do not have any systems with less than 16keys AFAICT.

RP
