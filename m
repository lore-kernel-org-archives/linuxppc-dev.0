Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id A8436DF10F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jun 2008 04:09:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS
	chip
Date: Thu, 26 Jun 2008 11:09:43 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D70289E4D8@corpexc01.corp.networkrobots.com>
In-Reply-To: <74ADD192-AAA8-4105-9E78-AC44D84444DC@kernel.crashing.org>
References: <mailman.3089.1214426104.4744.linuxppc-embedded@ozlabs.org>
	<D83235F0F3C86D4D889D8B9A0DA8C6D70289E410@corpexc01.corp.networkrobots.com>
	<74ADD192-AAA8-4105-9E78-AC44D84444DC@kernel.crashing.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,

We are using it onboard, not as add-on card. But I am sure there must be
PCI-E to SAS PCI cards based on LSI SAS controllers.

I just googled....
http://cgi.ebay.com/LSI-LSISAS3080X-R-8-Port-3Gb-s-SAS-PCI-X-Host-Bus-Ad
apt_W0QQitemZ220243588314QQihZ012QQcategoryZ90715QQcmdZViewItem?refid=3Ds=
t
ore

- Siva


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Thursday, June 26, 2008 6:37 AM
To: Siva Prasad
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068
SAS chip

Is the LSI chipset something you guys have on an add-on card =20
(something we can put into a reference board) or is hard wired into =20
your boards?

If its an add on card a pointer to one would be appreciated.

- k

On Jun 25, 2008, at 5:20 PM, Siva Prasad wrote:

> I am also having problems with PCI-E device LSI 1064E on 2.6.24-rc6
> kernel. This is running on 8641D processor.
>
> I can see the device, access the config space, but seems access from
> device to memory is not working. Same device (same exact hardware) =20
> works
> fine for 2.6.15 kernel.
>
> - Siva
>
>
> -----Original Message-----
>
> Date: Wed, 25 Jun 2008 10:30:35 -0500
> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI
> 	1068 SAS	chip
> To: Vince Asbridge <vasbridge@sanblaze.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <D7261455-1BB8-44E7-940D-84C207A40CA7@kernel.crashing.org>
> Content-Type: text/plain; charset=3DWINDOWS-1252; format=3Dflowed;
> 	delsp=3Dyes
>
>
> On Jun 24, 2008, at 10:51 AM, Vince Asbridge wrote:
>
>> All,
>>
>> I'm new to this mailing list, but have not had any luck finding
>> information on this issue.
>>
>> Please be kind if I break the forum rules on my first post.
>>
>> We recently tried to upgrade our Freescale CDS 8548 look-alike
>> module (code name ATCA1000) from the 2.6.11 based BSP to the 2.6.23
>> based BSP.
>>
>> The upgrade went fairly smoothly, until we tried using SOME pci-e
>> devices (some work fine, some don't show up to lspci).
>>
>> LSI pci-e controllers no longer show up at all!
>>
>> We see the ixgbe (intel 10G), SiliconImage SATA controller but do
>> not see LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).
>>
>> We're guessing it's a resource issue behind the bridge, because the
>> LSI devices try to allocate 1 - 3M behind the bridge, but we can't
>> find the bug, or where we would debug such an issue.
>>
>> The devices seem to "train" correctly, because we have an LED on the
>> pci-e switch (PLX 8 port pci-e switch), and it's ON indicating pci-e
>> link between the bridge and the 1068 device).
>>
>> We're totally at a loss as to why this always worked on the 2.6.11
>> kernel but doesn?t work on 2.6.23.
>>
>> Using lspci, the LSI adapters do not show up in the list at all, as
>> though they are not plugged into the system.
>>
>> Is there something that needs to be done with respect to PCI-E
>> devices that is new in the 2.6.23 based BSP that did not need to be
>> done in the 2.6.11 based kit?  For example, are pci resources
>> allocated by a different piece of code, that may have some issue
>> allocating resources for the LSI adapters?
>>
>>
>>
> Can you tree 2.6.25?  There are some fixes in that kernel related to
> PCIe support:
>
> [POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx
>
> However, its odd that lspci doesn't even show the device.  Are you
> using u-boot?  if so what version? and does u-boot see the LSI?
>
> - k
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
