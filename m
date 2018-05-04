Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d3Lz5bWhzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 06:21:30 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w44KEGTn168938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 May 2018 16:21:27 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hrunux952-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 16:21:27 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 4 May 2018 21:21:25 +0100
Date: Fri, 4 May 2018 13:21:14 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <373dffe1-4752-5eb0-f97c-a06fe0e0fdb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <373dffe1-4752-5eb0-f97c-a06fe0e0fdb5@intel.com>
Message-Id: <20180504202114.GA5867@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 04, 2018 at 12:59:27PM -0700, Dave Hansen wrote:
> On 05/04/2018 12:22 PM, Ram Pai wrote:
> > @@ -407,9 +414,6 @@ static bool pkey_access_permitted(int pkey, bool write, bool execute)
> >  	int pkey_shift;
> >  	u64 amr;
> >  
> > -	if (!pkey)
> > -		return true;
> > -
> >  	if (!is_pkey_enabled(pkey))
> >  		return true;
> 
> Looks fine to me.  Obviously doesn't have any impact on x86 or the
> generic code.
> 
> One question, though.  Which other check makes up for this removed !pkey
> check?

is_pkey_enabled() does take care of it.  we do not enable userspace to
change permissions on pkey-0. This information is tracked in
UAMOR register.  is_pkey_enabled() refers to UAMOR to determine
if the given key is modifiable by userspace. since UAMOR has the bit
corresponding to key-0 set to 0, is_pkey_enabled(key-0) will return
false. 

The deleted code above, would have done the same job without
referring UAMOR. However having special checks on pkey-0 makes
pkey-0 special. It defeats the purpose of this patch; which is to make
pkey-0 less special :).


-- 
Ram Pai
