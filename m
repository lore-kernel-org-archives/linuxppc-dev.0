Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091008204808.GB8116@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910080737l5b21654cw9c8f7426f9faf7c3@mail.gmail.com>
	<20091008204808.GB8116@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 8 Oct 2009 16:59:04 -0600
Message-ID: <fa686aa40910081559v305185b6i6103f83437529f7e@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 8, 2009 at 2:48 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> I think in general, this is the right direction; but I'm not convinced
>> that the right pattern or form has been found yet. =A0What I don't like
>> on this particular patch is that it still hooks of-specific stuff into
>> an arbitrary point in the probe routine.
>>
>> I'd like to see some pattern for retrieving or populating a
>> platform_data structure when one isn't already provided, and
>> regardless of the data source.
>
> I thought about this, too. I just wondered how many drivers would actuall=
y need
> a 'pdata'-preparation routine before probe, and if this would not cause t=
oo
> much overhead for those who don't. But as you say OF might not the only c=
ase
> where this is needed, then it might be a reasonable choice to have an ext=
ra
> call fot setting up pdata. Then again, if we have preparation routines fo=
r
> OF,UEFI,... for each and every driver, uh, the bloat :(

It shouldn't be too bad.... I'm toying with the idea of a callable
library function which is passed in a data table of the available
translators.  Can be very simple, and the library function would take
care of pdata allocation and management.  Then the translators can be
kept down to the bare minimum of populating the structure.  If it is
done right, then only the needed translators get compiled in and it
won't add any significant size at all to the drivers.

>> will take a bit of experimentation to come up with the best form for
>> the pdata fetching function, but it will be better contained if it is
>> all at a single place.
>
> I might have a try :)

:-)


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
