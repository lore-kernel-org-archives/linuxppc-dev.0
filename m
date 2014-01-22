Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x231.google.com (mail-qa0-x231.google.com
 [IPv6:2607:f8b0:400d:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 933442C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 19:33:54 +1100 (EST)
Received: by mail-qa0-f49.google.com with SMTP id w8so71000qac.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 00:33:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zjmoiogp.fsf@linux.vnet.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
 <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
 <20140121112204.GE8265@iris.ozlabs.ibm.com>
 <87zjmoiogp.fsf@linux.vnet.ibm.com>
Date: Wed, 22 Jan 2014 16:33:49 +0800
Message-ID: <CAFgQCTvAnSJEe1JrfJpejMFVDQ0Gw=br6GJVv_u=62xLuiUVcQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Liu ping fan <kernelfans@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 22, 2014 at 1:18 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Paul Mackerras <paulus@samba.org> writes:
>
>> On Mon, Jan 20, 2014 at 03:48:36PM +0100, Alexander Graf wrote:
>>>
>>> On 15.01.2014, at 07:36, Liu ping fan <kernelfans@gmail.com> wrote:
>>>
>>> > On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>>> >>
>>> >> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>> >>
>>> >>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
>>> >>>
>>> >>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>>> >>> (for which, I still try to get a machine to show nums)
>>> >>>
>>> >>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
>>> >>> which is  well known.
>>> >>
>>> >> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
>>> >>
>>> > Sorry for the unclear message. After introducing the _PAGE_NUMA,
>>> > kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
>>> > should rely on host's kvmppc_book3s_hv_page_fault() to call
>>> > do_numa_page() to do the numa fault check. This incurs the overhead
>>> > when exiting from rmode to vmode.  My idea is that in
>>> > kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
>>> > there is no need to exit to vmode (i.e saving htab, slab switching)
>>> >
>>> >>> If my suppose is correct, will CCing kvm@vger.kernel.org from next version.
>>> >>
>>> >> This translates to me as "This is an RFC"?
>>> >>
>>> > Yes, I am not quite sure about it. I have no bare-metal to verify it.
>>> > So I hope at least, from the theory, it is correct.
>>>
>>> Paul, could you please give this some thought and maybe benchmark it?
>>
>> OK, once I get Aneesh to tell me how I get to have ptes with
>> _PAGE_NUMA set in the first place. :)
>>
>
> I guess we want patch 2, Which Liu has sent separately and I have
> reviewed. http://article.gmane.org/gmane.comp.emulators.kvm.powerpc.devel/8619
> I am not sure about the rest of the patches in the series.
> We definitely don't want to numa migrate on henter. We may want to do
> that on fault. But even there, IMHO, we should let the host take the
> fault and do the numa migration instead of doing this in guest context.
>
My patch does NOT do the numa migration in guest context( h_enter).
Instead it just do a pre-check to see whether the numa migration is
needed. If needed, the host will take the fault and do the numa
migration as it currently does. Otherwise, h_enter can directly setup
hpte without HPTE_V_ABSENT.
And since pte_mknuma() is called system-wide periodly, so it has more
possibility that guest will suffer from HPTE_V_ABSENT.(as my previous
reply, I think we should also place the quick check in
kvmppc_hpte_hv_fault )

Thx,
Fan

> -aneesh
>
