Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id AEE9CDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 09:30:50 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-173.bayarea.dialup.o1.com
	[66.81.71.173]) (authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mADMTNC5043804
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 14:30:41 -0800 (PST)
Message-ID: <491CAA32.20307@hypersurf.com>
Date: Thu, 13 Nov 2008 14:29:06 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: pmac_zilog debugging ...
References: <4914B549.9010805@hypersurf.com>	
	<1226096603.13603.74.camel@pasglop>
	<491C11B2.1060909@hypersurf.com> <1226612654.7178.84.camel@pasglop>
In-Reply-To: <1226612654.7178.84.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-11-13 at 03:38 -0800, Kevin Diggs wrote:
> 
> 
>>12,206 PowerMac Zilog interrupts
>>
>>Interrupt load is higher without the DMA support.
>>
>>Is it possible that this hardware was not meant to be used without the
>>DMA (i.e. it does not work quite right?)?
> 
> 
> Well, the HW Rx buffer is only 3 bytes so if you have high interrupt
> latencies you are more likely to loose data...
> 
These are not real 8530s any more, right? How certain are we of this?
Is it possible that there is a larger buffer when used with the DMA
capability ... somehow?

> Now, as I said, have you looked at flow control ? It's a likely cause of
> problems and it's possible that pmac_zilog doesn't do it the way
> macserial did...
> 
I tried to put some debug statements where the flow lines are managed. I
could have goofed it up. They never produce any output. The latest
attempt used nortscts which should have disabled flow control. That
coupled with the fact that a 250 MHz 750GX is talking to a 486dx4 at
1200 - 9600 baud I would have thought would reduce the chance the PowerMac
would fall behind?

> Regarding DMA, it's possible to implement, though there were interesting
> issues with the way it was done in macserial, it should be done
> differently in pmac_zilog.
> 
> I think the only approach that really works properly (though it's fugly)
> is what Apple does in OSX I think, which is to have a DMA descriptor per
> input byte (no need for a huge DMA buffer anyway).
> 
You would need to explain to me the advantage of doing DMA in this case???

> Cheers,
> Ben.
> 
> 
