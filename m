Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDC31B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 04:03:08 +1000 (EST)
Received: by pvf33 with SMTP id 33so1041253pvf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 03 Jun 2011 11:03:06 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 3 Jun 2011 12:03:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [rtc-linux] Re: [PATCH] Add support for pt7c4338 (rtc device) in
	rtc-ds1307 driver
Message-ID: <20110603180305.GF15616@ponder.secretlab.ca>
References: <1306393409-16153-1-git-send-email-Priyanka.Jain@freescale.com>
	<20110526091020.GA2201@pengutronix.de>
	<470DB7CE2CD0944E9436E7ADEFC02FE316DCB8@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110530082429.GA3409@pengutronix.de>
	<BANLkTi=H2rHSjTvRK5+SPhW26qCNUBMxbA@mail.gmail.com>
	<20110530165745.GA2758@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110530165745.GA2758@oksana.dev.rtsoft.ru>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>,
	Jain Priyanka-B32167 <B32167@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2011 at 08:57:45PM +0400, Anton Vorontsov wrote:
> On Mon, May 30, 2011 at 02:29:58PM +0000, Tabi Timur-B04825 wrote:
> > On Mon, May 30, 2011 at 3:24 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> > 
> > > The first place where this should be mentioned is the datasheet of the
> > > pt-chip, so you might ask the producer to add this information (don't
> > > expect much to happen, though).
> > 
> > It's true that the data sheet does not mention that it's identical to
> > the DS1307, but that's still no excuse for not noticing it and writing
> > a whole driver for it.  :-(
> > 
> > > IIRC I asked you explicitly for the differences between the chips. If
> > > there are none, you can use the driver directly, right? :)
> > 
> > Yes.  The device tree node for the PT7C4338 device should just say
> > 
> >    /* The board has a PT7C4338, which is compatible with the DS1307 */
> >    compatible = "dallas,ds1307";
> 
> While it seems to be 100% compatible, there could be chip-specific
> bugs or some interesting features that are hidden behind "reserved"
> bits and registers.
> 
> So I think device tree should not lie about the chip model. Doing
> 'compatible = "pericom,pt7c4338", "dallas,ds1307"' is perfectly fine.

Correct.  It's fine (and encouraged) to claim compatibility, but the
node should always specify the exact part in the compatible list.

> 
> Note that today the several compatible entries approach gives you
> almost nothing, as you will need to add pt7c4338 entry into the driver
> anyway.
> 
> I tried to improve this, i.e. make linux do OF-matching on the most
> generic compatible entry (the last one):
> 
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg21196.html
> 
> It was received coldly though:
> 
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg22041.html
> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg21273.html

On that note, device-tree-style of_match_table binding now works for
i2c devices, so the problems you were having with that thread should
now be solved.

The of_find_i2c_driver() approach was only ever a heuristic to get
things working in the short term.  of_match_table is is better in the
long run.

g.
