Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLlB43V5HzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 18:23:40 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O7NDNl097426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:23:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dt0na1mb6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:23:38 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 24 Oct 2017 03:23:36 -0400
Date: Tue, 24 Oct 2017 00:23:30 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
 <87zi8hvz3m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zi8hvz3m.fsf@linux.vnet.ibm.com>
Message-Id: <20171024072330.GI5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2017 at 11:58:29AM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
>  +
> > +#define mm_set_pkey_is_allocated(mm, pkey)	\
> > +	(mm_pkey_allocation_map(mm) & pkey_alloc_mask(pkey))
> > +
> 
> >  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> >  {
> > -	return (pkey == 0);
> > +	/* a reserved key is never considered as 'explicitly allocated' */
> > +	return ((pkey < arch_max_pkey()) &&
> > +		!mm_set_pkey_is_reserved(mm, pkey) &&
> > +		mm_set_pkey_is_allocated(mm, pkey));
> >  }
> >
> 
> that is confusing naming. what is mm_set_pkey_is_allocated()? . 'set' in
> that name is confusing.

will change it by removing the 'set' in the names.

thanks,
RP
