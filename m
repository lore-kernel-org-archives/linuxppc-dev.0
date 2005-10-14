Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AF516856F
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2005 08:00:18 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20051014123823.GA9477@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
Content-Type: text/plain
Date: Sat, 15 Oct 2005 07:58:25 +1000
Message-Id: <1129327105.21765.39.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-10-14 at 14:38 +0200, Joerg Dorchain wrote:
> Hi,
> 
> after upgrading to a vanilla 2.6.13 kernel (from 2.6.12) there seems to
> be a problem with the framebuffer driver I use for my ibook. The display
> statz at the opnpic message, and after a while the machine reboot (looks
> like panic().
> 
> Can someone confirm? Or better, point me to a patch ;-)?
> 
> For given reason, what is the common method to debug crashes before the
> display is working?

This looks like a bug that was introduced by linus in 2.6.13 and that I
_think_ should be fixed in the stable series, so if you get 2.6.13.x (x
= latest stable release) it should work.

Usually, to debug those crashes, I'm adding a hack to kernel/printk.c to
call btext_drawstring() (with some test to make sure to do that not too
early, typically only after setup_arch has been called).

Ben.
