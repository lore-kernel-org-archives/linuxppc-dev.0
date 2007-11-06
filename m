Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id DF0C1DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 10:25:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so316969and
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 15:25:21 -0800 (PST)
Message-ID: <fa686aa40711061525y79f9f99eneda32b09a77ddcd5@mail.gmail.com>
Date: Tue, 6 Nov 2007 16:25:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [PATCH v3 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
In-Reply-To: <20071106222224.D67BA2479C@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com>
	<20071106222224.D67BA2479C@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/07, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
> in message <fa686aa40711061304k4779d01cu7fd1b17d1d34e5a2@mail.gmail.com> you wrote:
> >
> > In other words; make the assumption that it is easier to change the
> > kernel than it is to change the device tree.
>
> Are you serious about this?
>
> Reading this from someone with your experience with device trees if
> feeding my worst fears...

I think I better clarify.

Once a device tree is written and shipped on a deployed board, it may
never change again.  Or, the kernel version may be updated more
frequently than the device tree.

Say, for example, that in kernel 2.6.25 tqm5200 and cm5200 are both
handled by the same platform code.  And lets say that in 2.6.26 we
decide that they really need to have separate platform code (perhaps
due to a firmware bug that needs to be worked around on one board).
In this case, "mpc5200-simple-platform" has suddenly become useless.
Or, does mpc5200-simple-platform now describe the cm5200 or the
tqm5200?  (an assumption which cannot be made due to deployed boards
of both types claiming "mpc5200-simple-platform").

Trying to claim "compatible" at the board level is far more difficult
than claiming it at the device level.

Segher suggested on IRC: "for boards it is pretty much useless most of
the time, i think -- use "model" instead"

Cheers,
g.



>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "Text processing has made it possible to right-justify any idea, even
> one which cannot be justified on any other grounds."
>                                                  -- J. Finnegan, USC.
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
