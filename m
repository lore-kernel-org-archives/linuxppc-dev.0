Return-Path: <bgat@billgatliff.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 03011B7CFA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 23:34:30 +1000 (EST)
Received: by gyf2 with SMTP id 2so1972714gyf.15
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 06:34:28 -0700 (PDT)
Message-ID: <4BC07EAD.9020307@billgatliff.com>
Date: Sat, 10 Apr 2010 08:35:41 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: A better way to sequence driver initialization?
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
In-Reply-To: <1270889597.6865.107.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2010-04-09 at 14:23 -0500, Bill Gatliff wrote:
>   
>> My recent post, "Requesting a GPIO that hasn't been registered yet", and
>> Anton's reply thereto (thanks, Anton!) on linuxppc-dev got me thinking
>> about the problem of dependencies between devices in different  classes,
>> and/or between drivers/devices in general.  I'd like to float an idea to
>> see if it's worth pursuing. 
>>     
>
> I'd rather do things a bit more explicitely and less prone to break
> existing stuff... something along the lines of, first defining a variant
> of the initcalls to enable that "multithreaded" stuff, along with an
> explicit wait_for_service("subsys:hid"); for example.
>
> One could also expose service deps via the module info, thus delaying
> module init, or things like that (in fact, initcalls could even come
> with a list of dependencies).
>   

The general problem with your approach is that the module in question
might not know what services it needs to wait for.

Specific to my situation, the gpio-led code doesn't have any way of
knowing that it needs to wait until my pca953x i2c devices have all been
installed so that the gpio pin I have specified even exists.  And short
of setting up some kind of table in the board-specific code (or device
tree, actually), I don't know how to communicate such a dependency
without touching the generic gpio-led code--- which I'm trying to avoid.

I just want gpio-led to try again if the gpio pin it has been provided
can't be requested yet.  And I can see the need for similar behavior in
several other of my drivers, hence the desire to generalize things a
bit.  I'm pretty sure my approach is only half-baked, but it does seem
to avoid the need to touch a bunch of existing code--- especially to add
board-specific dependencies.  It just give the system a tool to sort
things out on its own.

I do think your overall criticism is valid, though.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
