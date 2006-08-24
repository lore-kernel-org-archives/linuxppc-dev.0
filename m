Return-Path: <mporter@embeddedalley.com>
Received: from matthew-porters-computer.local (cpe-088197.static.wadsnet.net
	[65.114.88.197]) by ozlabs.org (Postfix) with ESMTP id 5028867CD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 23:27:35 +1000 (EST)
Date: Thu, 24 Aug 2006 08:25:03 -0400
From: Matt Porter <mporter@embeddedalley.com>
To: alva <vows_siu@yahoo.com.hk>
Subject: Re: ioremap() fails for >64 MB
Message-ID: <20060824122503.GA23291@matthew-porters-computer.local>
References: <1156327238.6735.9.camel@lamorak.int.avalon.com.au>
	<000001c6c728$9aeeac30$8500a8c0@dc.roysiu.servebbs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c6c728$9aeeac30$8500a8c0@dc.roysiu.servebbs.com>
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

On Thu, Aug 24, 2006 at 10:54:23AM +0800, alva wrote:
> I think 64MB limitation of ioremap() is due to the kernel's page size.
> When compiling kernel, it has an option to choose the memory page size
> which is default 64MB. To use memory greater than 64MB, there is two
> methods. One is to make the kernel's page size larger as Phil Nitschke
> said. Another is to modify ioremap() a little bit --- just make it use
> another file for "mmap" while larger than 64MB. Since the central
> concept of linux is file-based, I think more files are not harmful that
> only waste a little bit inode structure. And it is much more feasible
> that one can choose to use file in memory or harddisk or mounted device
> harddisk/memory ... ...

This is incorrect. There is no "64MB page size". Unless you are ioremapping
a region overed by a BAT/CAM, the mapping is composed of default 4KB PTEs.
The reason it fails is because of what I explained earlier. Just wanted to
clarify so nobody was confused by these statements. We can map arbitrary
sizes to the limit of what the kernel virtual address space settings
allow. This varies from platform to platform.

-Matt
