Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5FD4ADDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 06:11:38 +1000 (EST)
Message-ID: <47166860.6000705@ru.mvista.com>
Date: Wed, 17 Oct 2007 23:54:08 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: loading NOR flash from DT
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
In-Reply-To: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Sebastian Siewior wrote:

> I have here a MPC8544 DS board with NOR flash on it and Kumar's git
> tree. I'm trying to detect this flash with the physmap_of module. I
> added a nor_flash block (I used sequoia.dts as an example) into my
> device tree on the same level as soc8544 or memory (or between them).

    I guess you were using quite recent kernel version where the file that 
published the node (arch/powerpc/sysdev/rom.c) had been already dremoved and 
and the platform code still didn't publish the on-board devices via 
of_platform_bus_probe().

> After modprobing physmap_of nothing happend. Then I tried to make a tree
> with plb -> opb -> ebc and finally nor_flash but still nothing changed.

    Add either of_platform_bus_probe() or platform_device_create() to 
arch/powerpc/platforms/85xx/85xx_ds.c.

> Is there a user space dependency or did I just edit my device tree the
> wrong way? Any hints are welcome :)

    You haven't cited your node, so no conclusion acn be made about it...

WBR, Sergei
