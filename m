Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4378B7CB8
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 06:32:53 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1OJWptJ022127
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 12:32:51 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o1OJWt7K005053
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 13:32:55 -0600 (CST)
Message-ID: <4B857EA1.6030605@freescale.com>
Date: Wed, 24 Feb 2010 13:31:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com> <4B85746F.3020200@freescale.com>
	<4B857AA8.9000208@mlbassoc.com>
In-Reply-To: <4B857AA8.9000208@mlbassoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> On 02/24/2010 11:48 AM, Scott Wood wrote:
>> Gary Thomas wrote:
>>> Does anyone have experience setting up the PCI controller on
>>> the MPC8349? I have it running fine when my system has 128MB
>>> or less of main memory, but when I have 256MB or more, it all
>>> falls apart :-(
>>>
>>> Any indication of the pertinent settings would be appreciated.
>>
>> Check the inbound PCI translation registers, especially PIWARn.
> 
> Yes, I set it to 256MB (the size of RAM).
> I also set PCI_AR0 to a 512MB window (when it's set to 256, I
> get address [segmentation violation] errors when accessing my
> devices that end up at the high end of the logical address space)
> Finally, I set POCMR0 to a 512MB window (corresponding to PCI_AR0)

I don't see what the outbound window size has to do with RAM size... are 
there any other differences between the 128MiB and 256MiB setups?  Same 
exact software?  What happens if you take the 256MiB setup and restrict 
the kernel to using the lower 128MiB ("mem=128M" on the kernel 
bootargs), with no other changes?  What happens if you use a 512MiB 
outbound window on the 128MiB setup?

Is this behavior consistent across multiple boards (i.e. could there be 
a hardware problem)?

Are there any errors indicated in the device, the PCI controller, the 
arbiter, etc?

-Scott
