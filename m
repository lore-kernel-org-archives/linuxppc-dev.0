Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 8FA3267CCD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 04:39:20 +1100 (EST)
In-Reply-To: <455B3E84.8010606@mock.com>
References: <6e41d1460611150654j6e532ae1pbe378685539e257e@mail.gmail.com>
	<455B3E84.8010606@mock.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1EB2EA4-DF62-4825-84CF-C9E5497AEB09@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Performance on PowerQuicc8280 linux based
Date: Wed, 15 Nov 2006 12:39:08 -0500
To: Jeff Mock <jeff@mock.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 15, 2006, at 11:21 AM, Jeff Mock wrote:

> I'm no big help, but the problem might be TLB related instead of cache
> related.  The performance of embedded PPCs with small TLBs requiring
> software assist for TLB misses can be performance sensitive to TLB  
> misses.

The 82xx is fully cache coherent and has BATs for
mapping the kernel space.  This is not a PPC with
a small TLB, but rather one of the most efficient.
The TLBs are not an issue,  and I doubt the caches
are as well.

I don't know what kind of test is used to measure this
performance, but the first thing you must always scrutinize
are your testing methods and procedures.  Just using
a user application to measure network performance
enables a large number of variables that must be
properly understood and controlled.  Some other
thread could have switched in and stolen CPU cycles,
you could have some sampling rate and time
measurement hysteresis due to buffering,
you need to find and control such things.

Can you "undo" the changes and get the old
results?  That's the first thing I would verify,
and then verify the results are repeatable.
If that's the case, I'd carefully try to understand
what this "unrelated" change really affects
in terms of using CPU cycles.

Thanks.

	-- Dan
