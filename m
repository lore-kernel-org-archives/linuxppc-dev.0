Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B9076B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 22:02:53 +1000 (EST)
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F0B9DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 22:02:52 +1000 (EST)
Date: Sat, 18 Jul 2009 14:01:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RFC 1/2] Makefile: Never use -fno-omit-frame-pointer
Message-ID: <20090718120145.GB31007@elte.hu>
References: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
	<20090714133716.GC28970@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090714133716.GC28970@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Wed, Jun 17, 2009 at 12:16:30AM +0400, Anton Vorontsov wrote:
> > According to Segher Boessenkool and GCC manual, -fomit-frame-pointer
> > is only the default when optimising on archs/ABIs where it doesn't
> > hinder debugging and -pg. So, we do not get it by default on x86,
> > not at any optimisation level.
> > 
> > On the other hand, *using* -fno-omit-frame-pointer causes gcc to
> > produce buggy code on PowerPC targets.
> > 
> > If Segher and GCC manual are right, this patch should be a no-op
> > for all arches except PowerPC, where the patch fixes gcc issues.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> > 
> > See this thread for more discussion:
> > http://osdir.com/ml/linux-kernel/2009-05/msg01754.html
> > 
> > p.s.
> > Obviously, I didn't test this patch on anything else but PPC32. ;-)
> > 
> > Segher, do you know if all GCC versions that we support for
> > building Linux are behaving the way that GCC manual describe?
> 
> No news is good news... Ingo, can we merge this into -tip for 
> testing?

Changes to the top level Makefile should really go via Sam's kbuild 
tree.

	Ingo
