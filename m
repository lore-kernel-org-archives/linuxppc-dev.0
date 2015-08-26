Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21CBE1A0066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 19:03:07 +1000 (AEST)
Subject: Re: Build regressions/improvements in v4.2-rc8
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1440405251-9184-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVomabvJOLLJ-tJs6KjL05YpH3zLkyrPbyEghe=WvOVkA@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 kvm-ppc@vger.kernel.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <55DD80C6.7030400@suse.de>
Date: Wed, 26 Aug 2015 11:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVomabvJOLLJ-tJs6KjL05YpH3zLkyrPbyEghe=WvOVkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24.08.15 10:36, Geert Uytterhoeven wrote:
> On Mon, Aug 24, 2015 at 10:34 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.2-rc8[1] to v4.2-rc7[3], the summaries are:
>>   - build errors: +4/-7
> 
> 4 regressions:
>   + /home/kisskb/slave/src/include/linux/kvm_host.h: error: array
> subscript is above array bounds [-Werror=array-bounds]:  => 430:19
>     (arch/powerpc/kvm/book3s_64_mmu.c: In function 'kvmppc_mmu
> _book3s_64_tlbie':)
> 
> powerpc-randconfig (seen before in a v3.15-rc1 build?)

I'm not quite sure what's going wrong here. The code in question does

  kvm_for_each_vcpu(i, v, vcpu->kvm)
    kvmppc_mmu_pte_vflush(v, va >> 12, mask);

and IIUC the thing we're potentially running over on would be
kvm->vcpus[i]. But that one is bound by the kvm_for_each_vcpu loop, no?


Alex
