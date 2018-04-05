Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsSZ1zlVzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:53:18 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id s10-v6so15724476plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 22:53:18 -0700 (PDT)
Date: Thu, 5 Apr 2018 15:53:07 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <mawilcox@microsoft.com>, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RESEND 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
Message-ID: <20180405155307.49f748f3@gmail.com>
In-Reply-To: <20180405150405.5b902b41@roar.ozlabs.ibm.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-3-bsingharora@gmail.com>
 <20180405095755.58b3891f@roar.ozlabs.ibm.com>
 <CAPcyv4hqKsOy9GU=NcMGj38pXnuEMRhXfox6jVwQ37+mcjnvhA@mail.gmail.com>
 <20180405150405.5b902b41@roar.ozlabs.ibm.com>
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

On Thu, 5 Apr 2018 15:04:05 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Wed, 4 Apr 2018 20:00:52 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > [ adding Matthew, Christoph, and Tony  ]
> > 
> > On Wed, Apr 4, 2018 at 4:57 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > On Thu,  5 Apr 2018 09:19:42 +1000
> > > Balbir Singh <bsingharora@gmail.com> wrote:
> > >    
> > >> The pmem infrastructure uses memcpy_mcsafe in the pmem
> > >> layer so as to convert machine check excpetions into
> > >> a return value on failure in case a machine check
> > >> exception is encoutered during the memcpy.
> > >>
> > >> This patch largely borrows from the copyuser_power7
> > >> logic and does not add the VMX optimizations, largely
> > >> to keep the patch simple. If needed those optimizations
> > >> can be folded in.    
> > >
> > > So memcpy_mcsafe doesn't return number of bytes copied?
> > > Huh, well that makes it simple.    
> > 
> > Well, not in current kernels, but we need to add that support or
> > remove the direct call to copy_to_iter() in fs/dax.c. I'm looking
> > right now to add "bytes remaining" support to the x86 memcpy_mcsafe(),
> > but for copy_to_user we also need to handle bytes remaining for write
> > faults. That fix is hopefully something that can land in an early
> > 4.17-rc, but it won't be ready for -rc1.  
> 
> I wonder if the powerpc implementation should just go straight to
> counting bytes. Backporting to this interface would be trivial, but
> it would just mean there's only one variant of the code to support.
> That's up to Balbir though.
> 

I'm thinking about it, I wonder what "bytes remaining" mean in pmem context
in the context of a machine check exception. Also, do we want to be byte
accurate or cache-line accurate for the bytes remaining? The former is much
easier than the latter :)


I'd rather implement the existing interface and port/support the new interface
as it becomes available

Balbir Singh.
