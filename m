Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.195])
	by ozlabs.org (Postfix) with ESMTP id CDD946877F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:52:33 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id x30so531781nfb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:52:31 -0800 (PST)
Message-ID: <528646bc0511171546s4095b3ebgb71cd13880480d1b@mail.gmail.com>
Date: Thu, 17 Nov 2005 16:46:17 -0700
From: Grant Likely <glikely@gmail.com>
To: Greg KH <greg@kroah.com>, Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20051115224056.GA14357@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051115175955.GA14518@kroah.com>
	<Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
	<20051115224056.GA14357@kroah.com>
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

On 11/15/05, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 15, 2005 at 01:34:47PM -0600, Kumar Gala wrote:
> > This is where the confusion is.  We have two instances of device A.  We
> > want instance 1 of device A bound to driver "enet" and instance 2 of
> > device A bound to "serial".
>
> That's different from what was described earlier :)
>
> In this case, you need two different struct devices.
Which is what we have.

>
> > Today both instances are called "deviceA".  However we can't register t=
wo
> > different drivers as "deviceA".
>
> Nor would you want to.
>
> > Not sure if that clarifies the issue any.
>
> A bit.  I think it still sounds messy...
Does this help?  (We also discussed this a bit at the PPC BoF at OLS this y=
ear)

 For example on the mpc52xx (see arch/ppc/syslib/mpc52xx_devices.c);
   - 6 PSC devices on chip;
   - (struct platform_device) for each device has: .name=3D'mpc52xx-psc';
   - However, SCC1 may be driven by the Ethernet driver but PSC2 and
PSC6 may be serial
   - problem then is: How do you get only PSC1 bound to the
psc-ethernet driver and only PSC2 & PSC6 bound to the serial driver?

Possible solution;  Modify the naming scheme slightly from what is
currently used.
1. Make the Ethernet driver register the name "mpc52xx-psc:eth"
2. Make the serial driver register the name "mpc52xx-psc:uart"
3. In the board-specific platform code, modify the .name field in
struct platform_device *before* the device is registered with the
platform device. (possibly by extending ppc_sys_device_fixup callback)
   - The board specific code would set PSC1 to "mpc52xx-psc:eth",
PSC2&6 to "mpc52xx-psc:uart".  PSC3-5 would stick with "mpc52xx-psc"
and so would not get bound to anything.

Q: Can the .name field be modified *after* platform_device is
registered w/ the platform bus?

g.
