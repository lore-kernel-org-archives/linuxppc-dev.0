Return-Path: <glikely@secretlab.ca>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.233])
	by ozlabs.org (Postfix) with ESMTP id 2FF8BDDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 14:21:44 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so1923030hud
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:21:39 -0700 (PDT)
Message-ID: <fa686aa40710152121o2fe0d7c9m156170901fd3bf98@mail.gmail.com>
Date: Mon, 15 Oct 2007 22:21:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Scott Wood" <scottwood@freescale.com>,
	"Jean Delvare" <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	"Stefan Roese" <sr@denx.de>, i2c@lm-sensors.org
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
In-Reply-To: <20071016032041.GN26787@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
	<20071016032041.GN26787@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> As the inventor of "linux,network-index", please don't invent
> "linux,i2c-index".  linux,network-index was and is a hack - it's
> badness is limited by the fact that it's essentially local to the
> bootwrapper.  It's only used in the bootwrapper, and I only really
> intended it for use in bootwrappers which provide their own device
> tree, so as to match the device nodes against whatever order the MAC
> addresses were supplied by the firmware.
>
> I plan to replace the linux,network-index thing with aliases
> (including some dtc support to make that easy) just as soon as I get
> around to it... don't hold your breath.
>
> Using a similar property from an actual kernel driver would be much
> uglier, and harder to clean up later.

This I know from first hand experience; it is Uh-gly!  :-)

>
> Using aliases would be.. less bad, but it would still require that
> the device tree always supply an alias for the iic driver to work
> which is kind of nasty.
>
> In fact I think it may be acceptle to do the idx++ thing in this
> situation.  Bus numbers are ugly, but it's not the worst ugliness in
> the horrible mess that is the Linux i2c subsystem.  It means that bus
> numbers are theoretically unstable, but that's increasingly true of
> devices of all sorts - it's up to udev to assign meaningful labels at
> the user level.

I think the real problem here comes into play when there are 2 types
of i2c busses in the system.  If they both maintain their own idx++
values; then they will conflict.  If an auto assigned bus number is
used; then it needs to be assigned by the i2c infrastructure; not by
the driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
