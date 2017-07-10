Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5ZN12fBKzDqB1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 16:01:21 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A5xa4L023143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:01:19 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjvvde9vf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 02:01:19 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 10 Jul 2017 00:01:18 -0600
Date: Sun, 9 Jul 2017 23:01:01 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 34/38] procfs: display the protection-key number
 associated with a vma
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
 <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162ac6c-5e34-8a6c-fed2-6683d261352c@linux.vnet.ibm.com>
Message-Id: <20170710060101.GE5713@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 08:37:28AM +0530, Anshuman Khandual wrote:
> On 07/06/2017 02:52 AM, Ram Pai wrote:
> > Display the pkey number associated with the vma in smaps of a task.
> > The key will be seen as below:
> > 
> > ProtectionKey: 0
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/kernel/setup_64.c |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> > index f35ff9d..ebc82b3 100644
> > --- a/arch/powerpc/kernel/setup_64.c
> > +++ b/arch/powerpc/kernel/setup_64.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/memory.h>
> >  #include <linux/nmi.h>
> > +#include <linux/pkeys.h>
> >  
> >  #include <asm/io.h>
> >  #include <asm/kdump.h>
> > @@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
> >  }
> >  early_initcall(disable_hardlockup_detector);
> >  #endif
> > +
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> 
> Why not for X86 protection keys ?

hmm.. I dont understand the comment.


-- 
Ram Pai
