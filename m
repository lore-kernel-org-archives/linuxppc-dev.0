Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9AC54DE020
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:33:33 +1100 (EST)
Message-ID: <45D1F659.6090106@ru.mvista.com>
Date: Tue, 13 Feb 2007 20:33:13 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
In-Reply-To: <45D1F46C.4050901@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Timur Tabi wrote:

>>    I'm mainly concerned about 85xx. I guess the needed change should 
>> be very alike...

> I've submitted U-Boot patches for 83xx, 85xx, 86xx, and 5xxx to the 
> maintainers.  You'll have to ask them when the patches will be applied.

    In fact, I/'m regretting not fixing this myself -- Andy said it'll be 
fixed RSN and it took about 2 months (actually, more since the issue was first 
noticed by me in October)...

>>> I wanted to keep my patch simple.

>>    That's clearly an over-simplification to repeat the same code thrice.

> Actually, the 2nd and third instances are conditionally compiled, so in 

    I think that's a bad excuse. You could have coded inline function at least.

> most cases only one instance of the code will actually be compiled.  
> gfar_of_init() should probably also be conditionally compiled, so if I 

    But it's not?

> make it a separate function, I'd have to prefix it with something like 
> this:

> #if defined(CONFIG_GIANFAR) || defined(CONFIG_CPM2) || defined(CONFIG_8xx)

> and then I would need to pass a bunch of parameters.  I don't really 
> think that's an improvement.

> Paul, if there are no serious objections, please apply this patch.

    I object -- such practice produces the code that is harder to change and 
which is more likely to get out of sync between the 3 instances later. :-/

WBR, Sergei
