Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 40649DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 19:03:50 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: Problems with PCI-E devices not being detected with switch
Date: Thu, 16 Oct 2008 10:03:31 +0200
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
In-Reply-To: <1224134422.8157.549.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810161003.31801.sr@denx.de>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, Victor Gallardo <vgallardo@amcc.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 October 2008, Benjamin Herrenschmidt wrote:
> > pci 0001:02:1c.0: ignoring class 5d01 (doesn't match header type 02)
> > pci 0001:02:1d.0: unknown header type 41, ignoring device
> > pci 0001:02:1e.0: unknown header type 03, ignoring device
> > pci 0001:02:1f.0: unknown header type 41, ignoring device
>
> Stefan, do you reckon it could be that we aren't leaving enough time
> for the things behind the switch to initialize ? Or could there be
> a subtle kernel bug here ? It looks to me that config space
> access behind the switch is broken.

Yes, this could be possible. We (Ayman) should at least test with the delay as 
you mentioned below to see if this helps.

> Ayman, can you try adding a long delay (such as msleep(5000), ie 5s)
> at the beginning of pcibios_init() in arch/powerpc/kernel/pci_32.c ?
> This will add 5s delay between the init/reset of the port and the
> probing by linux. Do that help ?
>
> Stefan, shouldn't we find a nice way to avoid the whole port reset and
> reconfiguration of the HW also when uboot already did a good enough job,
> maybe via some device-tree property ? It would also significantly speed
> up boot times.

Doing this unconditionally is not a good idea since we could have an old 
(buggy) firmware which didn't configure the PCIe controller correctly. But I 
really like your idea with the device-tree property to optionally skip this 
re-configuration. Now we only need to find some "volunteer" to do this 
job... ;)

Best regards,
Stefan
