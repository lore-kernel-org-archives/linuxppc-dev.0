Return-Path: <SRS0=onot=WD=start.ca=wilsons@srs.perfora.net>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.195])
	by ozlabs.org (Postfix) with ESMTP id 20DE1B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 03:47:42 +1100 (EST)
Date: Thu, 10 Mar 2011 11:40:22 -0500
From: Stephen Wilson <wilsons@start.ca>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/5] make *_gate_vma accept mm_struct instead of
	task_struct
Message-ID: <20110310164022.GA6242@fibrous.localdomain>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
	<20110310160032.GA20504@alboin.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110310160032.GA20504@alboin.amr.corp.intel.com>
Cc: linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org, x86@kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Michel Lespinasse <walken@google.com>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, Mar 10, 2011 at 08:00:32AM -0800, Andi Kleen wrote:
> On Tue, Mar 08, 2011 at 07:31:56PM -0500, Stephen Wilson wrote:
> > 
> > Morally, the question of whether an address lies in a gate vma should be asked
> > with respect to an mm, not a particular task.
> > 
> > Practically, dropping the dependency on task_struct will help make current and
> > future operations on mm's more flexible and convenient.  In particular, it
> > allows some code paths to avoid the need to hold task_lock.
> > 
> > The only architecture this change impacts in any significant way is x86_64.
> > The principle change on that architecture is to mirror TIF_IA32 via
> > a new flag in mm_context_t. 
> 
> The problem is -- you're adding a likely cache miss on mm_struct for
> every 32bit compat syscall now, even if they don't need mm_struct
> currently (and a lot of them do not) Unless there's a very good
> justification to make up for this performance issue elsewhere
> (including numbers) this seems like a bad idea.

I do not think this will result in cache misses on the scale you
suggest.  I am simply mirroring the *state* of the TIF_IA32 flag in
mm_struct, not testing/accessing it in the same way.

The only place where this flag is accessed (outside the exec() syscall
path) is in x86/mm/init_64.c, get_gate_vma(),  which in turn is needed
by a few, relatively heavy weight, page locking/pinning routines on the
mm side (get_user_pages, for example).  Patches 3 and 4 in the series
show the extent of the change.

Or am I missing something?


> > /proc/pid/mem.  I will be posting the second series to lkml shortly.  These
> 
> Making every syscall slower for /proc/pid/mem doesn't seem like a good
> tradeoff to me. Please solve this in some other way.
> 
> -Andi

-- 
steve
