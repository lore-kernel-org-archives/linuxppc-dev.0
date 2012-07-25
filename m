Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3BA42C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 20:17:31 +1000 (EST)
Message-ID: <1343211439.3715.46.camel@pasglop>
Subject: Re: Errors related to i2c-powermac on the G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Gusev <ronne@list.ru>
Date: Wed, 25 Jul 2012 20:17:19 +1000
In-Reply-To: <500FA063.4070203@list.ru>
References: <50096F45.80601@list.ru> <500FA063.4070203@list.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-07-25 at 11:29 +0400, Andrey Gusev wrote:
> 20.07.2012 18:46, Andrey Gusev пишет:
> > Hi!
> > I build kernel from git and can see errors in dmesg on boot. 3.4.5 
> > doesn't have such issue.
> > git show | head -n2
> > commit 85efc72a0218335324d358ac479a04c16316fd4d

Ok, so:

> Actual for 3.5.0
> [ 2.841441] i2c /dev entries driver
> [ 2.850155] i2c i2c-0: therm_windtunnel: attach_adapter method is deprecated
> [ 2.858330] i2c i2c-0: Please use another way to instantiate your i2c_client

The above (deprecated methods) have been around for a while, I'm
converting the drivers one by one, windtunnel hasn't yet been
trough the grinder.

However, now that I know I have a tester that will make things easier
(since I don't have the actual HW :-) I'll send you a patch to try out
as soon as I have it sorted.

> [ 2.866457] PowerMac i2c bus pmu 2 registered
> [ 2.874885] i2c i2c-1: therm_windtunnel: attach_adapter method is deprecated
> [ 2.882965] i2c i2c-1: Please use another way to instantiate your i2c_client
> [ 2.890928] PowerMac i2c bus pmu 1 registered
> [ 2.899526] i2c i2c-2: therm_windtunnel: attach_adapter method is deprecated
> [ 2.907463] i2c i2c-2: Please use another way to instantiate your i2c_client
> [ 2.915397] PowerMac i2c bus mac-io 0 registered

Above are the same.

> [ 2.923272] i2c i2c-2: i2c-powermac: invalid reg on 
> /pci@f2000000/mac-io@17/i2c@18000/cereal
> [ 2.931286] i2c i2c-2: i2c-powermac: invalid reg on 
> /pci@f2000000/mac-io@17/i2c@18000/deq
> [ 2.939246] i2c i2c-2: i2c-powermac: invalid reg on 
> /pci@f2000000/mac-io@17/i2c@18000/i2c-modem

Those are mostly harmless, they just tell us that the device-tree is
missing the i2c address for a few things. The only one potentially
worrying is the "deq" one (audio), for which I should have a workaround.

Can you send me a tarball of /proc/device-tree on your machine so I can
check a few things ? I might add code to silence some of those warnings
as they don't actually indicate a problem.

> [ 2.947580] i2c i2c-3: therm_windtunnel: attach_adapter method is deprecated
> [ 2.955559] i2c i2c-3: Please use another way to instantiate your i2c_client
> [ 2.964492] PowerMac i2c bus uni-n 1 registered
> [ 2.972493] i2c i2c-3: i2c-powermac: invalid reg on 
> /uni-n@f8000000/i2c@f8001000/cereal
> [ 2.980977] usb 1-1: new full-speed USB device number 2 using ohci_hcd
> [ 2.989404] i2c i2c-4: therm_windtunnel: attach_adapter method is deprecated
> [ 2.997793] i2c i2c-4: Please use another way to instantiate your i2c_client
> [ 3.007320] DS1775 digital thermometer [@49]
> [ 3.015574] Temp: 33.0 C Hyst: 75.0 C OS: 80.0 C
> [ 3.024410] ADM1030 fan controller [@2c]
> [ 3.032533] PowerMac i2c bus uni-n 0 registered
> [ 3.040575] i2c i2c-4: Failed to register i2c client MAC,adm1030 at 0x2c 
> (-16)

That one probably means that therm_windtunnel grabbed the device before
we could expose it using the "new way"... well I think :-) I'll have to
double check, but does it look like the thermal control is working ? If
it is, then it's probably just that and will naturally disappear as soon
as therm_windtunnel is converted over.

> [ 3.048714] i2c i2c-4: i2c-powermac: Failure to register 
> /uni-n@f8000000/i2c@f8001000/fan@58
> [ 3.057147] i2c i2c-4: Failed to register i2c client MAC,ds1775 at 0x49 
> (-16)
> [ 3.065304] i2c i2c-4: i2c-powermac: Failure to register 
> /uni-n@f8000000/i2c@f8001000/temp-monitor@92
> [ 3.073475] i2c i2c-4: i2c-powermac: invalid reg on 
> /uni-n@f8000000/i2c@f8001000/cereal
> [ 3.082701] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: 
> dm-devel@redhat.com
> 

Cheers,
Ben.
