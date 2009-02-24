Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id BEACFDDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 13:12:28 +1100 (EST)
Received: by gxk1 with SMTP id 1so6083291gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 18:12:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1c641bc80902231611j57d53abcx56b32439f26cdf8@mail.gmail.com>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40559@mailsvr>
	<1c641bc80902231611j57d53abcx56b32439f26cdf8@mail.gmail.com>
Date: Mon, 23 Feb 2009 19:12:26 -0700
Message-ID: <fa686aa40902231812v7544b728te019e70d16c521e1@mail.gmail.com>
Subject: Re: soc vs localbus for flash in device tree
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Bergandi <mbergandi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Dushara Jayasinghe <DusharaJ@optiscan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2009 at 5:11 PM, Michael Bergandi <mbergandi@gmail.com> wrote:
>>
>> I'm working on the kernel version Linux-2.6.29-rc5 with U-Boot
>> 1.2.0-g88e21e7b-dirty.
>
> I recommend you use a more current version of U-Boot. That one is quite old.
>
>> Does the flash node HAVE to be within a localbus node or can it reside
>> within the soc node? I've been basing my work on mpc834x_mds.dts
>> And hence haven't defined a localbus node.
>
> I think it can be in either, but the most common place I've seen is in the
> soc node.

If flash hangs off the local bus, then it belongs in the local bus
node.  It doesn't make any sense to put it in the SoC node because the
SoC node describes the internal memory mapped devices.  The local bus
node should have a ranges property that describes the translation
between physical address and individual chip selects.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
