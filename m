Return-Path: <scottwood@freescale.com>
Message-ID: <45D09B6B.8040309@freescale.com>
Date: Mon, 12 Feb 2007 10:52:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230149.GS3849@ld0162-tx32.am.freescale.net>
	<20070208211529.GA1894@localhost.localdomain>
	<45CCAB41.4080003@freescale.com>
	<20070210010237.GF8276@localhost.localdomain>
In-Reply-To: <20070210010237.GF8276@localhost.localdomain>
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

David Gibson wrote:
> On Fri, Feb 09, 2007 at 11:11:29AM -0600, Scott Wood wrote:
>>They come from platform files such as cuboot-83xx.c, not (directly) from 
>>the kernel config.
> 
> 
> /me looks again...
> 
> .c files containing only #defines?  My brain hurts.

So does mine.  It wasn't my idea...

> Better to pass these in as -D flags from the gcc invocation within the
> wrapper script, depending on the given platform (for the platform .o
> *only*). 

I was explicitly told by Paul that it had to be link-time, not compile-time.

See "http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030532.html".

Unless you're saying that the "wrapper" script should do the compilation 
itself, rather than just linking as it currently does...  in which case 
I'd really like to know what real benefit we're getting out of all this 
silliness.

> Oh, and please don't call them CONFIG_* or everyone will
> assume, like me, that they come from the kernel's overall config.h.

Well, they are related, and I'd have to make ppcboot.h diverge even more 
from u-boot's version to call it something else.

But I can rename it TARGET_* or something if it'd make y'all happier.

-Scott
