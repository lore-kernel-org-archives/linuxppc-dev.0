Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8164B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 07:48:32 +1000 (EST)
Subject: Re: halt/reset on assert?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <BANLkTimX==Ei2Sn=86svSajHNX+0G1WM9w@mail.gmail.com>
References: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
	<m2sju1uoti.fsf@igel.home> <4D9C6413.8030103@cyconix.com>
	<1302162933.2458.33.camel@pasglop>
	<BANLkTimX==Ei2Sn=86svSajHNX+0G1WM9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Apr 2011 07:48:09 +1000
Message-ID: <1302212889.2458.40.camel@pasglop>
Mime-Version: 1.0
Cc: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
	Evan Lavelle <sa212+lppc@cyconix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-04-07 at 12:04 -0500, kevin diggs wrote:
> On Thu, Apr 7, 2011 at 2:55 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2011-04-06 at 14:01 +0100, Evan Lavelle wrote:
> >> #define MY_ASSERT(expr) if(!(expr)) BUG()
> >
> > Make it
> >
> > #define MY_ASSERT(expr) do { if .... } while(0)
> >
> > To ensure it has proper single statement semantics in C.
> >
> So THAT'S why they do this!!!!!! Now I just have to figure out what
> 'proper single statement semantics' means!

Thing what happens without the do { ... } while(0) if you have code
that looks like:

	if (enable_debug)
		MY_ASSERT(foo);
	else
		something_else;

Ben.
