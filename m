Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.202])
	by ozlabs.org (Postfix) with ESMTP id 69741686B8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 07:45:37 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id y38so148086nfb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Nov 2005 12:45:35 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 7 Nov 2005 22:50:02 +0200
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
	<1131396000.4652.24.camel@gaston>
In-Reply-To: <1131396000.4652.24.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511072250.03217.pantelis.antoniou@gmail.com>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 07 November 2005 22:39, Benjamin Herrenschmidt wrote:
> On Mon, 2005-11-07 at 06:44 -0200, Marcelo Tosatti wrote:
> 
> > 
> > The bug is that the zeroed TLB is not invalidated (the same reason
> > for the "dcbst" misbehaviour), resulting in infinite TLBError faults.
> 
> I see, so you are in the same situation as ia64 which has valid but
> unmapped TLBs ?
> 
> > Dan, I wonder why we just don't go back to v2.4 behaviour. It is not very
> > clear to me that "two exception" speedup offsets the additional code required
> > for "one exception" version. Have you actually done any measurements? 
> 
> What do you mean by "one exception" version ? You probably get 3 in fact
> since after you have serviced the fault in the common code, you take
> another fault to fill the PTE.
> 
> In fact, you could even go back to one exception by pre-filling the TLB
> in update_mmu_cache :)
> 

Yep. That should be the target. Remember the poor 8xx is not exactly a 
speed demon :).

> > There is chance that the additional code ends up in the same cacheline,
> > which would mean no huge gain by the "two exception" approach. Might be
> > even harmful for performance (you need two exceptions instead of one
> > after all).
> > 
> > The "two exception" approach requires a TLB flush (to nuke the zeroed)
> > at each PTE update for correct behaviour (which BTW is another slowdown):
> 
> I think the current code, even with your fix, is sub-optimal. But of
> course, the only way to be sure is to do real measurements
> 
> Ben.
> 
> 

The TLB flush is bogus IMO. I'm going to try the last patch by marcelo to
see if it works for me.

Pantelis.
