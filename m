Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDB8967A7D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2005 15:00:58 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jed5tuqlp1.fsf@sykes.suse.de>
References: <jed5tuqlp1.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 14:59:48 +1100
Message-Id: <1111377588.3835.258.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Wakeup broken on iBook G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-03-20 at 18:19 +0100, Andreas Schwab wrote:
> Ever since the massive changes to the radeonfb pm code I've never been
> able to get a working wakeup on my iBook G3.  The screen keeps blank after
> wakeup, I hear the cdrom drive being reset, and then the system crashes
> hard.

What video chip is this ? And what CPU ? Are you sure it's the radeonfb
patch ? There have been other changes to the system PM code
approximately at the same time. The "massive" PM change didn't really
change what was done to the vidoe chip on older models (mostly _added_
new code, totally separate, for new models). I suspect for example a
problem with the cache flush code in pmac_cache.S on some G3 CPUs ...

There is also an old problem with AGP and sleep that is coming & going
lately. Can you check if it works if you never go to X ? (That is boot
in console mode, do not ever launch X, launching X and quitting X breaks
the test I want you to do, then suspend/resume).

Ben.
