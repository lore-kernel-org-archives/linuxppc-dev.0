Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4023DDDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 09:22:45 +1100 (EST)
Subject: Re: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090209094014.GE7930@elte.hu>
References: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
	<20090209094014.GE7930@elte.hu>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 09:21:59 +1100
Message-Id: <1234218119.31963.109.camel@pasglop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-02-09 at 10:40 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 
> > Paul,
> > 
> > I found the bug that was causing large modules to fail in setting
> > up dynamic ftrace. It wound up being a simple math error. To calculate
> > the offset in the TOC, I had used an OR, but the bottom half was
> > a signed extended short, and it should have been an addition.
> > The fix is in my tree below, as well as posted here.
> 
> Looks like a .29 candidate?

Yup, I was planning to send it to Linus along with a handful of other
powerpc fixes today, unless you prefer taking it yourself.

Cheers,
Ben.
