Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 401FB67A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 10:12:31 +1100 (EST)
Date: Thu, 23 Mar 2006 17:11:29 -0600
To: Haren Myneni <hbabu@us.ibm.com>
Subject: Re: [PATCH] kdump: Fix for machine checkstop on DMA fault
Message-ID: <20060323231129.GD5538@pb15.lixom.net>
References: <20060323201258.GA5538@pb15.lixom.net>
	<OF587D6284.5AECD8A6-ON8725713A.007B0F39-8825713A.007E8BA3@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF587D6284.5AECD8A6-ON8725713A.007B0F39-8825713A.007E8BA3@us.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Milton Miller <miltonm@bga.com>, Michael Ellerman <michael@ellerman.id.au>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olaf Hering <olh@suse.de>, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Mar 23, 2006 at 03:06:22PM -0800, Haren Myneni wrote:

> On JS21, immediately after the tce entries are initialized, the machine 
> checkstops with an error "Internal CPU 1 Fault Error" on bladecenter MM. 
> If we do not initialize tce entries for crash kernel, allows the ongoing 
> DMA continue to the old kernel memory. I though that, ongoing DMA will be 

The problem isn't when DMA is going to the old kernel memory. The
problem is when that TCE entry gets reused by the crashdump kernel, and
some other memory gets overwritten instead.

> stopped when the device reset happens later by the drivers. I think, some 
> hardening is already included in some drivers to take care of this 
> behavior. I might be wrong. So far, I had e100 issue after testing on p5, 

What assures that the crash kernel has drivers for all hardware in the
system? If there's no driver, what will then be used to quiesce the
device?

> p4, js20 and js21. Probably, it could be lucky scenario.
> So, will be keeping the same change (posted here) plus your suggestion. 
> Right? Can we apply same approach even for power-4?

What you have now might be a 99%-of-the-time-it-works solution, but is
that really good enough?

The last things you want from a crash kernel is:

1. Have it crash on it's own because of something getting overwritten
(small chance, since most mappings are probably for writing out data
for later analysis)

or:

2. Have it write corrupted data to the crash dump. This makes it more or
less useless, since you can't trust what it wrote out: Did the machine
go down because of the memory corruption you're spotting, or did that
happen after the crash, while dumping it, etc?

Either way, a proper solution is needed, not a 99% one.


-Olof
