Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp107.mail.mud.yahoo.com (smtp107.mail.mud.yahoo.com
	[209.191.85.217]) by ozlabs.org (Postfix) with SMTP id 2B676679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 00:30:16 +1100 (EST)
Message-ID: <4421307F.8020300@yahoo.com.au>
Date: Wed, 22 Mar 2006 22:09:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
References: <20060322104143.GC30422@krispykreme>
In-Reply-To: <20060322104143.GC30422@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard wrote:

> One way to solve this is to always take runqueues in cpu id order. To do
> this we add a cpu variable to the runqueue and check it in the
> double runqueue locking functions.
> 
> Thoughts?
> 

You're right. I can't think of a better fix, although we've been trying
to avoid adding cpu to the runqueue structure.

I was going to suggest moving more work into wake_sleeping_dependent
instead, but cores with 4 and more threads now make that less desirable
I suppose.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
