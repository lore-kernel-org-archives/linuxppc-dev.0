Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95A042BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 09:22:30 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Armando Di Cianno <fafhrd@gentoo.org>
In-Reply-To: <fc01eab7ddb069d0da7030a94b467f8f@nephilim.localdomain>
References: <fc01eab7ddb069d0da7030a94b467f8f@nephilim.localdomain>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 09:20:53 +1100
Message-Id: <1101162053.13597.136.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Test patch for sleep on Aluminium PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Does this patch do, or should have to do, anything special to 
> "normalize" the mounted filesystems before sleep?  When I patched the 
> kernel first, I was running XFS, and of course that is notorious for 
> file corruptions with power abnormalities on a system.  I started to 
> get really odd file corruptions, where 'ls file' would should the 
> file, but 'ls -l file' would not.

I though xfs was supposed to be journaled ? Yes, the sleep code will
sync all disks before sleep. You should update to patch #4 though, there
have been number of problems fixes since then.

> I switched to ReiserFS (v3) now, and have seen symptoms like this 
> problem caused appear once more (but not to the extent that XFS showed 
> [where I thought my system was disintegrating before my eyes]).

Hrm... reiserfs is evil, ask any sane kernel hacker :) Why not ext3 ?

> Is there something that was overlooked in the patch, or something that 
> I'm overlooking that needs to be done?
> 
> If filesystems do not need to be "normalized" at sleep, what 
> filesystems are known to work?  (Hesistant about ext3, as it's quite 
> slow, imho, but I'll go that route if needed, I suppose).

It's not that slow ...

Ben.
