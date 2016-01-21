Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5092C1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:09:33 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n128so1457175pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 00:09:33 -0800 (PST)
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Add support for multiple-TCE
 hcalls
To: kbuild test robot <lkp@intel.com>
References: <201601211511.Dhy0Q7Ui%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56A09236.6050707@ozlabs.ru>
Date: Thu, 21 Jan 2016 19:09:26 +1100
MIME-Version: 1.0
In-Reply-To: <201601211511.Dhy0Q7Ui%fengguang.wu@intel.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right, this also depends on

69b907297f4e list: Add lockless list traversal primitives



On 01/21/2016 06:56 PM, kbuild test robot wrote:
> Hi Alexey,
>
> [auto build test ERROR on kvm/linux-next]
> [also build test ERROR on v4.4 next-20160121]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Alexey-Kardashevskiy/KVM-PPC-Add-in-kernel-multitce-handling/20160121-154336
> base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
> config: powerpc-allyesconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc
>
> All error/warnings (new ones prefixed by >>):
>
>     arch/powerpc/kvm/book3s_64_vio_hv.c: In function 'kvmppc_find_table':
>     arch/powerpc/kvm/book3s_64_vio_hv.c:58:2: error: implicit declaration of function 'list_for_each_entry_lockless' [-Werror=implicit-function-declaration]
>       list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
>       ^
>     arch/powerpc/kvm/book3s_64_vio_hv.c:58:65: error: 'list' undeclared (first use in this function)
>       list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
>                                                                      ^
>     arch/powerpc/kvm/book3s_64_vio_hv.c:58:65: note: each undeclared identifier is reported only once for each function it appears in
>     arch/powerpc/kvm/book3s_64_vio_hv.c:59:3: error: expected ';' before 'if'
>        if (stt->liobn == liobn)
>        ^
>     arch/powerpc/kvm/book3s_64_vio_hv.c: In function 'kvmppc_rm_h_put_tce_indirect':
>>> arch/powerpc/kvm/book3s_64_vio_hv.c:263:18: error: implicit declaration of function 'vmalloc_to_phys' [-Werror=implicit-function-declaration]
>       rmap = (void *) vmalloc_to_phys(rmap);
>                       ^
>>> arch/powerpc/kvm/book3s_64_vio_hv.c:263:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       rmap = (void *) vmalloc_to_phys(rmap);
>              ^
>     cc1: some warnings being treated as errors
>
> vim +/vmalloc_to_phys +263 arch/powerpc/kvm/book3s_64_vio_hv.c
>
>     257		if (ret != H_SUCCESS)
>     258			return ret;
>     259	
>     260		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>     261			return H_TOO_HARD;
>     262	
>   > 263		rmap = (void *) vmalloc_to_phys(rmap);
>     264	
>     265		lock_rmap(rmap);
>     266		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>


-- 
Alexey
