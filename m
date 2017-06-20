Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsNY639kWzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:56:58 +1000 (AEST)
Message-ID: <1497952580.31581.51.camel@kernel.crashing.org>
Subject: Re: [RFC v2 00/12] powerpc: Memory Protection Keys
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Ram Pai <linuxram@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, dave.hansen@intel.com, hbabu@us.ibm.com
Date: Tue, 20 Jun 2017 19:56:20 +1000
In-Reply-To: <1497935415.2255.1.camel@gmail.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497935415.2255.1.camel@gmail.com>
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

On Tue, 2017-06-20 at 15:10 +1000, Balbir Singh wrote:
> On Fri, 2017-06-16 at 20:52 -0700, Ram Pai wrote:
> > Memory protection keys enable applications to protect its
> > address space from inadvertent access or corruption from
> > itself.
> 
> I presume by itself you mean protection between threads?

Not necessarily. You could have for example a JIT that
when it runs the JITed code, only "opens" the keys for
the VM itself, preventing the JITed code from "leaking out"

There are plenty of other usages...
> 
> > The overall idea:
> > 
> >  A process allocates a   key  and associates it with
> >  a  address  range  within    its   address   space.
> 
> OK, so this is per VMA?
> 
> >  The process  than  can  dynamically  set read/write 
> >  permissions on  the   key   without  involving  the 
> >  kernel.
> 
> This bit is not clear, how can the key be set without
> involving the kernel? I presume you mean the key is set
> in the PTE's and the access protection values can be
> set without involving the kernel?
> 
>  Any  code that  violates   the  permissions
> >  off the address space; as defined by its associated
> >  key, will receive a segmentation fault.
> > 
> > This patch series enables the feature on PPC64.
> > It is enabled on HPTE 64K-page platform.
> > 
> > ISA3.0 section 5.7.13 describes the detailed specifications.
> > 
> > 
> > Testing:
> > 	This patch series has passed all the protection key
> > 	tests available in  the selftests directory.
> > 	The tests are updated to work on both x86 and powerpc.
> 
> Balbir
