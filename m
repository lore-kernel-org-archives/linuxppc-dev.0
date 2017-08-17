Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYJ5H39c2zDrJ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 06:40:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HKeguH023787
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 16:40:49 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cddrjx2mx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 16:40:48 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 14:40:48 -0600
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-3-git-send-email-linuxram@us.ibm.com>
 <8760dvkw58.fsf@linux.vnet.ibm.com>
 <20170817154831.GB5505@ram.oc3035372033.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mhocko@kernel.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [RFC v7 02/25] powerpc: track allocation status of all pkeys
In-reply-to: <20170817154831.GB5505@ram.oc3035372033.ibm.com>
Date: Thu, 17 Aug 2017 17:40:37 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d17uylkq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> On Thu, Aug 10, 2017 at 05:25:39PM -0300, Thiago Jung Bauermann wrote:
>> 
>> Ram Pai <linuxram@us.ibm.com> writes:
>> >  static inline void pkey_initialize(void)
>> >  {
>> > +	int os_reserved, i;
>> > +
>> >  	/* disable the pkey system till everything
>> >  	 * is in place. A patch further down the
>> >  	 * line will enable it.
>> >  	 */
>> >  	pkey_inited = false;
>> > +
>> > +	/* Lets assume 32 keys */
>> > +	pkeys_total = 32;
>> > +
>> > +#ifdef CONFIG_PPC_4K_PAGES
>> > +	/*
>> > +	 * the OS can manage only 8 pkeys
>> > +	 * due to its inability to represent
>> > +	 * them in the linux 4K-PTE.
>> > +	 */
>> > +	os_reserved = pkeys_total-8;
>> > +#else
>> > +	os_reserved = 0;
>> > +#endif
>> > +	/*
>> > +	 * Bits are in LE format.
>> > +	 * NOTE: 1, 0 are reserved.
>> > +	 * key 0 is the default key, which allows read/write/execute.
>> > +	 * key 1 is recommended not to be used.
>> > +	 * PowerISA(3.0) page 1015, programming note.
>> > +	 */
>> > +	initial_allocation_mask = ~0x0;
>> > +	for (i = 2; i < (pkeys_total - os_reserved); i++)
>> > +		initial_allocation_mask &= ~(0x1<<i);
>> >  }
>> >  #endif /*_ASM_PPC64_PKEYS_H */
>> 
>> In v6, key 31 was also reserved, but it's not in this version. Is this
>> intentional?
>
> On powernv platform, there is no hypervisor and hence the hypervisor
> will not reserve key 31 for its own use. Wherease on PAPR guest
> the hypervisor takes away key 31.  
>
> Its not possible to determine at compile time which keys are used
> or not. Hence the above code.  pkeys_total is 32 in this patch,
> but will be set to whatever value the device tree tells us. That will
> be done in a subsequent patch.

You're right. At the time I made that comment I didn't realize that the
hypervisor would subtract its reserved key from the device property.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
