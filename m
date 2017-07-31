Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLl680yf6zDqr6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 02:19:59 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6VGJTZT135242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:19:57 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c27cshw90-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 12:19:57 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 13:19:54 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6VGJqn622413426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:19:53 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6VGJq1d026816
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 13:19:53 -0300
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
 <87shhgdx5i.fsf@linux.vnet.ibm.com>
 <20170730005137.GK5664@ram.oc3035372033.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org,
 dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
 khandual@linux.vnet.ibm.com
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
In-reply-to: <20170730005137.GK5664@ram.oc3035372033.ibm.com>
Date: Mon, 31 Jul 2017 13:19:40 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efsw60kj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> On Fri, Jul 28, 2017 at 07:17:13PM -0300, Thiago Jung Bauermann wrote:
>> 
>> Ram Pai <linuxram@us.ibm.com> writes:
>> > --- a/arch/powerpc/mm/pkeys.c
>> > +++ b/arch/powerpc/mm/pkeys.c
>> > @@ -97,3 +97,60 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>> >  	init_iamr(pkey, new_iamr_bits);
>> >  	return 0;
>> >  }
>> > +
>> > +static inline bool pkey_allows_readwrite(int pkey)
>> > +{
>> > +	int pkey_shift = pkeyshift(pkey);
>> > +
>> > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
>> > +		return true;
>> > +
>> > +	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
>> > +}
>> > +
>> > +int __execute_only_pkey(struct mm_struct *mm)
>> > +{
>> > +	bool need_to_set_mm_pkey = false;
>> > +	int execute_only_pkey = mm->context.execute_only_pkey;
>> > +	int ret;
>> > +
>> > +	/* Do we need to assign a pkey for mm's execute-only maps? */
>> > +	if (execute_only_pkey == -1) {
>> > +		/* Go allocate one to use, which might fail */
>> > +		execute_only_pkey = mm_pkey_alloc(mm);
>> > +		if (execute_only_pkey < 0)
>> > +			return -1;
>> > +		need_to_set_mm_pkey = true;
>> > +	}
>> > +
>> > +	/*
>> > +	 * We do not want to go through the relatively costly
>> > +	 * dance to set AMR if we do not need to.  Check it
>> > +	 * first and assume that if the execute-only pkey is
>> > +	 * readwrite-disabled than we do not have to set it
>> > +	 * ourselves.
>> > +	 */
>> > +	if (!need_to_set_mm_pkey &&
>> > +	    !pkey_allows_readwrite(execute_only_pkey))
> 		^^^^^
> 	Here uamor and amr is read once each.

You are right. What confused me was that the call to mm_pkey_alloc above
also reads uamor and amr (and also iamr, and writes to all of those) but
if that function is called, then need_to_set_mm_pkey is true and
pkey_allows_readwrite won't be called.

>> > +		return execute_only_pkey;
>> > +
>> > +	/*
>> > +	 * Set up AMR so that it denies access for everything
>> > +	 * other than execution.
>> > +	 */
>> > +	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
>> > +			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
> 		^^^^^^^
> 		here amr and iamr are written once each if the
> 		the function returns successfully.

__arch_set_user_pkey_access also reads uamor for the second time in its
call to is_pkey_enabled, and reads amr for the second time as well in
its calls to init_amr. The first reads are in either
pkey_allows_readwrite or pkey_status_change (called from
__arch_activate_pkey).

If need_to_set_mm_pkey is true, then the iamr read in init_iamr is the
2nd one during __execute_only_pkey's execution. In this case the writes
to amr and iamr will be the 2nd ones as well. The first reads and writes
are in pkey_status_change.

>> > +	/*
>> > +	 * If the AMR-set operation failed somehow, just return
>> > +	 * 0 and effectively disable execute-only support.
>> > +	 */
>> > +	if (ret) {
>> > +		mm_set_pkey_free(mm, execute_only_pkey);
> 		^^^
> 		here only if __arch_set_user_pkey_access() fails
> 		amr and iamr and uamor will be written once each.

I assume the error case isn't perfomance sensitive and didn't account
for mm_set_pkey_free in my analysis.

>> > +		return -1;
>> > +	}
>> > +
>> > +	/* We got one, store it and use it from here on out */
>> > +	if (need_to_set_mm_pkey)
>> > +		mm->context.execute_only_pkey = execute_only_pkey;
>> > +	return execute_only_pkey;
>> > +}
>> 
>> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
>> are read 3 times in total, and AMR is written twice. IAMR is read and
>> written twice. Since they are SPRs and access to them is slow (or isn't
>> it?), is it worth it to read them once in __execute_only_pkey and pass
>> down their values to the callees, and then write them once at the end of
>> the function?
>
> If my calculations are right: 
> 	uamor may be read once and may be written once.
> 	amr may be read once and is written once.
> 	iamr is written once.
> So not that bad, i think.

If I'm following the code correctly:
    if need_to_set_mm_pkey = true:
        uamor is read twice and written once.
        amr is read twice and written twice.
        iamr is read twice and written twice.
    if need_to_set_mm_pkey = false:
        uamor is read twice.
        amr is read once or twice (depending on the value of uamor) and written once.
        iamr is read once and written once.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
