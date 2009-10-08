Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091008151007.GA21328@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 8 Oct 2009 09:48:50 -0600
Message-ID: <fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-embedded@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 8, 2009 at 9:10 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Oct 08, 2009 at 08:53:46AM -0600, Grant Likely wrote:
> [...]
>> Please don't. =A0It is such a small amount of code,
>
> It's *always* a small amound of code, at a start. Then we get
> floppy disk drivers and the tty layer. ;-)

Holy straw man argument Batman!

But the focus is still on creating pdata.  If a translator gets too
big, then sure, split it into a separate file.  Until then, there I
see no good reason to do so now.

>
> [...]
>> Driver writers shouldn't have to
>> write anything more than a tiny function to populate pdata from the
>> device tree. =A0Managing that pdata instance needs to be done with
>> common infrastructure (but I don't have a firm idea about how it
>> should look yet). =A0In the mean time I think Wolfram's approach has
>> lower impact.
>
> If I wasn't a PPC/OF guy to some degree, I'd hate PPC/OF people
> for bringing arch-specific details into a generic code... :-P

No, this goes beyond PPC/OF.  The real issue is that it is no longer a
safe assumption that pdata will be a static data structure in platform
code.  The number of possible data sources is going to get larger, not
smaller.  OF is just one.  UEFI is another.  Translating that data
into pdata will be the problem that comes up over and over again.
However, translation code is still driver specific, so it belongs with
the driver that it translates code for.

So, in my opinion, translation code must:
1. be *tiny* -- should be trivial to add to a driver without impacting
common code
2. live with the driver that it translates data for; ideally in the
same .c file for drivers that are small.

> No matter how small the OF code is, I believe we shouldn't put it
> into the generic code. Take a look at mmc_spi case again, it can be
> easily extended to any arch, because there is no arch-specific stuff,
> but a "get/put" pattern for platform data.

I'm not disagreeing with you that the arch specific stuff should be
logically separated from the generic code.  But I don't agree that it
belongs in a separate file.  And I also think that the mmc_spi
implementation uses too much code.  There must be a better way.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
