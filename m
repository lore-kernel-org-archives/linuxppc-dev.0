Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by ozlabs.org (Postfix) with ESMTP id 741E9DDE25
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 11:57:58 +1100 (EST)
Message-ID: <4733AF6B.60807@gmail.com>
Date: Thu, 08 Nov 2007 19:52:59 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Use embedded libfdt in the bootwrapper
References: <20071108033241.GA11695@localhost.localdomain>	<20071108033603.8A29FDDE0F@ozlabs.org>	<20071108160839.GA4356@loki.buserror.net>	<20071108224051.GB18592@localhost.localdomain>
	<473392A3.4010203@freescale.com>
In-Reply-To: <473392A3.4010203@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> David Gibson wrote:
>>> How hard would it be to get libfdt to dynamically allocate any extra space
>>> it needs?  This is a regression from the current flat device tree code...
>> Uh.. it already does.  Or rather, the shims in libfdt-wrapper.c do so,
>> when libfdt functions which can expand the tree report that they've
>> run out of room.
> 
> Ah, good -- I was looking in libfdt itself, not the wrapper.  Now if 
> only we could get something similar into u-boot... maybe libfdt proper 
> could accept an optional realloc() function pointer in fdt_init(), and 
> eliminate the need for the caller to provide such a wrapper?
> 
> -Scott

Hi Scott,

My concern from the u-boot side is that u-boot has to know exactly 
*where* to put the expanded blob because it has to pass it to linux and 
keep it out of linux' way so it doesn't get "stepped on."  Linux has an 
advantage in that it "owns" all of memory and can allocate and 
deallocate whatever and wherever and it won't step on itself (hopefully).

I'm assuming your boot wedge has the advantage of being able to use 
linux's malloc() and thus don't have to worry about coordinating with 
linux on memory allocation.

With the current u-boot fdt command, you can resize the blob, and this 
can be done in a script with all the (somewhat limited) capabilities of 
the u-boot shell (an adaptation of hush).

In the u-boot world, we fixate on memory maps and putting things in 
specific places.  Maybe I'm making a problem where one doesn't exist, 
but an arbitrary malloc() in u-boot (as opposed to linux's malloc) seems 
like a Bad Thing[tm] because it is uncontrolled and may end up in a very 
bad place when linux starts (e.g. the linux start up script expands 
linux on top of the blob).

Best regards,
gvb
