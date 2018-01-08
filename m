Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFpJR2YzwzF0T0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 08:27:15 +1100 (AEDT)
Received: by mail-oi0-x22e.google.com with SMTP id j14so8674460oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 13:27:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108202548.GA1732@dhcp22.suse.cz>
References: <20171229075406.1936-1-hch@lst.de> <20180108112646.GA7204@lst.de>
 <CAPcyv4hHipDHP5LZCgym5szqiUSCxG9wQUbRO_qe8T+USaZi9Q@mail.gmail.com>
 <20180108202548.GA1732@dhcp22.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Jan 2018 13:27:13 -0800
Message-ID: <CAPcyv4ipGv613NgJZ8HEWTV4DrDxRdrMwD=8odZevvBQaQwuCA@mail.gmail.com>
Subject: Re: revamp vmem_altmap / dev_pagemap handling V3
To: Michal Hocko <mhocko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org,
 X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 8, 2018 at 12:25 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 08-01-18 11:44:02, Dan Williams wrote:
>> On Mon, Jan 8, 2018 at 3:26 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > Any chance to get this fully reviewed and picked up before the
>> > end of the merge window?
>>
>> I'm fine carrying these through the nvdimm tree, but I'd need an ack
>> from the mm folks for all the code touches related to arch_add_memory.
>
> I am sorry to be slow here but I am out of time right now - yeah having
> a lot of fun kaiser time. I didn't get to look at these patches at all
> yet but the changelog suggests that you want to remove vmem_altmap.
> I've had plans to (ab)use this for self hosted struct pages for memory
> hotplug http://lkml.kernel.org/r/20170801124111.28881-1-mhocko@kernel.org
> That work is stalled though because it is buggy and I was too busy to
> finish that work. Anyway, if you believe that removing vmem_altmap is a
> good step in general I will find another way. I wasn't really happy how
> the whole thing is grafted to the memory hotplug and (ab)used it only
> because it was handy and ready for reuse.

You misread, these are keeping vmem_altmap and cleaning up the usage
to pass the vmem_altmap pointer through all paths rather than the
tricky radix lookup we were doing previously.

> Anyway if you need a review of mm parts from me, you will have to wait
> some more. If this requires some priority then go ahead and merge
> it. Times are just too crazy right now.

Since you were planning on reusing vmem_altmap I think these patches
make your job easier. I don't see the risk in merging these, we've
squeezed out a few bugs and all the nvdimm unit tests are passing.

> Sorry about that.

No worries, quite a few of us are in that same boat.
