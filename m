Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 07C35B6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Mar 2011 03:38:15 +1100 (EST)
Date: Thu, 10 Mar 2011 08:38:09 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Stephen Wilson <wilsons@start.ca>
Subject: Re: [PATCH 0/5] make *_gate_vma accept mm_struct instead of
	task_struct II
Message-ID: <20110310163809.GA20675@alboin.amr.corp.intel.com>
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

Hmm I see you're only setting it on exec time actually on rereading
the patches. I thought you were changing TS_COMPAT which is in
the syscall path.

Never mind.  I have no problems with doing such a change on exec
time.

-Andi
