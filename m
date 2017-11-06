Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVpfF6khMzDrK9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:27:33 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e64so7401155pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:27:33 -0800 (PST)
Date: Mon, 6 Nov 2017 19:27:26 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kemi <kemi.wang@intel.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org,
 kirill@shutemov.name, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [v5,22/22] powerpc/mm: Add speculative page fault
Message-ID: <20171106102726.GB1298@jagdpanzerIV>
References: <1507729966-10660-23-git-send-email-ldufour@linux.vnet.ibm.com>
 <7ca80231-fe02-a3a7-84bc-ce81690ea051@intel.com>
 <c0b7f172-5d9c-eec6-540d-216b908f005f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c0b7f172-5d9c-eec6-540d-216b908f005f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (11/02/17 15:11), Laurent Dufour wrote:
> On 26/10/2017 10:14, kemi wrote:
> > Some regression is found by LKP-tools(linux kernel performance) on this patch series
> > tested on Intel 2s/4s Skylake platform. 
> > The regression result is sorted by the metric will-it-scale.per_process_ops.
> 
> Hi Kemi,
> 
> Thanks for reporting this, I'll try to address it by turning some features
> of the SPF path off when the process is monothreaded.

make them madvice()-able?
not all multi-threaded apps will necessarily benefit of SPF. right?
just an idea.

	-ss
