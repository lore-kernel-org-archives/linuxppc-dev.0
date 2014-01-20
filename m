Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9DC32C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 01:53:45 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
Date: Mon, 20 Jan 2014 15:48:36 +0100
Message-Id: <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
To: Liu ping fan <kernelfans@gmail.com>
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


On 15.01.2014, at 07:36, Liu ping fan <kernelfans@gmail.com> wrote:

> On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>>=20
>> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>=20
>>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: =
mm: Numa faults support for ppc64"
>>>=20
>>> For this series, I apply the same idea from the previous thread =
"[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>>> (for which, I still try to get a machine to show nums)
>>>=20
>>> But for this series, I think that I have a good justification -- the =
fact of heavy cost when switching context between guest and host,
>>> which is  well known.
>>=20
>> This cover letter isn't really telling me anything. Please put a =
proper description of what you're trying to achieve, why you're trying =
to achieve what you're trying and convince your readers that it's a good =
idea to do it the way you do it.
>>=20
> Sorry for the unclear message. After introducing the _PAGE_NUMA,
> kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
> should rely on host's kvmppc_book3s_hv_page_fault() to call
> do_numa_page() to do the numa fault check. This incurs the overhead
> when exiting from rmode to vmode.  My idea is that in
> kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
> there is no need to exit to vmode (i.e saving htab, slab switching)
>=20
>>> If my suppose is correct, will CCing kvm@vger.kernel.org from next =
version.
>>=20
>> This translates to me as "This is an RFC"?
>>=20
> Yes, I am not quite sure about it. I have no bare-metal to verify it.
> So I hope at least, from the theory, it is correct.

Paul, could you please give this some thought and maybe benchmark it?


Alex
