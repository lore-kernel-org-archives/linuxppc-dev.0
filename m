Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 333E3B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 07:21:35 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 73774DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 07:21:33 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2 v3] fs_enet/mii-fec.c: fix MII speed calculation
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40907151017n76524708tdb028689adad4b5f@mail.gmail.com>
References: <1247578966-9847-1-git-send-email-wd@denx.de>
	<1247671133-12148-1-git-send-email-wd@denx.de>
	<fa686aa40907151017n76524708tdb028689adad4b5f@mail.gmail.com>
Date: Thu, 16 Jul 2009 23:21:29 +0200
Message-Id: <20090716212129.70710832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40907151017n76524708tdb028689adad4b5f@mail.gmail.com> you wrote:
> On Wed, Jul 15, 2009 at 9:18 AM, Wolfgang Denk<wd@denx.de> wrote:
> > The MII speed calculation was based on the CPU clock (ppc_proc_freq),
> > but for MPC512x we must use the bus clock instead.
> >
> > This patch makes it use the correct clock and makes sure we don't
> > clobber reserved bits in the MII_SPEED register.
...
> Drop the common code bit.  The 5200 and 5121 are different devices and
> it is a tiny bit of code.  I don't think there is any benefit to
> having it as a common function.  Just roll the get_mii_speed function
> in the mii-fec driver itself.

I don't like to see the code repeated - it makes maintenance harder
and increases the memory footprint. But if you like it that way I'll
do that.

> Also, this patch can be quite a bit simpler if you use the .data
> pointer in the drivers match table to specify the function used to
> return the bus clock speed.  Something like this:

OK, will do that, too.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Weekends were made for programming.                 - Karl Lehenbauer
