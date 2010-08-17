Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 30E89B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 19:26:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Date: Tue, 17 Aug 2010 09:25:55 +0000
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008162159.39734.arnd@arndb.de>
	<20100817083216.GA3330@riccoc20.at.omicron.at>
In-Reply-To: <20100817083216.GA3330@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008170925.55592.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Rodolfo Giometti <giometti@linux.it>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 17 August 2010, Richard Cochran wrote:
> > Why did you not want to add syscalls? Adding ioctls instead of syscalls
> > does not make the interface better, just less visible.
> 
> I bet that, had I posted patch set with new syscalls, someone would
> have said, "You are adding new syscalls. Can't you just use a char
> device instead!"

Very possible, but after considering both options, I think we would
still end up with the same conclusion.
 
> If you add syscalls and introduce CLOCK_PTP, then you add it to
> everyone's kernel, even those people who never heard of PTP. A char
> device has the advantage that can it be simply ignored.

It's a matter of perspective whether you consider this an advantage
or disadvantage. I would expect that since you are trying to get support
for PTP into the kernel, you'd be happy for people to know about it and
use your code ;-).

> Also, a syscall has got to have the right form from the very beginning.
> If the next generation of PTP hardware looks very different, then it is not
> that much of a crime to change an ioctl interface, provided it has
> versioning.

No, that's just a myth. The rules for ABI stability are pretty much the
same. We try hard to avoid ever changing an existing ABI, for both
syscalls and ioctl. In either case, if you get it wrong, you have to support
the old interface and create a new syscall or ioctl command.
As mentioned, versioning does not solve this, it just adds another
indirection (which we try to avoid).

One difference is that more people take a look at your code when you suggest
a new syscall, so the chances of getting it right in the first upstream
version are higher.
Another difference is that we generally use ioctl for devices that can
be enumerated, while syscalls are for system services that are not tied to
a specific device. This argument works both ways for PTP IMHO: On the one
hand you want to have a reliable clock that you can use without knowing
where it comes from, on the other you might have multiple PTP sources that
you need to differentiate.

	Arnd
