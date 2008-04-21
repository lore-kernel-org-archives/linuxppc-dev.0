Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id B3AD2DE2BF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 09:27:44 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1519005wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 16:27:43 -0700 (PDT)
Message-ID: <fa686aa40804211627n44ff6dfek873e29dc077116a2@mail.gmail.com>
Date: Mon, 21 Apr 2008 17:27:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
In-Reply-To: <20080421183914.GA6213@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190908.GA4407@polina.dev.rtsoft.ru>
	<fa686aa40804210703iaa8251ctc125313a8e52f4ef@mail.gmail.com>
	<20080421183914.GA6213@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 12:39 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Apr 21, 2008 at 08:03:31AM -0600, Grant Likely wrote:
>
> > >  +    r) Freescale General-purpose Timers Module
>  > >  +
>  > >  +    Required properties:
>  > >  +      - compatible : should be "fsl,gtm" ("fsl,qe-gtm" in addition for QE
>  > >  +                     GTMs or "fsl,cpm2-gtm" for CPM2 GTMs).
>  >
>  > I don't think this is specific enough.  It is a very real possibility
>  > for Freescale to produce another part with a "general purpose timers
>  > module" that isn't register level compatible (and fsl,i2c is an
>  > example of what not to do).
>
>  If that happens, we'll make up "fsl,gtm2". :-)

:-P

>  >  The compatible string should include the
>  > exact chip version.  Newer parts can also claim compatibility with
>  > older ones.
>  >
>  > Defining a 'generic' compatible value is also known as "making stuff up".  :-)
>
>  Nothing wrong with making stuff up as long as we do it sanely.
>
>  How about something like fsl,gtm-1.0?

The problem I have with that is that there is always the potential
that some rogue hardware will appear that messes up your sane scheme.
Plus there is pretty much no downside to just choosing a device that
the more recent parts reference.

Example:  consider 3 chips using the same i2c core; say MPC8313,
MPC5200 & MPC8548.  compatible lines could look like this:
    compatible = "fsl,mpc8313-i2c","fsl-i2c";
    compatible = "fsl,mpc5200-i2c","fsl-i2c";
    compatible = "fsl,mpc8548-i2c","fsl-i2c";

Or; (assuming 8313 is where it first appeared) it could look like this:

    compatible = "fsl,mpc8313-i2c";
    compatible = "fsl,mpc5200-i2c","fsl,mpc8313-i2c";
    compatible = "fsl,mpc8548-i2c","fsl,mpc8313-i2c";

To the driver it's just a different string ("fsl,mpc8313-i2c" instead
of "fsl-i2c"), but with the second you *always* know what an
mpc8131-i2c core is; the mpc8131 user guide tells you.  Even if you
are strict about your sane naming scheme, you cannot look into the
future and someone will do something wonky on you.

The other benefit is it avoids the temptation to define generic
compatible values for things which will *never* be generic parts.
Case in point; when I did the original mpc5200 bindings I did things
like "mpc52xx-<blah>".  However, there probably never will be another
mpc52xx part; and if there is it will look vastly different from the
current 5200.  So I wasted all kinds of effort trying to be generic
about stuff when it is almost certainly wasted effort and additional
complexity to the naming conventions.

>  > >  +static inline void gtm_ack_timer16(struct gtm_timer *tmr, u16 events)
>  > >  +{
>  > >  +       out_be16(tmr->gtevr, events);
>  > >  +}
>  >
>  > Drop 'inline' and expect gcc to do the right thing.
>
>  Not in a header...

Oops, yeah; not sure what I was smoking.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
