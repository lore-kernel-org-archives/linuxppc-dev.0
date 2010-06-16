Return-Path: <richardcochran@gmail.com>
Date: Wed, 16 Jun 2010 08:45:41 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 10/12] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
Message-ID: <20100616064541.GD2887@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<041faf3cb6ecbedf8f3ff2104914f91d2a24fc4d.1276615626.git.richard.cochran@omicron.at>
	<AANLkTikFc15j-Qhw9M2CnKLKq58Wi1xD7E2dtVNsVgeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikFc15j-Qhw9M2CnKLKq58Wi1xD7E2dtVNsVgeA@mail.gmail.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 11:20:41AM -0600, Grant Likely wrote:
> 
> Is this header file used by anything other than gianfar_ptp.c?  If
> not, then roll the two files together.

I anticipate that it might be necessary to share the header's contents
with gianfar.c one day.

> Use dash ('-') not underscore ('_') in property names.

Okay, can do.

> If you encode this value as a string, then it will be friendly for humans too.

Okay.

> I could use more explication here.  Is this a divider value?
> Computers are good at making calculations, and the driver can obtain
> the clock frequency supplied to the device.  It may be more useful to
> specify here the desired frequency rather than the divider.  Certainly
> more human-friendly too.

It is not that simple. The basic algorithm is described in the text,
and anyone wanting to use the eTSEC for PTP will have to consider the
issue themselves, since it is a design issue with a few tradeoffs
related to the board layout. It is really too thorny to do in the
driver automatically.

I can post a tcltk calculator script for finding appropriate values,
in anyone would like to see it.

> > +static struct etsects the_clock;
> 
> Will there ever be multiple instances of this device?

No, never. If you consider how PTP works, there can only be one clock
per system.

> Consider of_iomap(), it will simplify the code a bit.

> Move ptp_gianfar_exit() definition here so it is immediately before
> the module_exit() line.

Okay.


Thanks for the review,

Richard
