Return-Path: <dan.j.williams@intel.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bDHg0JFVzF2RB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 06:57:15 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id v2-v6so11104275oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 13:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hQDetYZaQXHoD-L+KWrMJyypvHw=xzm7tb61qt9w=a3g@mail.gmail.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-3-bsingharora@gmail.com>
 <20180405095755.58b3891f@roar.ozlabs.ibm.com>
 <CAPcyv4hqKsOy9GU=NcMGj38pXnuEMRhXfox6jVwQ37+mcjnvhA@mail.gmail.com>
 <20180405150405.5b902b41@roar.ozlabs.ibm.com>
 <20180405155307.49f748f3@gmail.com>
 <20180405164508.7a15a770@roar.ozlabs.ibm.com>
 <CAPcyv4hQDetYZaQXHoD-L+KWrMJyypvHw=xzm7tb61qt9w=a3g@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 1 May 2018 13:57:13 -0700
Message-ID: <CAPcyv4hwb5ebVpYvAn+Bof_NxO6T3X1K+0B7Xbd07FrK8xZi7Q@mail.gmail.com>
Subject: Re: [RESEND 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <mawilcox@microsoft.com>, "Luck,
 Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 5, 2018 at 8:00 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Wed, Apr 4, 2018 at 11:45 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
[,,]
>> What's the problem with just counting bytes copied like usercopy --
>> why is that harder than cacheline accuracy?
>>
>>> I'd rather implement the existing interface and port/support the new interface
>>> as it becomes available
>>
>> Fair enough.
>
> I have patches already in progress to change the interface. My
> preference is to hold off on adding a new implementation that will
> need to be immediately reworked. When I say "immediate" I mean that
> should be able to post what I have for review within the next few
> days.
>
> Whether this is all too late for 4.17 is another question...

Here is the x86 version of a 'bytes remaining' memcpy_mcsafe() implemenation:

    https://lists.01.org/pipermail/linux-nvdimm/2018-May/015548.html
