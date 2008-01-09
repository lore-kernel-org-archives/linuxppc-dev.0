Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 13A21DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:27:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so109291uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:26:59 -0800 (PST)
Message-ID: <4784F695.7050507@genesi-usa.com>
Date: Wed, 09 Jan 2008 16:30:13 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<20080109153511.GA5086@powerlinux.fr>
In-Reply-To: <20080109153511.GA5086@powerlinux.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sven Luther wrote:
> 
> Let's just fix this in the kernel, until we get a fixed efika firmware,
> then we can drop it easily enough. But until this happens, we need to be
> able to boot the kernel without any extra work on the users part.

That is exactly why I don't like the idea. Yes, it makes it easier for users
and easier for distro managers to say "it supports the Efika" but it makes
the Forth fixing, and any further firmware development (ignore the lack of
releases, it means nothing) much harder.

It should not be a function of Linux to fix firmware problems. This was
the FIRM line by Ben, Segher and the rest of the LinuxPPC guys when we
released the Efika - fix the firmware, not Linux, don't hack drivers, don't
rely on fixups. I disagreed at the time due to the urgency to release the
board, but now, we have the luxury of not having to rush it through to get
a product on sale.

I would much rather the Linux kernel did not implement fixups for firmware
which we can fix. The phy-handle part that Olaf specifies in his patch
can be added by a user to nvramrc, BY HAND, in around 10 lines of Forth
code. Those 6 lines are in the efika.forth script, and in fact Olaf is
simply running "interpret" over an encoded version of this! (I say 10 lines
because the efika.forth script is needlessly verbose for the purpose of
being readable by humans).

It is not scary or difficult to do this if you need ethernet to work, and
not beyond the scope of the installation documentation or an Efika wiki
page. The Forth stuff will work fine for *all* operating systems.

If you don't like not having your Linux distro or a default kernel working
on our default firmware, PLEASE FEEL FREE TO BLAME US. PROFUSELY.

Alternatively I'd love to work with people to create a comprehensive
pre-update binary fix (not a boot loader but an installer) for the Forth
script so that users can run it before they boot any distro disk, and then
the kernel on the CD, the kernel in the distro repositories, will not have
the burden of tracking firmware releases, and the Linux team will not have
the burden of maintaining tiny fixes for things which may always be fixed.

After all, there is no profit or benefit in fixing something 5 times just
in case the user only has 4 of them installed.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
