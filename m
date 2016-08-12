Return-Path: <dave.hansen@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s9pMv21sCzDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 01:14:50 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Holger Brunck <holger.brunck@keymile.com>, linuxppc-dev@lists.ozlabs.org
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
Cc: mingo@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57ADE7E6.9030900@linux.intel.com>
Date: Fri, 12 Aug 2016 08:14:46 -0700
MIME-Version: 1.0
In-Reply-To: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2016 07:50 AM, Holger Brunck wrote:
> When I try to debug our multithreaded userspace application with gdb I  get
> stuck when trying to single step code.

Can you clarify "stuck"?  Like the instructions don't advance?  Have you
been able to find a root cause for this?

> Does anyone have an idea why the change in sched.h break my debug
> usecase? Anyone out here who is debugging ppc83xx targets flawlessly
> with a recent kernel?

Thanks for going to the trouble of bisecting this, btw!

I'd _suspect_ something very specific to your platform since this
doesn't appear to affect even other ppc variants.

I wonder if making it cross a page boundary from some other structure
causes this, or moving it relative to something else.  Could you try
moving it to a few more places, or padding it by, say PAGE_SIZE on
either side makes a difference?

Is there some assembly involved in your single-stepping, or some other
code that assumes relative offsets between two pieces of 'task_struct'?
