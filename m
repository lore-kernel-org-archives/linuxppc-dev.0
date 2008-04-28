Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A71C0DE284
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 04:06:44 +1000 (EST)
Message-Id: <CC53A7EB-663C-4313-8FE3-CAF57F270437@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080428170418.GA11378@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: suggestions on handling additional exception levels on ppc32
Date: Mon, 28 Apr 2008 13:06:25 -0500
References: <DF3B8F4C-EAE1-4F44-8884-44535A855139@kernel.crashing.org>
	<20080428155928.GE9849@ld0162-tx32.am.freescale.net>
	<F8B7AFF4-85EE-4C6B-99A5-E59B416EE78B@kernel.crashing.org>
	<20080428170418.GA11378@ld0162-tx32.am.freescale.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2008, at 12:04 PM, Scott Wood wrote:
> On Mon, Apr 28, 2008 at 11:58:58AM -0500, Kumar Gala wrote:
>>
>> On Apr 28, 2008, at 10:59 AM, Scott Wood wrote:
>>> On Mon, Apr 28, 2008 at 10:40:56AM -0500, Kumar Gala wrote:
>>>> A few possibilities:
>>>> * introduce an additional function pointer as part of
>>>> EXC_XFER_TEMPLATE() to specifies the type of handler (normal, crit,
>>>> dbg, mcheck)
>>>> * use the traps field low order bits to determine normal, crit,  
>>>> dbg,
>>>> mcheck at run time.
>>>> * duplicate the code paths for each exception level
>>>>
>>>> suggestions?
>>>
>>> You could temporarily disable all asynchronous exceptions, and use  
>>> the
>>> registers of the highest-priority exception type.
>>
>> That doesn't work.  We have NMIs or will have them in the future.
>
> Truly non-maskable?  Ick.  You could have a separate code path just  
> for
> the exception type that NMIs use, I guess, if there's a clear
> highest-priority among the remaining interrupt types.  What sort of
> exceptions are they?

The NMIs are machine check only so a separate path for them isn't a  
terrible idea.

However, disabling all other interrupts seems worse than adding a  
function pointer.

- k
