Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711190853y3ea1fd6cl883caaddbc1530cc@mail.gmail.com>
Date: Mon, 19 Nov 2007 09:53:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <4741BD5D.2090502@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<4741BD5D.2090502@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > You probably mean "don't use the of_platform bus to load the fabric
> > driver".
>
> Yes, that is what I meant.
>
> > He still needs to use the data in the device tree to decide
> > what fabric drivers to use.
>
> I'm not sure about that.  The fabric driver is tied to the platform itself,
> mostly because the fabric driver isn't really a device driver.  It's a
> platform driver, in that its job is to initialize the other device drivers, or
> make sure the kernel initializes them.  It's also responsible for telling ALSA
>   which driver does what and how they're connected.
>

Even it it's just based on the board "model" property; that's still
deciding what the ALSA fabric is based on data in the device tree.
:-)

> > Another option is to explicitly call of_platform_device_create in the
> > platform code on the fabric node (which should be a child of the root
> > node) so that you can have an of_platform_bus fabric driver.
>
> I don't fully understand platform drivers.  Do we really need a full-blown OF
> platform driver for this?

Both the platform bus and the of_platform bus do exactly the same
thing in a simple manner.  They allow devices to be matched with
drivers.  It is a low overhead mechanism.

In both cases, devices carry with them some metadata to describe the
devices.  For platform devices, that meta data is a resource structure
and a device specific pdata structure.  For of_platform devices, the
metadata is a pointer to a device tree node.

That's it.  Using either mechanism allows the platform code to say
"these devices are present" without having to explicitly call routines
into the driver.  In other words; it can provide late binding of
drivers to devices.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
