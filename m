Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id E3F52B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:28:44 +1000 (EST)
Message-ID: <4C270BB8.60404@redhat.com>
Date: Sun, 27 Jun 2010 11:28:40 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-19-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2010 02:25 AM, Alexander Graf wrote:
> We will soon start and replace instructions from the text section with
> other, paravirtualized versions. To ease the readability of those patches
> I split out the generic looping and magic page mapping code out.
>
> This patch still only contains stubs. But at least it loops through the
> text section :).
>
>
> +
> +static void kvm_check_ins(u32 *inst)
> +{
> +	u32 _inst = *inst;
> +	u32 inst_no_rt = _inst&  ~KVM_MASK_RT;
> +	u32 inst_rt = _inst&  KVM_MASK_RT;
> +
> +	switch (inst_no_rt) {
> +	}
> +
> +	switch (_inst) {
> +	}
> +
> +	flush_icache_range((ulong)inst, (ulong)inst + 4);
> +}
>    

Shouldn't we flush only if we patched something?

> +
> +static void kvm_use_magic_page(void)
> +{
> +	u32 *p;
> +	u32 *start, *end;
> +
> +	/* Tell the host to map the magic page to -4096 on all CPUs */
> +
> +	on_each_cpu(kvm_map_magic_page, NULL, 1);
> +
> +	/* Now loop through all code and find instructions */
> +
> +	start = (void*)_stext;
> +	end = (void*)_etext;
> +
> +	for (p = start; p<  end; p++)
> +		kvm_check_ins(p);
> +}
> +
>    

Or, flush the entire thing here.


-- 
error compiling committee.c: too many arguments to function
