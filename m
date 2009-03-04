Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 5D083DE06B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 02:58:02 +1100 (EST)
Received: by gxk22 with SMTP id 22so367471gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Mar 2009 07:58:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <68DDAAA9-42AF-4E9C-907C-7D3269816184@it-loops.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<fa686aa40903011715u2aed4c23tb8182634fa1220f6@mail.gmail.com>
	<c19541729a7d99548faadbabe5c7646c@localhost>
	<fa686aa40903020708y1f9f8ceeueb13f9146534df8d@mail.gmail.com>
	<9d38520266f15d80352d1554e63c1ce6@localhost>
	<a57485706bfc7aae2295acd743445312@localhost>
	<fa686aa40903030723p7d82edbfg5928adf9fe108b01@mail.gmail.com>
	<7AC161D8-83A8-4330-A2CF-3120F15D9038@it-loops.com>
	<fa686aa40903031310o4e0c0b2bnba0544012b0fb8bc@mail.gmail.com>
	<68DDAAA9-42AF-4E9C-907C-7D3269816184@it-loops.com>
Date: Wed, 4 Mar 2009 08:57:59 -0700
Message-ID: <fa686aa40903040757n3992fec4jb6f3b75396af2958@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm posting this back on the mailing list.  You're not being dense and
there are good questions here which others might elaborate more on.

On Tue, Mar 3, 2009 at 2:56 PM, Michael Guntsche <mike@it-loops.com> wrote:
> The routeboard is already providing a device-tree albeit not a very good
> one, otherwise the board would not boot in the first please if I just use=
 a
> plain kernel

I need more information here.  What do you mean when you say "plain
kernel".  What file from the build process do you use, and how do you
boot it?

> without an embedded tree. I need to fix this device tree since the new
> gianfar network code is expecting
>
> tbi-handle =3D <&tbi1>;
>
> Entries in the ethernet nodes to find the PHY devices. I do not know if y=
ou
> looked at the source of rbppc.c in detail. There is already code in there=
 to
> init the PCI bus
> since the tree is missing data for this.

I don't see a file named rbppc.c in the current kernel tree.

> * Why can't I just add those missing values in the setup-arch section of =
the
> code?

You might be able to use of_attach_node() & prom_add_property() to
modify the tree, but I've never done it myself.  Give it a try and
tell me if it works.  :-)

> =A0They are needed to init the NICs correctly so I can fix this here befo=
re
> the driver is loaded

Another option is to add a workaround to the driver.  This isn't
ideal, but driver authors aren't supposed to break device tree
bindings either.  Drivers are supposed to remain backwards compatible
with older device trees (either by patching the device tree or with
explicit workarounds).  Downside is that this type of change may be
harder to get merged.  And it's just plain not very pretty.

> * How could I add those information?
> =A0Can't I just do something similar to platforms/iseries/vio.c
> =A0(add_string_property and do_device_node)?

Maybe.  I don't know why those functions are tucked away in vio.c
instead of being common code.  If you go that approach, refactor the
functions you use to be shared.

> This wold have the benefit of getting the rest of the data from the board
> and just patch it with the needed values.

This is definitely preferred to wholesale replacement of the available tree=
.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
