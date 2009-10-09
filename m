Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1255096871.16018.49.camel@localhost.localdomain>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
	<fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
	<1255096871.16018.49.camel@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Oct 2009 10:09:21 -0600
Message-ID: <fa686aa40910090909q5200cf8cm95e0ecfc23d464fd@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: Nate Case <ncase@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 8:01 AM, Nate Case <ncase@xes-inc.com> wrote:
> On Thu, 2009-10-08 at 23:40 -0600, Grant Likely wrote:
>> For your future reference, patches that look at the device tree should
>> also cc: devicetree-discuss@lists.ozlabs.org so that new bindings can
>> be reviewed and common mistakes can be avoided. =A0It is expected that
>> new device tree bindings are accompanied with documentation describing
>> what the binding is for and how it should be used (see
>> Documentation/powerpc/dts-bindings).
>>
>> I know this change is already in mainline, but can you please post the
>> device tree fragment that you're using to describe this chip? =A0I want
>> to make sure we don't get stuck with things in the kernel that will be
>> hard to maintain in the long term.
>
> Hi Grant,
>
> Sorry for neglecting to include devicetree-discuss on that one. =A0I was
> in fact aware of this list, and subscribe to it. =A0I really just forgot
> in this case.

No worries, it happens.

> I also have a documentation patch for it that went along with it, but it
> wasn't ready in time and so it's been sitting in our local patch queue.
> I can submit that soon, =A0but it probably makes sense for Wolfram to
> voice whatever his concerns were about "questionable" properties before
> I document what's there.

Yes, please post it as soon as you can.

> Here's an example device tree node for this case:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio1: gpio@18 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "nxp,pca955=
7";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x18>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#gpio-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio-controller;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0polarity =3D <0x00>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> In this case, the linux,gpio-base property wasn't specified. =A0But, the
> use case is identical to the pdata->gpio_base field. =A0"polarity" is use=
d
> for specifying polarity inversion for each line, and is in the same
> format of the 'polarity inversion' register on the chip. =A0My reasoning
> in the property naming was as follows:
>
> =A0 =A0linux,gpio-base: Linux-specific as it relates to internal GPIO
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 numbering. =A0So, it's prefixed w=
ith "linux,"

This would be the 'questionable' property.  :-)  The device tree is
supposed to be OS agnostic, so I get the heebee geebees when I see new
'linux,<blah>' properties defined because it means Linux internal
implementation details are getting leaked out into the data blob.  The
problem leakage is that the device tree should not be impacted by
internal Linux code changes.

In this particular case, specifying the exact GPIO base number doesn't
really belong in the device tree because Linux is able to assign and
manage GPIO numbers on its own just like all other OF GPIO controller
drivers currently do.  In fact, that goes for pretty much all
enumeration, not just GPIO.  In general, a particular device instance
(uart, gpio, phy, whatever) should be resolved from its node in the
device tree, and not by some arbitrary number assigned by the .dts
author.  The problem with arbitrary numbers is they don't expose the
linkage between nodes in the same way a 'phandle' does (A phandle can
be searched for.  An arbitrary number assignment, good luck?), and
they don't expose intended usage (its just a meaningless number, and
it only works because userspace just happens to 'agree' to use the
same number).

> =A0 =A0polarity: Dictated by how hardware is wired up, so it's needed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0regardless of the OS.

Typically GPIO drivers have been handling this by using #gpio-cells
set to 2, and using the 2nd cell for flags.  The priority can be
encoded as a flag.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
