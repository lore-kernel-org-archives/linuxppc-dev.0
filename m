Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C1E3667BC1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:03:16 +1000 (EST)
Date: Thu, 21 Sep 2006 10:03:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
Message-Id: <20060921100315.89d74f6f.sfr@canb.auug.org.au>
In-Reply-To: <1158768096.19375.6.camel@basalt.austin.ibm.com>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
	<20060918153853.f4332d2a.sfr@canb.auug.org.au>
	<20060920221558.1322b8b4.sfr@canb.auug.org.au>
	<1158768096.19375.6.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Hollis,

On Wed, 20 Sep 2006 11:01:36 -0500 Hollis Blanchard <hollisb@us.ibm.com> wrote:
>
> On Wed, 2006-09-20 at 22:15 +1000, Stephen Rothwell wrote:
> > +       if (firmware_has_feature(FW_FEATURE_ISERIES)) {
> > +               BUG();
> > +               return;
> > +       }
> 
> Shouldn't all these be BUG_ON(firmware_has_feature(FW_FEATURE_ISERIES))?

In this case, the return helps because the compiler will not generate the
following code in iSeries only builds.  If we could tell the compiler
that BUG() and BUG_ON() won't return, then BUG_ON() would be better.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
