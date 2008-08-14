Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 46852DDF99
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 02:43:24 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so446539pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 09:43:22 -0700 (PDT)
Message-ID: <fa686aa40808140943v218d826p9ac6dc683a5ccff4@mail.gmail.com>
Date: Thu, 14 Aug 2008 10:43:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping
	IO regions before MMU_init()
In-Reply-To: <9E78DE5E-7B94-4990-81CB-1EBF806923C1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
	<1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
	<fa686aa40808140800s417af75ex76ae73ec990be58d@mail.gmail.com>
	<9E78DE5E-7B94-4990-81CB-1EBF806923C1@kernel.crashing.org>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 10:24 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>> what happens if we run out of bats?
>>
>> Then it returns NULL and the caller must handle it.  The board port
>> maintainer needs understand the board/CPU/SoC and not depend on more
>> BATs than are available.  They also need to understand that there is a
>> tradeoff between BATs for IO and BATs for RAM.  If the board port uses
>> up all the BATs for IO, then RAM above 256MB ends up getting mapped
>> with PTEs and there is a performance hit.  My expectation is that only
>> platform code will use this facility.  Device drivers should continue
>> to use ioremap() and will gain the benefit of the BATs if platform
>> code already set them up.  I can add some text to the documentation to
>> describe this.
>>
>> I'm not going to make any attempt to fallback to PTEs for IO when
>> there isn't enough BATs.  Doing so adds an order of magnitude more
>> complexity.
>
> that's fine.. I just didn't look at setbat() to see it errors out.
>
> Also can we get rid of LOAD_BAT in head_32.S?

Mostly.  It is still needed for BAT0 when setting up RAM, but the rest
of it can be dumped.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
