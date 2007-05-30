Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91EEFDDFF9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 12:40:46 +1000 (EST)
In-Reply-To: <1180492466.12577.6.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Tue, 29 May 2007 21:40:38 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 9:34 PM, Zang Roy-r61911 wrote:

> On Wed, 2007-05-30 at 03:29, Kumar Gala wrote:
>> On May 28, 2007, at 9:36 PM, Zang Roy-r61911 wrote:
>>
>>> Fix the e500 v2 core reset bug.
>>> For e500 v2 core, a new reset control register is added to
>>> reset the core.
>>> On 85xx CDS board with e500 v2 core, normal reboot code will
>>> induce DDR block in u-boot. This patch fixes this bug. It is
>>> also tested on legacy e500 v1 core.
>>
>> what happens on an e500 based 85xx system?
>
> Without this patch on MPC8548CDS board, after key in "reboot" command,
> the u-boot will hang at DDR init. See the following log without this
> patch:

Sorry I meant what happens on a e500 v1 based 85xx system w/this patch.

- k

>
> --- log start ---
> ~ # uname -a
> Linux mpc8548cds 2.6.22-rc2-g843b8c89-dirty #5 Tue May 29 16:37:21 CST
> 2007 ppc
> unknown
> ~ # reboot
> ~ # Stopping the boa webserver:
> Stopping the port mapper:
> Stopping inetd:
> Syncing hardware clock to system time
> hwclock: Could not set the RTC time: Invalid argument
> Unmounting filesystems
> umount: Cannot open /proc/mounts
> The system is going down NOW !!
> Sending SIGTERM to all processes.
> Please stand by while rebooting the system.
> Restarting system.
>
>
> U-Boot 1.1.6-gcd32691c-dirty (Apr  2 2007 - 17:42:01)
>
> CPU:   8548_E, Version: 2.0, (0x80390020)
> Core:  E500, Version: 2.0, (0x80210020)
> Clock Configuration:
>        CPU: 990 MHz, CCB: 396 MHz,
>        DDR: 198 MHz, LBC:  49 MHz
> L1:    D-cache 32 kB enabled
>        I-cache 32 kB enabled
> Board: CDS Version 0x13, PCI Slot 1
> CPU Board Revision 114.121 (0x7279)
>     PCI1: 32 bit, 33 MHz, async
>     PCI2: disabled
> I2C:   ready
> DRAM:  Initializing
>     SDRAM: 64 MB
>     DDR: 256 MB
>
> --- log end --
>
> This patch has been tested on 8548/55 CDS board and 8540/60 ADS board.
>
>> I'm not terrible happy with blindly writing to rstcr.
>>
> I can understand you.
> But I jut want to make things simple and workable.
> Any idea?

one idea would be for us to add a property on the soc node.   
Something like has-rstcr or something similar in a guts node?

- k
