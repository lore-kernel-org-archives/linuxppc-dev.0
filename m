Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.198])
	by ozlabs.org (Postfix) with ESMTP id D838168734
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 13:37:03 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id x30so18971nfb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 18:37:01 -0800 (PST)
Message-ID: <528646bc0511181837l61687e10g27d17c4287aaf909@mail.gmail.com>
Date: Fri, 18 Nov 2005 19:37:01 -0700
From: Grant Likely <glikely@gmail.com>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20051118234711.GB26118@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051115175955.GA14518@kroah.com>
	<Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
	<20051115224056.GA14357@kroah.com>
	<528646bc0511171546s4095b3ebgb71cd13880480d1b@mail.gmail.com>
	<20051118234711.GB26118@kroah.com>
Cc: Kumar Gala <galak@gate.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/18/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Nov 17, 2005 at 04:46:17PM -0700, Grant Likely wrote:
> > Does this help?  (We also discussed this a bit at the PPC BoF at OLS th=
is year)
> >
> >  For example on the mpc52xx (see arch/ppc/syslib/mpc52xx_devices.c);
> >    - 6 PSC devices on chip;
> >    - (struct platform_device) for each device has: .name=3D'mpc52xx-psc=
';
> >    - However, SCC1 may be driven by the Ethernet driver but PSC2 and
> > PSC6 may be serial
> >    - problem then is: How do you get only PSC1 bound to the
> > psc-ethernet driver and only PSC2 & PSC6 bound to the serial driver?
>
> I really do not know, sorry.
>
> >
> > Possible solution;  Modify the naming scheme slightly from what is
> > currently used.
> > 1. Make the Ethernet driver register the name "mpc52xx-psc:eth"
> > 2. Make the serial driver register the name "mpc52xx-psc:uart"
> > 3. In the board-specific platform code, modify the .name field in
> > struct platform_device *before* the device is registered with the
> > platform device. (possibly by extending ppc_sys_device_fixup callback)
> >    - The board specific code would set PSC1 to "mpc52xx-psc:eth",
> > PSC2&6 to "mpc52xx-psc:uart".  PSC3-5 would stick with "mpc52xx-psc"
> > and so would not get bound to anything.

Ignoring the question below, do you see any problem with the above solution=
?

> >
> > Q: Can the .name field be modified *after* platform_device is
> > registered w/ the platform bus?
>
> No, it can not, sorry.
Not a big deal, that question was a bit of an aside.  If the name
could be changed, then the device function could change at runtime by
unbinding one function driver, changing the name and rebind
another....  But now that I think about it for more that 2ms, a
solution to this would be to just unregister, change .name, and
reregister the struct platform_device.

g.
