Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE505B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 02:53:50 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 70557DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 02:53:50 +1000 (EST)
Date: Fri, 4 Sep 2009 20:53:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC 1/2] Makefile: Never use -fno-omit-frame-pointer
Message-ID: <20090904165348.GA1287@oksana.dev.rtsoft.ru>
References: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
	<20090714133716.GC28970@oksana.dev.rtsoft.ru>
	<20090718120145.GB31007@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090718120145.GB31007@elte.hu>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 18, 2009 at 02:01:45PM +0200, Ingo Molnar wrote:
> 
> * Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > On Wed, Jun 17, 2009 at 12:16:30AM +0400, Anton Vorontsov wrote:
> > > According to Segher Boessenkool and GCC manual, -fomit-frame-pointer
> > > is only the default when optimising on archs/ABIs where it doesn't
> > > hinder debugging and -pg. So, we do not get it by default on x86,
> > > not at any optimisation level.
> > > 
> > > On the other hand, *using* -fno-omit-frame-pointer causes gcc to
> > > produce buggy code on PowerPC targets.
> > > 
> > > If Segher and GCC manual are right, this patch should be a no-op
> > > for all arches except PowerPC, where the patch fixes gcc issues.
> > > 
> > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > ---
> > > 
> > > See this thread for more discussion:
> > > http://osdir.com/ml/linux-kernel/2009-05/msg01754.html
> > > 
> > > p.s.
> > > Obviously, I didn't test this patch on anything else but PPC32. ;-)
> > > 
> > > Segher, do you know if all GCC versions that we support for
> > > building Linux are behaving the way that GCC manual describe?
> > 
> > No news is good news... Ingo, can we merge this into -tip for 
> > testing?
> 
> Changes to the top level Makefile should really go via Sam's kbuild 
> tree.

Sam, any thoughts about these patches?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
