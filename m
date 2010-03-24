Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2409B7CFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 21:50:41 +1100 (EST)
Subject: Re: Booting headless PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
References: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 21:50:15 +1100
Message-ID: <1269427815.8599.226.camel@pasglop>
Mime-Version: 1.0
Cc: Tony Breeds <tonyb@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-03-24 at 11:32 +0100, Romain Goyet wrote:
> Hi there,
> 
> 
>   Here's a summary about "how to boot a PowerMac G5 without a screen
> attached". As many people have noticed, default yaboot install won't
> boot unless a screen is attached.

CC'ing Tony who is the latest victim of yaboot maintainership...

>   Actually, the workaround is really simple. Thing is, that's the
> "ofboot.b" script that messes things up. This script is a "bridge",
> that actually either starts yaboot or let you boot off of a CD. I
> don't know what's the point, since OpenFirmware already lets you boot
> off of the CD by pressing C on boot…
> 
>   So basically, to boot headless, all you have to do is to tell
> OpenFirmware to boot straight off the yaboot binary, and to skip the
> ofboot.b
> Just boot into OpenFirmware (Command-Option-O-F), and type :
> setenv boot-device hd:2,yaboot (where 2 is the number of the partition
> containing yaboot)
> boot
> 
> And here you go, you can unplug that useless monitor :-)

The root of the problem is that Apple OF will not open an stdout for you
on some machines if you don't enter OF manually, so yaboot text never
shows up. This was somewhat worked around by the ofboot.b script but
indeed, it seems to fail to check that there's a display to open before
actually opening it, which cause the failure you are hitting.

Maybe we can try to make the script a bit smarter to detect that there's
nothing there. Hard to tell, the arcanes of Apple OF are quite obscure.

But at least, I think ybin could grow a config option to tell it not to
install ofboot.b or at least install a variant that won't suck when
there is no display attached.

Cheers,
Ben.

> References :
> http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOOT.html
> http://grub.enbug.org/TestingOnPowerPC
> 
> By the way, as of writing this, grub2 on PPC from debian gives a "out
> of memory" issue. Known bug.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
