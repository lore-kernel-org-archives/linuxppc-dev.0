Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0964CB7CED
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 00:03:19 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o28D3HPW001893
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 18:33:17 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o28D3Hr82629834
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 18:33:17 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o28D3GIZ029621
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 18:33:16 +0530
Message-ID: <4B94F594.7050205@in.ibm.com>
Date: Mon, 08 Mar 2010 18:33:16 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: ananth@in.ibm.com
Subject: Re: [PowerPC] 2.6.33-git11 : Badness at kernel/kprobes.c:264
References: <4B920E06.4060508@in.ibm.com>
	<20100308101152.GA2557@osiris.boeblingen.de.ibm.com>
	<20100308120009.GC14199@in.ibm.com>
In-Reply-To: <20100308120009.GC14199@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, mhiramat@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ananth N Mavinakayanahalli wrote:
>>> 2.6.33-git10(64ba99267...) was OK.
>>>
>>> This WARN_ON was introduced by commit 4610ee1d36...
>>>
>>> kprobes: Introduce generic insn_slot framework
>>>       
>> FWIW, same on s390...
>>     
>
> This patch should fix it:
>
> When freeing the instruction slot, the arithmetic to calculate the index
> of the slot in the page needs to account for the total size of the
> instruction on the various architectures.
>
> Calculate the index correctly when freeing the out-of-line execution slot.
>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
>   
Thanks Ananth. Boots fine on my POWER6 box without any WAR_ON.

Regards
-Sachin

> ---
> Index: linux-8mar/kernel/kprobes.c
> ===================================================================
> --- linux-8mar.orig/kernel/kprobes.c	2010-03-08 17:10:33.000000000 +0530
> +++ linux-8mar/kernel/kprobes.c	2010-03-08 17:12:12.000000000 +0530
> @@ -259,7 +259,8 @@
>  	struct kprobe_insn_page *kip;
>
>  	list_for_each_entry(kip, &c->pages, list) {
> -		long idx = ((long)slot - (long)kip->insns) / c->insn_size;
> +		long idx = ((long)slot - (long)kip->insns) /
> +				(c->insn_size * sizeof(kprobe_opcode_t));
>  		if (idx >= 0 && idx < slots_per_page(c)) {
>  			WARN_ON(kip->slot_used[idx] != SLOT_USED);
>  			if (dirty) {
>
>
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
