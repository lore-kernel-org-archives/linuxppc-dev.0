Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id E6880DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 03:27:23 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so680748anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:27:15 -0800 (PST)
Message-ID: <fa686aa40801230827s5a7b3ea9s770abaf0ad2838b8@mail.gmail.com>
Date: Wed, 23 Jan 2008 09:27:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [PATCH] [POWERPC] Update TQM5200,
	CM5200 and Motion-PRO _defconfig and .dts files
In-Reply-To: <20080123125413.EB56924344@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479725A4.2020401@semihalf.com>
	<20080123125413.EB56924344@gemini.denx.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	tech-denx@semihalf.com, Detlev Zundel <dzu@denx.de>,
	Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/23/08, Wolfgang Denk <wd@denx.de> wrote:
> In message <479725A4.2020401@semihalf.com> you wrote:
> > Olof Johansson wrote:
> > ...
> > >
> > > I disagree, I have one defconfig for all our boards to date. It means I
> > > only have one kernel to build to test on all boards, instead of having
> > > to build a number of different kernels. Keeping it fairly generic also
> > > means a customer can start out using the generic kernel in case they
> > > want to, and later on add their own drivers and prune out what is not
> > > needed.
> >
> > Well, I just prefer separate defconfigs but I can live with the common
> > one as well, feel free to merge it as you see it fit.
>
> Well, it may make sense to use common defconfig files for  boards  of
> the same breed (different configurations of one board family from one
> vendor  for  example).  But  please  note  that  TQM5200,  CM5200 and
> Motion-PRO are boards from 3 different  vendors,  used  by  different
> projects  with  differing  needs.  IMO  it  makes  very much sense to
> provide 3 separate default configurations  that  match  the  specific
> requirements of each of these boards.
>
> In this case I vote for separate defconfig files, please.

I think I'm going to go with a single defconfig for all 5200 boards
for the time being.  We can revisit later if it turns out not to be
working.  Here are my reasons:

- mpc5200 is intended to be multiplatform.  Using a common defconfig
increases the likelyhood that a kernel with support for all 5200
platforms will actually get tested.
- Reduces the time cost required to build all powerpc defconfigs (only
1 needed instead of 5 and growing)
- defconfigs are intended to be the known working configuration; not
necessarily an optimized for deployment configuration.  The
system/kernel engineer is still responsible to tailor the
configuration for a shippable distribution.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
