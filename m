Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe01x03-cgp.akado.ru [77.232.31.164])
	by ozlabs.org (Postfix) with ESMTP id 81C1ADDDE0
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Dec 2008 12:45:01 +1100 (EST)
Date: Sun, 28 Dec 2008 03:45:05 +0300 (MSK)
From: malc <av1474@comtv.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Lock-up on PPC64
In-Reply-To: <1230165163.7292.32.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<20081222233223.GA6688@joi> <877i5rh9rm.fsf@linmac.oyster.ru>
	<20081223234513.GA8730@deepthought> <871vvy77v4.fsf@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Dec 2008, Benjamin Herrenschmidt wrote:

> On Wed, 2008-12-24 at 03:08 +0300, malc@pulsesoft.com wrote:
>> Ken Moffat <zarniwhoop@ntlworld.com> writes:
>>
>>> On Tue, Dec 23, 2008 at 06:04:45AM +0300, malc@pulsesoft.com wrote:

[..snip..]

>>
>> Thanks for the reference, but i'm sure, now more than ever, that bad
>> memory has nothing to do with it, all signs are there that kernel is
>> confused by the way signals are (mis)used by Mono.
>
> It shouldn't be but I agree with you, it smells bad. Can you report that
> again on the linuxppc-dev@ozlabs.org mailing list ? Along with
> instructions to d/l, install & run the minimum repro-case ? I'll try to
> give it a go on different ppc64 machines as soon as I'm over my upcoming
> xmas hangover :-) If it appears to be ps3 specific, we can work with
> Geoff Levand (PS3 maintainer for Sony) to try to identify the root cause
> and fix it.

I've posted a message to linuxppc-dev via gmane, but AFAICS it never made
it there. Anyhow, here's another try:

Mono can be obtained from:
http://ftp.novell.com/pub/mono/sources/mono/mono-2.0.1.tar.bz2

Although 2.0.1 only supports ppc32 the problem is still reproducible.

Now to the Christmas cheer, i've tried v2.6.28 and couldn't help but
notice that the problem is gone, bisecting v2.6.27 (which funnily i
had to mark good) to v2.6.28 (which has to be marked bad) wasn't fun
but eventually converged at ab598b6680f1e74c267d1547ee352f3e1e530f89

commit ab598b6680f1e74c267d1547ee352f3e1e530f89
Author: Paul Mackerras <paulus@samba.org>
Date:   Sun Nov 30 11:49:45 2008 +0000

     powerpc: Fix system calls on Cell entered with XER.SO=1

Now the lock-up is gone, however the code never exercises the path
taken during the lock-up so i guess it, at least, deserves a better
look by PPC64 care takers.

-- 
mailto:av1474@comtv.ru
