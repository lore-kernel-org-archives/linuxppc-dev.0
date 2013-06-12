Return-Path: <davem@davemloft.net>
Date: Wed, 12 Jun 2013 02:15:42 -0700 (PDT)
Message-Id: <20130612.021542.427308733208440842.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH] of: Fix locking vs. interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <20130612090612.7E4ED3E0A56@localhost>
References: <1371015544.8250.182.camel@pasglop>
 <alpine.LFD.2.02.1306121023150.22970@ionos>
 <20130612090612.7E4ED3E0A56@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: devicetree-discuss@lists.ozlabs.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 12 Jun 2013 10:06:12 +0100

> On Wed, 12 Jun 2013 10:25:56 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, 12 Jun 2013, Benjamin Herrenschmidt wrote:
>> 
>> > The OF code uses irqsafe locks everywhere except in a handful of functions
>> > for no obvious reasons. Since the conversion from the old rwlocks, this
>> > now triggers lockdep warnings when used at interrupt time. At least one
>> > driver (ibmvscsi) seems to be doing that from softirq context.
>> > 
>> > This converts the few non-irqsafe locks into irqsafe ones, making them
>> > consistent with the rest of the code.
>> 
>> Fun. https://lkml.org/lkml/2013/2/4/416 seems to have got lost 
>>  
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > CC: <stable@vger.kernel.org> [v3.9+]
>> 
>> Acked-by: Thomas Gleixner <tglx@linutronix.de>
>> 
>> > ---
>> > 
>> > Note: It's silly to access the device-tree at interrupt time in most cases,
>> > and we should probably fix ibmvscsi, but for the time being, let's fix the
>> 
>> Right.
>> 
>> > obvious bug. Thomas, this can probably still go into 3.10... If not, I've
>> > CCed stable.
>> 
>> Should go through Grant I think.
> 
> Applied, thanks.

FWIW:

Acked-by: David S. Miller <davem@davemloft.net>
