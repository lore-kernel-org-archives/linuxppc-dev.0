Return-Path: <ak@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLsPg75GSzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 14:04:22 +1100 (AEDT)
From: Andi Kleen <ak@linux.intel.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, akpm@linux-foundation.org,
 kirill@shutemov.name, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v6 03/24] mm: Dont assume page-table invariance during
 faults
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-4-git-send-email-ldufour@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 19:04:12 -0800
In-Reply-To: <1515777968-867-4-git-send-email-ldufour@linux.vnet.ibm.com>
 (Laurent Dufour's message of "Fri, 12 Jan 2018 18:25:47 +0100")
Message-ID: <87d129tccz.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> From: Peter Zijlstra <peterz@infradead.org>
>
> One of the side effects of speculating on faults (without holding
> mmap_sem) is that we can race with free_pgtables() and therefore we
> cannot assume the page-tables will stick around.
>
> Remove the reliance on the pte pointer.

This needs a lot more explanation. So why is this code not needed with
SPF only?

-Andi
