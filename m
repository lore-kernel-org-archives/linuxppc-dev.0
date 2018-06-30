Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HZpD2nGxzF2vk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 10:56:20 +1000 (AEST)
Date: Fri, 29 Jun 2018 19:55:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Randy Dunlap <rdunlap@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Pekka Enberg <penberg@kernel.org>, Jerome Glisse <jglisse@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Christoph Lameter <cl@linux.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
Message-ID: <20180630005530.GX16221@gate.crashing.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2018 at 02:01:46PM -0700, Linus Torvalds wrote:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> But the real question is what the problem was the *first* time around.
> I assume that has scrolled off the screen? This part:
> 
>   _exception_pkey+0x58/0x128
>   ret_from_except_full+0x0/0x4
>   --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>        LR = free_pgd_range+0x19c/0x30c
>   free_pgtables+0xa/0xb
>   exit_mnap+0xf4/0x16c
>   mmput+0x64/0xf0
> 
> Does reverting that commit 1d40a5ea01d5 make everything work for you?
> Because if so, judging by the deafening silence on this so far, I
> think that's what we should do.
> 
> That said, can some ppc person who knows the 32-bit ppc code and maybe
> knows what that "interrupt: 700" means talk about that oddity in the
> trace, please?

700 is "program interrupt"; here it probably means a BUG() happened (which
does a trap instruction, which causes a 700).  The stuff that scrolled away
should tell more.


Segher
