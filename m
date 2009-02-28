Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 3C22FDDE06
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 07:19:16 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1033273yxb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 12:19:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49A98DFF.9050503@mlbassoc.com>
References: <49A97878.6060308@mlbassoc.com>
	<fa686aa40902281004r5fcb67f4md328d79dd1d5d82c@mail.gmail.com>
	<49A9809D.9000307@mlbassoc.com>
	<fa686aa40902281044l3b910866g7467131db80c87e7@mail.gmail.com>
	<49A98DFF.9050503@mlbassoc.com>
Date: Sat, 28 Feb 2009 13:19:14 -0700
Message-ID: <fa686aa40902281219y463ebabao3445c790798c4bfd@mail.gmail.com>
Subject: Re: OF device mappings
From: Grant Likely <grant.likely@secretlab.ca>
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 28, 2009 at 12:18 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> Grant Likely wrote:
>>> How do I find the platform_device which was created when this
>>> particular of_device was instantiated? =A0I made sure that this code
>>> is run late - after all the of_devices have been handled.
>>
>> Again, there is no platform_device. =A0of_device *is* the device that wa=
s created.
>
> But this doesn't work :-( =A0I also don't understand how you
> can say "there is no platform_device" - they are everywhere,
> corresponding to actual device instances, as the system
> creates them, typically in a driver 'probe' function.

No, "struct device" is everywhere.  "struct platform_device" is a
particular container for a "struct device", just like "struct
of_device" is another kind of container for "struct device".  The
board setup code (stuff in arch/powerpc/platforms/*) often calls into
the of_platform bus to automatically register an of_device for many of
the nodes in the device tree.  platform_devices are typically
explicitly registered by board setup code and has not relationship
whatsoever with the of_platform bus.

> I've tried both ways. =A0If I look up the of_platform node and
> then pass the 'dev' structure to the DSA driver, it doesn't work.
> If I look up the actual device instance from the platform_bus
> and pass that to the driver, it does.
>
> How do I get to the proper 'dev' structure which will make the
> DSA driver work?
>
> More details - the DSA driver is expecting to get the 'dev'
> structure pointer which was created in the gianfar driver,
> =A0static int gfar_probe(struct platform_device *pdev)
> namely '&pdev->dev' -- this works.

Ah, it becomes clear now.  I seen that the gianfar driver has only
recently been converted from a platform bus driver to an of_platform
bus driver (see git commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4).
It will be released as part of 2.6.29.

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3Db31a1d8b41513b96e9c7ec2f68c5734cef0b26a4

So, for the kernel version you're using, the
of_find_device_by_phandle() call will never work.  It will for 2.6.29
and beyond.  Currently, there is code in arch/powerpc/sysdev/fsl_soc.c
which creates the platform_device which you're looking for.  Look into
that code to figure out how to get a pointer to that platform_device.
you can probably iterate over the platform bus (hint: look at
bus_find_device() and friends) to find it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
