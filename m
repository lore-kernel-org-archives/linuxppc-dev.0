Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C218A67B18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 00:17:09 +1000 (EST)
Message-ID: <4496B0AA.60909@esd-electronics.com>
Date: Mon, 19 Jun 2006 16:11:54 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: hilichen2000@msn.com
Subject: Re: could linux support to configure the PLB-PCI bridge of PPC440
	into	adapter mode
References: <BAY110-F4002B7619F83B2E70939DEC3860@phx.gbl>
In-Reply-To: <BAY110-F4002B7619F83B2E70939DEC3860@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi chen,

it's not easy to setup the PCI-to-PLB mapping in a generic way so that 
is gets into the kernel. Also it might be too late when the adapter OS 
configures the bridge. The bridge must be setup quickly after reset so 
that the host OS can assign resources to the card. The bootloader of 
your board might be a good place to setup of the adapter stuff. At least 
number and sizes of the needed address spaces should be setup early.
The PLB address can be setup or modified later (e.g. from the target OS).

> hi,now I want to use PPC440GX as PCI adapter card bridge. according to user 
> manual, the PLB-PCI bridge should be configured to Adapter mode. after 
> check some code of PCI of linux, i find the linux only support configuring 
> the PLB-PCI bridge into HOST mode. Is my understanding correct ? if the 
> normal version of linux don't support the adapter mode, could i found the 
> patch?
Probably not.

Matthias
