Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C101DDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 02:24:51 +1100 (EST)
Date: Mon, 9 Feb 2009 16:24:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
Message-ID: <20090209152424.GA9845@elte.hu>
References: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
	<20090209094014.GE7930@elte.hu>
	<alpine.DEB.1.10.0902091000400.14528@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0902091000400.14528@gandalf.stny.rr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Mon, 9 Feb 2009, Ingo Molnar wrote:
> 
> > 
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > 
> > > Paul,
> > > 
> > > I found the bug that was causing large modules to fail in setting
> > > up dynamic ftrace. It wound up being a simple math error. To calculate
> > > the offset in the TOC, I had used an OR, but the bottom half was
> > > a signed extended short, and it should have been an addition.
> > > The fix is in my tree below, as well as posted here.
> > 
> > Looks like a .29 candidate?
> 
> Ingo,
> 
> I think Ben pulled them into their tree. The changes are specific to ppc, 
> and will probably get better user testing there. Unless you feel that we 
> have a bit of ppc testers using tip.

no, that's fine - just wanted to make sure it goes upstream via some method.

	Ingo
