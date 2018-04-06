Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HMbW6y1KzF1vZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 11:31:03 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id b6-v6so19687436pla.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 18:31:03 -0700 (PDT)
Date: Fri, 6 Apr 2018 11:26:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>, "Luck\, Tony"
 <tony.luck@intel.com>, Matthew Wilcox <mawilcox@microsoft.com>, Michael
 Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [RESEND 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
Message-ID: <20180406112600.454432f0@roar.ozlabs.ibm.com>
In-Reply-To: <x496055gzet.fsf@segfault.boston.devel.redhat.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-3-bsingharora@gmail.com>
 <20180405095755.58b3891f@roar.ozlabs.ibm.com>
 <CAPcyv4hqKsOy9GU=NcMGj38pXnuEMRhXfox6jVwQ37+mcjnvhA@mail.gmail.com>
 <20180405150405.5b902b41@roar.ozlabs.ibm.com>
 <20180405155307.49f748f3@gmail.com>
 <20180405164508.7a15a770@roar.ozlabs.ibm.com>
 <x496055gzet.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 05 Apr 2018 16:40:26 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Thu, 5 Apr 2018 15:53:07 +1000
> > Balbir Singh <bsingharora@gmail.com> wrote:  
> >> I'm thinking about it, I wonder what "bytes remaining" mean in pmem context
> >> in the context of a machine check exception. Also, do we want to be byte
> >> accurate or cache-line accurate for the bytes remaining? The former is much
> >> easier than the latter :)  
> >
> > The ideal would be a linear measure of how much of your copy reached
> > (or can reach) non-volatile storage with nothing further copied. You
> > may have to allow for some relaxing of the semantics depending on
> > what the architecture can support.  
> 
> I think you've got that backwards.  memcpy_mcsafe is used to copy *from*
> persistent memory.  The idea is to catch errors when reading pmem, not
> writing to it.
> 
> > What's the problem with just counting bytes copied like usercopy --
> > why is that harder than cacheline accuracy?  
> 
> He said the former (i.e. bytes) is easier.  So, I think you're on the
> same page.  :)

Oh well that makes a lot more sense in my mind now, thanks :)
