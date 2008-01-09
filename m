Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id AFCBFDDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:40:47 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so119654uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 09:40:45 -0800 (PST)
Message-ID: <478507E0.80109@genesi-usa.com>
Date: Wed, 09 Jan 2008 17:44:00 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
	<4784FCB1.3010509@genesi-usa.com>
	<20080109171849.GC6789@powerlinux.fr>
In-Reply-To: <20080109171849.GC6789@powerlinux.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sven Luther wrote:

> This is crazy, and not future proof. The way Grant did it, checking for
> the existence of the node before creating is enough for any reasonable
> upgrade to the firmware.
> 
> If future firmware will break with this, then they will break other
> stuff anyway, and a new patch is needed.

In other words, Grant's method is crazy and not future-proof, too.

I don't see the difference, Sven, and this demonstrates entirely

>> Just make sure it's less than.. let's say, a certain version of efika.forth,
>> and I will roll a version which has a higher version and some extra features
>> like CAN/I2C exposure.
>>
>> If you run efika.forth it will not touch the device tree. If you don't, it
>> will add the small amount of patches. Add a huge comment that this hunk of
>> code should be scheduled for deletion at some later date. Put a Kconfig
>> around it so it can be taken out, even, at distro option.
> 
> Have you not read Grant's code ? It create the nodes only if they are
> not existent already.

What if they ARE existant under other names, you will have two ethernet-phy
in the system, maybe with the same name, and this is stupid. What if it adds
the wrong properties if we work out something is wrong somewhere?

Linux prom_init must not be a moving target for firmware development - it is
the hardest thing to replace (it is not like loading and unloading a module)
and it may in fact be polluting valid device trees REGARDLESS of any checks
you might make. You cannot make Linux try and PREDICT how the device tree
looks based on arbitrary name strings, because Linux device tree usage does
not comply with the IEEE 1275-1994 definition of device tree properties.

Grant's patch should look for a compatible property with "ethernet-phy" in
it, check for phy-handle in the ethernet node, make sure that a node very
similar to mdio does not already exist, etc, it is going into a screen of
code to do it comprehensively and future proof.

Just don't do it at all. The burden is on Genesi. So, it's difficult right
now, and hard for users, so what? That's OUR problem, I dare say today it
is MY problem. I do not want this to become a LINUX problem in the future
when a new board comes out that is Efika-compatible, requiring patch
removal, reshuffling, compliance testing etc.

You do realise any new firmware with this kernel needs to work, regardless
of the patch being present, in order to be validated? We can't ship an
Efika board with a firmware which actively breaks because of a Linux
kernel patch for older boards and some ancient bad decision, and saying
"to use a new Efika you must use a brand new Linux kernel" is the kind of
insanity in embedded development which made us choose SmartFirmware over
U-Boot and FDT in the first place..

I am not happy that we are being dragged into this model of playing
"first to mainline" with arbitrary snippets of code which do NOT improve
things in the long term.


-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
