Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7C912BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 07:18:57 +1000 (EST)
In-Reply-To: <20041015205903.1653.qmail@web53804.mail.yahoo.com>
References: <20041015205903.1653.qmail@web53804.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1FB8DAAD-1EF0-11D9-BD1F-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 15 Oct 2004 17:21:05 -0400
To: annamaya <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Floating point error on a MPC8280 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 15, 2004, at 4:59 PM, annamaya wrote:

> When I try to reboot my system on a MPC8280 eval
> board, I see the floating point error. Does anyone
> know why is this happening?

It's trying to jump to a restart location in the boot rom.
It fetches a bad instruction that attempts to execute
as a floating point instruction.

> bash-2.05b# reboot -f
> Restarting system
> floating point used in kernel (task=cf458000,
> pc=ff000104)

This program counter is a typical warm restart boot
rom location.  Change the kernel reboot code to jump
to the proper place in your boot rom or force a restart
in some way.


	-- Dan
