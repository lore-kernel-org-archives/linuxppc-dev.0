Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 7858267A30
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jan 2005 08:28:08 +1100 (EST)
Message-ID: <41F16B51.1000003@mvista.com>
Date: Fri, 21 Jan 2005 13:51:29 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: annamaya <annamaya@yahoo.com>
References: <20050121201632.69802.qmail@web53804.mail.yahoo.com>
In-Reply-To: <20050121201632.69802.qmail@web53804.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel booting issues on a MPC8270 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

annamaya wrote:
> I debugged this problem a little more and realized
> that the reset was happenning right after the
> execution of the first kernel instruction at
> 0x0000000c. The instruction at this location was
> "mfpvr r28". I traced this back to a snippet of code
> that was dealing with pipeline depth issues on the
> MPC8260. Once I commented this code out, more
> instructions were issued but the reboot happens
> elsewhere. I am not able to pin-point the location of
> the debug since my BDI fails to catch the reset when
> it happens. Can someone point me to the cause of this
> situation? Thanks in advance.

I'm not familiar with the 8260, but this sounds very much like a 
hardware watchdog is expiring somewhere. Check to see if the hardware 
has an on-board watchdog (most likely in the timer section of the 8260) 
and see if the firmware has armed it. If so, you'll need to add a 
snippet of code to disable the watchdog to allow boot-up to complete.

		Randy Vinson
