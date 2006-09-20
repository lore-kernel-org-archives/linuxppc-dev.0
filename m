Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.9])
	by ozlabs.org (Postfix) with ESMTP id B542967A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 22:38:29 +1000 (EST)
Subject: Re: linux-2.6 system ACE driver - need help
From: Jeff Angielski <jeff@theptrgroup.com>
To: agnel juni <junijoseph@yahoo.co.in>
In-Reply-To: <20060919224349.25812.qmail@web8408.mail.in.yahoo.com>
References: <20060919224349.25812.qmail@web8408.mail.in.yahoo.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 08:38:45 -0400
Message-Id: <1158755925.8564.19.camel@sumo-jaa>
Mime-Version: 1.0
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

On Tue, 2006-09-19 at 23:43 +0100, agnel juni wrote:

> First, I would like to know if the driver tested in interrupt mode.

Does it work for you in polling mode?  If not, you probably have a
problem with the way you are accessing the system ace - cache,
endianess, byte alignment, etc.  If it does work in polling, the usual
suspects are interrupt masking errors or some low level problems with
your IRQ signals.  Since you know the size of a sector and the size of
the sysace buffers, how many interrupts do you get per sector read?  Do
you see extras or not enough?

> We are able to mount the CF, but it is very inconsistent.

Dump the sector data to the screen that you are reading from the CF.
Especially look at the results from the initial identify command to
verify that they make sense, and because that is the easiest to check.

> Same is the case with fdisk command. When it fails,we get errors which you could see in the screen-dump below.
> Are we missing to apply the right patch? Please let us know your
> inputs to go forward.
> Looking forwards for your reply.

> 
> # mount -t msdos /dev/xsysace /root/cf

Shouldn't this be /dev/xsysace1?  You want to mount a partition not the
entire block device.


-- 
Jeff Angielski
The PTR Group
