Message-ID: <40EC7CFC.3010400@246tNt.com>
Date: Thu, 08 Jul 2004 00:45:16 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EB1C28.3000402@246tNt.com> <40EC2DC8.5020400@246tNt.com> <17EAD0B0-D057-11D8-9E83-003065F9B7DC@embeddededge.com>
In-Reply-To: <17EAD0B0-D057-11D8-9E83-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

> The use of BATs is a significant performance advantage.  It's
> relatively easy to create an ioremap() function that can see if
> a BAT covers a space we want and return an appropriate
> mapped address.  The converse, creating an ioremap() function
> that is smart enough to track all of the I/O usage and determine
> how best to use BATs, is very challenging.

Yes, sure.

> Due to the way we have to access memory and devices for
> initialization (when vm mapping through ioremap() isn't available)
> and the constraints on the kernel VM space, I find it easy to
> just declare the BAT values and let ioremap() work as it does in 2.4.

> If you look outside of the traditional PowerPC cores (to things
> like 8xx, 4xx, and 85xx) you will find even more challenging
> early or efficient mapping problems.
>
> Just set the BATs according to the board configurations, keep
> the functions simple, and move on.  These functions are
> currently working fine for many of the 603 core platforms.  I'd
> suggest changing your board setup functions to work with
> the common code already present instead of trying to fix
> something that isn't broken.

Well, I certainly never meant to change any standard functions.
I just wanted to avoid being dependent on it, so it works with or
without it. But I've dropped it. As you said, there are multiples
register that need to be accessed at init while other things just don't
work yet.

Just a remaining question. I got one call to ioremap() before
mem_init_done, it works as expected and returns a valid pointer. I just
wonder if the mapping it has done will remain valid after vm init. I
guess so but I'd rather not discover it the hard way.


Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
