Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 4BE96DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 02:02:31 +1100 (EST)
Date: Mon, 9 Feb 2009 10:02:28 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
In-Reply-To: <20090209094014.GE7930@elte.hu>
Message-ID: <alpine.DEB.1.10.0902091000400.14528@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
	<20090209094014.GE7930@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


On Mon, 9 Feb 2009, Ingo Molnar wrote:

> 
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

Ingo,

I think Ben pulled them into their tree. The changes are specific to ppc, 
and will probably get better user testing there. Unless you feel that we 
have a bit of ppc testers using tip.

-- Steve
