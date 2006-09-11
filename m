Return-Path: <olaf@ibook.aepfle.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 976B067B62
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 02:01:21 +1000 (EST)
Date: Mon, 11 Sep 2006 17:52:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Daniel Quinlan <quinlan@pathname.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060911155239.GA25534@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060911115354.GA23884@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 11, Olaf Hering wrote:

> 
> The ppc32 common config runs also on PReP/CHRP, which uses PC style IO
> devices.  The probing is bogus, it crashes or floods dmesg.
> 
> ppc can boot one single binary on prep, chrp and pmac boards.
> ppc64 can boot one single binary on pseries and G5 boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash:

drivers/input/touchscreen/mk712.c pokes at 0x262 and other IO ports.
A comment in the driver suggests that it is only used on Gateway
computers. Should the driver be X86 only?
