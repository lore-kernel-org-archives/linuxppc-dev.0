Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0580BDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 11:17:41 +1100 (EST)
Date: Fri, 9 Nov 2007 18:18:00 -0600
From: Olof Johansson <olof@lixom.net>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Avoid unpaired stwcx. on some processors
Message-ID: <20071110001759.GA21447@lixom.net>
References: <11946460863124-git-send-email-becky.bruce@freescale.com>
	<20071109231927.GA19415@lixom.net>
	<260A8045-7F86-46EC-9242-08BC2669890F@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <260A8045-7F86-46EC-9242-08BC2669890F@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2007 at 05:52:30PM -0600, Becky Bruce wrote:

> I don't think so. It's not plain old dangling stwcx that's the  
> problem.  It's dangling stwcx when the reservation is held to another  
> address. 

Gack, I misread the description. My bad.

> The lwarx that I've added prevents the normally dangling  
> stwcx. in the context switch/syscall  path from meeting this  
> condition.  Any process that gets swapped in and executes stwcx.  
> first thing is fine, because the reservation was previously cleared  
> by the stwcx. in the context switch path.
>
> BTW, I think you're missing a key point here, which is this:  
> Architecturally, there is a single reservation per core.  On e600 and  
> other parts, the stwcx. does *not* take the address into account for  
> success.  If you stwcx, and the reservation is held, it succeeds  
> regardless of the address.   Fun, no?   That's one of the reasons  
> it's so important that the kernel have the dummy stwcx. in place.
>
> Does that make sense?

Yep, it does, doesn't seem to be a better way to work around it.


-Olof
