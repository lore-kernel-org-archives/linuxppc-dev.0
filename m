Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 6B6F62BDDD
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Oct 2004 16:24:22 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i946D88K022954
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 4 Oct 2004 09:13:13 +0300 (EEST)
Message-ID: <4160E898.9080905@intracom.gr>
Date: Mon, 04 Oct 2004 09:07:20 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<20041001220648.GJ21896@smtp.west.cox.net>
In-Reply-To: <20041001220648.GJ21896@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>On Thu, Sep 30, 2004 at 10:11:03PM -0500, Kumar Gala wrote:
>
>>>>But on the other hand, I've given up a long time ago trying to 
>>>>
>>>enforce any
>>>
>>>>kind of sane model on ppc32 because the embedded folks only care 
>>>>
>>>about having
>>>
>>>>a quick ugly broken hack to work with their board, thus the 
>>>>
>>>explosion of
>>>
>>>>various incompatible boot_info structures that we have nowadays.
>>>>
>>>Yes indeed. It's ugly and needs fixing so I'll take a look at it - I
>>>just don't want to do this if everyone here already knows of a better
>>>solution which will work.
>>>
>>>Then Xilinx et al can generate memory maps and we can head towards
>>>having a single kernel binary bootable on multiple different ppc
>>>boards.
>>>
>>I would be nice to have an extensive and dynamic way to pass info from 
>>the bootloader to the kernel.  I believe that Wolfgang has stated he 
>>would be willing to change u-boot to match.  I'd be willing to fixup 
>>and move Freescale boards over to use something as long as we get 
>>u-boot to support it as well.
>>
>>I've been told that ARM has a solution, in place, to this problem that 
>>might always be worth looking at.
>>
>
>I know the ARM folks on the list will yell at me, but to be a bit too
>simple, it's a linked list of BI_ bits.
>
>I've been thinking about it, and I do believe that Ben's flattened OF
>tree wins the "show me the code" race, so lets go that way.  I'll add in
>that for most platforms we'll want to build up the tree at compile time,
>but U-Boot, and anything else smart enough can pass one in for real.
>
>Jon, I look forward to your patch. :)
>
>
Allow me, to cut in and plug my own thing.

If you follow the u-boot-users list, you'll know that some time
ago there was a similar discussion.

I too need to access and use firmware variables from Linux
and the solution I came up is extremely simple.

I just create an argv of all the environment variables of the firmware
and I pass the psysical address of that NULL terminated argv array
to the kernel command line like so... "u-boot-env=0x0f000f00".

I have working patches for u-boot, the kernel parser, a kernel /proc 
interface
for accessing them and also some patches for busybox which make access
easier as well as supporting saving them to non volatile storage.

I know this is the Nth time this discussion is taking place bu IMO something
must be finally decided. I don't really care if my solution will be selected
as long as something is at last selected.

Regards

Pantelis

P.S. Hope wd is listening in and come forward with his thoughts...
