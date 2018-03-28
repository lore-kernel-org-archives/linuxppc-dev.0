Return-Path: <rientjes@google.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BLRK4bBCzF1r1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 08:21:33 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id y16so1082661pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 14:21:33 -0700 (PDT)
Date: Wed, 28 Mar 2018 14:21:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v9 09/24] mm: protect mremap() against SPF hanlder
In-Reply-To: <1fe7529a-947c-fdb2-12d2-b38bdd41bb04@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1803281419460.167685@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-10-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803271500540.43106@chino.kir.corp.google.com>
 <1fe7529a-947c-fdb2-12d2-b38bdd41bb04@linux.vnet.ibm.com>
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

On Wed, 28 Mar 2018, Laurent Dufour wrote:

> >> @@ -326,7 +336,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >>  		mremap_userfaultfd_prep(new_vma, uf);
> >>  		arch_remap(mm, old_addr, old_addr + old_len,
> >>  			   new_addr, new_addr + new_len);
> >> +		if (vma != new_vma)
> >> +			vm_raw_write_end(vma);
> >>  	}
> >> +	vm_raw_write_end(new_vma);
> > 
> > Just do
> > 
> > vm_raw_write_end(vma);
> > vm_raw_write_end(new_vma);
> > 
> > here.
> 
> Are you sure ? we can have vma = new_vma done if (unlikely(err))
> 

Sorry, what I meant was do

if (vma != new_vma)
	vm_raw_write_end(vma);
vm_raw_write_end(new_vma);

after the conditional.  Having the locking unnecessarily embedded in the 
conditional has been an issue in the past with other areas of core code, 
unless you have a strong reason for it.
