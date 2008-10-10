Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 73D89DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:40:54 +1100 (EST)
Date: Fri, 10 Oct 2008 15:40:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wang Jian <lark@linux.net.cn>
Subject: Re: Compact Flash on 8349mITX
Message-ID: <20081010114048.GA5481@oksana.dev.rtsoft.ru>
References: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>
	<6011A7C9CD0EE74792C3ED2A8355608634218F@mail.twacs.com>
	<19900326.post@talk.nabble.com>
	<20081009172338.GA4292@oksana.dev.rtsoft.ru>
	<19911261.post@talk.nabble.com> <48EF0388.3070006@linux.net.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EF0388.3070006@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org, Jeff Borlin <jborlin@aclaratech.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 03:26:00PM +0800, Wang Jian wrote:
> Jeff Borlin wrote:
>>
>> Anton Vorontsov-2 wrote:
>>> This happens just before the PATA information is printed. I'm not
>>> libata expert; and from the brief look I don't see where libata
>>> clears any pending "unexpected" irqs. Just a guesswork,
>>> could you try this patch?
>>>
>> This patch did not appear to change anything.  
>
> Without this patch, you can't use it without irq.

I purposed two patches to Jeff: one is

+       ioread8(ap->ioaddr.status_addr);

I.e. clear an interrupt before requesting (just to be sure, I guess
libata is doing this already, just don't see where exactly). That didn't
work. :-/

And another approach was to try IRQ-less pata (another patch).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
