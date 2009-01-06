Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 44EDCDE124
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 09:22:04 +1100 (EST)
Message-ID: <4963D989.6090909@harris.com>
Date: Tue, 06 Jan 2009 17:22:01 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
References: <496268E7.5090907@harris.com>	 <1231190318.14860.17.camel@pasglop>
	<49627D33.8030605@harris.com>	 <1231223634.14860.18.camel@pasglop>
	<4963C1DE.6020007@harris.com>	 <4963CF68.3040808@harris.com>
	<1231279340.14860.31.camel@pasglop>
In-Reply-To: <1231279340.14860.31.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-01-06 at 16:38 -0500, Steven A. Falco wrote:
>> But this has no effect on Linux.  So, I also changed the sequoia.dts
>> to make the outbound range larger, and now Linux is happy too.  I now
>> have ranges for the device:
>>
>> # cat 0000:01:00.0/resource
>> 0x0000000190000000 0x000000019007ffff 0x0000000000020200
>> 0x0000000180000000 0x000000018fffffff 0x0000000000020200
> 
> So your problem is fixed ? I didn't have a chance yet to look at your
> logs, but it could just have been that you didn't have enough space
> allocated to PCI for your card...
> 
> Cheers,
> Ben.

That appears to be the problem.  Apparently the PCI/PCIe bridge requests
in excess of 256 MB of space, but the default in the sequoia .dts file is
"only" for 256 MB, so the request fails.

I'm not sure if this should be changed in the mainline.  This card works
out of the box when used with a generic x86 PC, but not when used with
a sequoia.  But, maybe it's just me climbing the PPC learning curve.

	Steve
