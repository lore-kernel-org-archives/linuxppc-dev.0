Message-ID: <3E5A6D3F.9030101@mvista.com>
Date: Mon, 24 Feb 2003 11:06:39 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch
References: <5.1.0.14.2.20030224095828.03022e38@mail.ebshome.net>
In-Reply-To: <5.1.0.14.2.20030224095828.03022e38@mail.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:56 AM 2/24/2003, brian.auld@adic.com wrote:

> However, I noticed that your 'preempt_enable' at the bottom of the
> exerp has
> been changed from 'preempt_enable' as in the RML patch, to
> 'preempt_enable_no_reshed'. What's the reason for this inconsistency?

The preempt_enable_no_reshed avoids a kernel stack overflow seen in
certain cases of heavy preemption, where each nested call to reschedule
on preemption is interrupted and again requests a preemption.  The
proper place to check for another preemption is at the top-level
interrupt/exception handler, so that we iterate and not recurse.

Oops, MontaVista needs to contribute this bug fix back to RML's public
patch, I'll put it on my list.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
