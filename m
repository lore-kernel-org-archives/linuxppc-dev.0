Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 49CA667A70
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Feb 2005 06:17:45 +1100 (EST)
Date: Sat, 19 Feb 2005 11:17:42 -0800
From: Brad Boyer <flar@allandria.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050219191741.GB2807@pants.nu>
References: <20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
	<f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
	<20050218122009.GK5801@schottelius.org>
	<629f63c4608b762de8bf6f962b6180ef@kernel.crashing.org>
	<20050218175822.GA30616@pants.nu>
	<06fb81c4f23d0b47f8205b433fa6eb21@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06fb81c4f23d0b47f8205b433fa6eb21@kernel.crashing.org>
Cc: Nico Schottelius <nico-linux-ppc@schottelius.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 18, 2005 at 07:10:42PM +0100, Segher Boessenkool wrote:
> ADB has nothing to do with the PMU (well, the PMU emulates an ADB
> device, sort of).
> 
> The Linux kernel multiplexes the /dev/adb device to also serve as
> a channel to the PMU, though.  This ugliness should be fixed, some
> day...

The original PMU chip (in the Macintosh Portable) was used for
several purposes, including being the ADB transceiver. Most of
the revisions of the PMU that have shipped have still driven a
real ADB chain, although that has changed in more recent models.

The /dev/adb mess is a reflection of the mess that is the current
ADB subsystem in the kernel. You can write code in the kernel
that uses adb_request() to send non-adb PMU commands, and it
works due to the way it all works underneath. I was going to work
on it, but I got sidetracked with other issues that made it hard
to debug the various ADB drivers. If noone else gets to it, I
will eventually. I'm just not sure when I will have time.

	Brad Boyer
	flar@allandria.com
