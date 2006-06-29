Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 57DC567B5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 01:37:20 +1000 (EST)
Message-ID: <44A3F29F.8020507@ru.mvista.com>
Date: Thu, 29 Jun 2006 19:32:47 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Qichen Huang <jasonal00@googlemail.com>
Subject: Re: Problem with Xilinx Uart Lite
References: <b4ebaa9d0606290820y4dce2ce2x8d28007b1d591eef@mail.gmail.com>
In-Reply-To: <b4ebaa9d0606290820y4dce2ce2x8d28007b1d591eef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Qichen Huang wrote:
> Hi all,
> 
> I'm trying to port linuxppc_2_4_devel to Xilinx ML403. I want to use 
> UartLite instead of Uart 16550. What changes should I do?
> 
> I have disabled "Standard/generic (8250/16550 and compatible UARTs) 
> serial support"
> and enabled "Xilinx UART Lite" & "Console on UART Lite port" in 
> character devices.
> And the initial kernel command string is changed to "console=ttl0 
> console=ttyS0,9600 ip=off root=/dev/xsysace/disc0/part3 rw".

This command line sets default console to ttyS0.
Please remove "console=ttyS0,9600".

> The kernel boot log dosen't mention any serial device and it hangs up 
> until "System started." There is no login prompt.

Are you using the correct xparameters_*.h - the one having the
#defines for UartLite?

> My /etc/inittab is :
> 
> ::sysinit:/etc/init.d/rcS
> #::askfirst:-/bin/sh
> ::ctrlaltdel:/sbin/reboot
> ::shutdown:/sbin/swapoff -a
> ::shutdown:/bin/umount -a -r
> ::restart:/sbin/init
> ::respawn:/sbin/getty 9600 tts/0
> 
> 
> What else should I do?
> Thank you!
> 
> Qichen
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
