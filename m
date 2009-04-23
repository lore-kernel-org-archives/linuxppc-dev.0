Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 73135DE144
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 08:28:07 +1000 (EST)
Message-ID: <49F0EB6A.40000@mlbassoc.com>
Date: Thu, 23 Apr 2009 16:27:54 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>	<49EE5021.4020703@mlbassoc.com>	<306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>	<49EE5A80.4030209@mlbassoc.com>	<B869D8DC-2A3B-4B53-8BFD-15D403CE20D4@kernel.crashing.org>	<49F07A15.9010006@mlbassoc.com>
	<97DF2A19-563D-404A-AD3D-039D5989E489@kernel.crashing.org>
In-Reply-To: <97DF2A19-563D-404A-AD3D-039D5989E489@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 23, 2009, at 9:24 AM, Gary Thomas wrote:
> 
>> I have found the culprit - in arch/powerpc/kernel/pci_32.c
>>
>> static void
>> fixup_hide_host_resource_fsl(struct pci_dev *dev)
>> {
>>     int i, class = dev->class >> 8;
>>
>> #if 0
>>     if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
>>          class == PCI_CLASS_BRIDGE_OTHER) &&
>> #else
>>        if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
>> #endif
>>         (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
>>         (dev->bus->parent == NULL)) {
>>         for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>>             dev->resource[i].start = 0;
>>             dev->resource[i].end = 0;
>>             dev->resource[i].flags = 0;
>>         }
>>     }
>> }
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID,
>> fixup_hide_host_resource_fsl);
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
>> fixup_hide_host_resource_fsl);
>>
>> This function is now (the #if 0 case is in 2.6.28) tossing out
>> the memory resources used by the PCI bridge itself.  This makes
>> everything fall over, at least on my 834x platform.
>>
>> This change was applied 2008-10-08, but it seems incorrect on the 834x.
> 
> Its not.  The PCI subsystem shouldn't be allocating or seeing the PHBs
> resources.
> 
>>> Are you using u-boot to boot?  If so is the board port public?
>>
>> My systems use RedBoot (I'm the original author of RedBoot, so one would
>> expect that).  At this moment, the code isn't public, sorry.
> 
> Ok.  Not sure if RedBoot has a simple memory dump command, but if you
> can dump the IMMR registers for PCI (0x8400 - IOS and 0x8500 - PCI1). 
> (I'm assuming PCI1 is the one you are using).  From IOS I wanted the

I don't think any of this matters.  It turns out that even
the 2.6.26 kernel fails on an identical board with a newer
revision of the 8347 chip.  I'm sure that the problem is
that the Coral-P fails when mapped to 0 (PCI relative).

I couldn't find another reliable way to get the Coral-P assigned
an address other than 0, so I'm happy accepting the work around
of allowing the kernel to map those windows, even if it's not
necessary.

For completeness, here are the values you asked for:
pcilawbar0     : 0xc0000000  -1073741824
pcilawar       : 0x8000001b  -2147483621
pcilawbar1     : 0xb8000000  -1207959552
pcilawar1      : 0x80000013  -2147483629

8347>md 0xff008400
ff008400 : 00000000 00000000 000c0000 00000000  ................
ff008410 : 800f0000 00000000 00000000 00000000  ................
ff008420 : 000b8000 00000000 c00fff00 00000000  ................
ff008430 : 00000000 00000000 00000000 00000000  ................
ff008440 : 00000000 00000000 00000000 00000000  ................
ff008450 : 00000000 00000000 00000000 00000000  ................
ff008460 : 00000000 00000000 00000000 00000000  ................
ff008470 : 00000000 00000000 00000000 00000000  ................
ff008480 : 00000000 00000000 00000000 00000000  ................
ff008490 : 00000000 00000000 00000000 00000000  ................
ff0084a0 : 00000000 00000000 00000000 00000000  ................
ff0084b0 : 00000000 00000000 00000000 00000000  ................
ff0084c0 : 00000000 00000000 00000000 00000000  ................
ff0084d0 : 00000000 00000000 00000000 00000000  ................
ff0084e0 : 00000000 00000000 00000000 00000000  ................
ff0084f0 : 00000001 00010006 00000000 00000000  ................

8347>md 0xff008500
ff008500 : 00000000 00000000 00000000 00000000  ................
ff008510 : 00000000 00000000 00000000 00000000  ................
ff008520 : 00000001 00000000 00000001 00000000  ................
ff008530 : 00000000 00000000 00000000 00000000  ................
ff008540 : 00000000 00000000 00000000 00000000  ................
ff008550 : 00000000 00000000 00000000 00000000  ................
ff008560 : a005501a 00000000 00000000 00000000  ..P.............
ff008570 : 00000000 00000000 00000000 00000000  ................
ff008580 : 00000000 00000000 00000000 00000000  ................
ff008590 : 00000000 00000000 00000000 00000000  ................
ff0085a0 : 00000000 00000000 00000000 00000000  ................
ff0085b0 : 00000000 00000000 00000000 00000000  ................
ff0085c0 : 00000000 00000000 00000000 00000000  ................
ff0085d0 : 00000000 00000000 00000000 00000000  ................
ff0085e0 : 00000000 00000000 00000000 00000000  ................
ff0085f0 : 00000000 00000000 00000000 00000000  ................

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
