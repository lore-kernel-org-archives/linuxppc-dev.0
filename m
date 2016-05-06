Return-Path: <oohall@gmail.com>
Received: from mail-qg0-x241.google.com (mail-qg0-x241.google.com
 [IPv6:2607:f8b0:400d:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1M1s4F8tzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 16:14:41 +1000 (AEST)
Received: by mail-qg0-x241.google.com with SMTP id e35so6363151qge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 23:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <572C2801.7050605@linux.vnet.ibm.com>
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87r3dgk1bh.fsf@skywalker.in.ibm.com>
 <572C2801.7050605@linux.vnet.ibm.com>
Date: Fri, 6 May 2016 16:14:38 +1000
Message-ID: <CAOSf1CH=gGARN+-D8uE=wAp0NUZTkp=9Xc273K_7GTEJqhuWXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Enable ZONE_DEVICE on POWER
From: oliver <oohall@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've been working on kernel support for a persistent memory (nvdimm)
device and the kernel driver infrastructure requires ZONE_DEVICE for
DAX support.. I've had it enabled in my tree for some time (without
altmap support) without any real issues.

I wasn't planning on upstreaming any of my changes until 4.8 at the
earliest so I am ok with carrying these patches myself. However, there
has been some interest in using ZONE_DEVICE for other things on ppc
(wasn't that you?) and given that ZONE_DEVICE is gated behind
CONFIG_EXPERT I can't see there being any kind of negative impact on
end users by merging it now. At the very least it lets the rest of the
kernel development community know that changes affecting zones should
also be tested on powerpc.

Thanks,
Oliver


On Fri, May 6, 2016 at 3:13 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> On 05/05/2016 08:18 PM, Aneesh Kumar K.V wrote:
>> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
>>
>>> This enables base ZONE_DEVICE support on POWER. This series depends on
>>> the following patches posted by Oliver.
>>>
>>> https://patchwork.ozlabs.org/patch/618867/
>>> https://patchwork.ozlabs.org/patch/618868/
>>>
>>> Anshuman Khandual (2):
>>>   powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE memory
>>>   powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64 platforms
>>>
>>>  arch/powerpc/mm/init_64.c | 4 +++-
>>>  mm/Kconfig                | 2 +-
>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>
>> What is the use case ? Who will use ZONE_DEVICE on ppc64. This should be
>> be merged along with the patch series that use this.
>
> IIUC, Oliver has been looking at using ZONE_DEVICE for the NVDIMM (or
> some other persistent memory) drivers. I have been following Dan William's
> work on this front and want to explore more details about it's functioning
> on ppc64. This enablement will just help us little bit in that direction.
>
