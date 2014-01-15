Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x236.google.com (mail-qc0-x236.google.com
 [IPv6:2607:f8b0:400d:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 091D22C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 17:36:36 +1100 (EST)
Received: by mail-qc0-f182.google.com with SMTP id c9so625753qcz.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 22:36:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
Date: Wed, 15 Jan 2014 14:36:32 +0800
Message-ID: <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>
>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
>>
>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>> (for which, I still try to get a machine to show nums)
>>
>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
>> which is  well known.
>
> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
>
Sorry for the unclear message. After introducing the _PAGE_NUMA,
kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
should rely on host's kvmppc_book3s_hv_page_fault() to call
do_numa_page() to do the numa fault check. This incurs the overhead
when exiting from rmode to vmode.  My idea is that in
kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
there is no need to exit to vmode (i.e saving htab, slab switching)

>> If my suppose is correct, will CCing kvm@vger.kernel.org from next version.
>
> This translates to me as "This is an RFC"?
>
Yes, I am not quite sure about it. I have no bare-metal to verify it.
So I hope at least, from the theory, it is correct.

Thanks and regards,
Ping Fan
>
> Alex
>
