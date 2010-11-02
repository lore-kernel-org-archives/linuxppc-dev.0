Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [72.1.168.231])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12D6DB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 13:21:34 +1100 (EST)
Message-ID: <4CCF759A.2010206@tilera.com>
Date: Mon, 1 Nov 2010 22:21:15 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: <michael@ellerman.id.au>
Subject: Re: [PATCH] drivers/char/hvc_console.c: reduce max idle timeout
References: <201010271659.o9RGxrMc009847@farm-0002.internal.tilera.com>
	<1288658108.16790.13.camel@concordia>
In-Reply-To: <1288658108.16790.13.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/1/2010 8:35 PM, Michael Ellerman wrote:
> On Wed, 2010-10-27 at 12:54 -0400, Chris Metcalf wrote:
>> The tile architecture uses this framework for our serial console,
>> and our users complain that the delay of up to two seconds feels like
>> the machine has gone non-responsive and is disturbing.  By contrast,
>> a delay of up to half a second feels like just the normal sort of
>> delay caused by swapping, network lag, etc. and is not noticeable.
>> The overhead is obviously not much greater.
> It's 4 times greater.
>
> We picked 2 seconds because it gave a reasonable trade off between
> responsiveness and load. I'm not convinced that half a second is a
> better number.

Perhaps the tradeoff should be tunable, then?  I think on our architecture
we're willing to pay a higher cost on the core running this task, since we
have many cores; we often have a core that mostly just runs miscellaneous
Linux administrative tasks anyway, so adding a bit more overhead there is
not significant for us.

This issue has caused multiple reports of unresponsiveness from our users,
so I'd be interested in finding a way to strike a balance.  We could use a
config option defaulting to 2 seconds (for example), or something more
dynamic (probably unnecessary).

Let me know your preference, if this sounds plausible, and I'll write up a
proposed patch.  Thanks.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
