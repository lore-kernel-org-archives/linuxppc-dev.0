Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94071474C5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 23:05:59 +1100 (EST)
Subject: Re: Lock-up on PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1231158516.8367.3.camel@localhost>
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<20081222233223.GA6688@joi> <877i5rh9rm.fsf@linmac.oyster.ru>
	<20081223234513.GA8730@deepthought> <871vvy77v4.fsf@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
	<1231158516.8367.3.camel@localhost>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 23:05:25 +1100
Message-Id: <1231243525.14860.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, malc <av1474@comtv.ru>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-05 at 23:28 +1100, Michael Ellerman wrote:
> I'm confused. Which code never exercises which path, and so what
> deserves a better look?

Well, the thing is with the fix that went into 2.6.30, some error path
will never bit hit, or pretty much.

Without the fix, what can happen is that a syscall incorrectly is
interpreted as returning an error, thus triggering rarely used error
path in Mono. However, that shouldn't lockup the whole machine :-)

So It's still worth investigating what's happening when taking the fix
out, as we may have another bug somewhere lurking.

Cheers,
Ben.
