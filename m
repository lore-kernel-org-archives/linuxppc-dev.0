Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSGmr0Hn3zDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 11:23:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so21745576pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:23:55 -0700 (PDT)
Message-ID: <1494984228.30802.2.camel@gmail.com>
Subject: Re: [RFC 0/2] Consolidate patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Wed, 17 May 2017 11:23:48 +1000
In-Reply-To: <20170516134141.GB19390@naverao1-tp.localdomain>
References: <20170516034913.21163-1-bsingharora@gmail.com>
 <886e774c-c555-5547-2c03-22d611f2551f@linux.vnet.ibm.com>
 <20170516134141.GB19390@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 19:11 +0530, Naveen N. Rao wrote:
> On 2017/05/16 10:56AM, Anshuman Khandual wrote:
> > On 05/16/2017 09:19 AM, Balbir Singh wrote:
> > > patch_instruction is enhanced in this RFC to support
> > > patching via a different virtual address (text_poke_area).
> > 
> > Why writing instruction directly into the address is not
> > sufficient and need to go through this virtual address ?
> 
> To enable KERNEL_STRICT_RWX and map all of kernel text to be read-only?
>

Precisely, the rest of the bits are still being developed.
 
> > 
> > > The mapping of text_poke_area->addr is RW and not RWX.
> > > This way the mapping allows write for patching and then we tear
> > > down the mapping. The downside is that we introduce a spinlock
> > > which serializes our patching to one patch at a time.
> > 
> > So whats the benifits we get otherwise in this approach when
> > we are adding a new lock into the equation.
> 
> Instruction patching isn't performance critical, so the slow down is 
> likely not noticeable. Marking kernel text read-only helps harden the 
> kernel by catching unintended code modifications whether through 
> exploits or through bugs.
>

Precisely!

Balbir Singh. 
