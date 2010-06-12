Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53FDC1007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 12:58:29 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <ppc6dev@digitaldans.com>
In-Reply-To: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Jun 2010 12:58:07 +1000
Message-ID: <1276311487.1962.172.camel@pasglop>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-11 at 16:47 -0700, Dan Malek wrote:
> Hi Grant.
> 
> On Jun 11, 2010, at 3:59 PM, Grant Likely wrote:
> 
> > I've been doing a bit of work on some introductory level documentation
> > of the flattened device tree.
> 
> Wow, I feel empowered to create device trees now :-)
> Seriously, I never understood this well and this is a
> great document.
> 
> I have one source of confusion.  Your first Initial structure
> example uses 'compatible' to describe the machine, the
> paragraph below then mentions the 'model' property,
> and all subsequent examples use model.
> 
> Does this mean if I use just the single line in the dts,
> using 'compatible' implies the ARM machine ID?  If I
> have more description I use 'model'?

Normally, "compatible" is what is used for code to match,
and model is more like a user-visible thingy.

It's possible to peek at 'model' tho, in some cases, I've seen the case
for example where things are -supposed- to be identical from an arch
point of view, have the same compatible, but later on, a quirk is found
and a test against model is used to differentiate. But that's something
to avoid in general. Better off having multiple strings in "compatible"
then, one more "generic" to have the BSP match against, and one more
"specific" that can be used if a quirk is needed.

Of course, it doesn't help that all pseries have "chrp" and nothing else
as compatible :-) But then, both IBM and Apple have been quite lax with
their (ab)use of the DT.

Cheers,
Ben.
