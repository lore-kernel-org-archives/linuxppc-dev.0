Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 580FC67B2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 08:10:21 +1000 (EST)
In-Reply-To: <000201c68335$7c594b90$5201a8c0@GEG2400>
References: <000201c68335$7c594b90$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <72927AD7-DCFD-470E-A9FD-D3BE10100D53@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Linux kernel thread with Linux 2.6.x
Date: Tue, 30 May 2006 17:10:14 -0500
To: Laurent Lagrange <lagrange@fr.oleane.com>
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

Couldn't you use a work_queue?  For the PHY Layer, the MDIO  
transactions can't occur at interrupt time (they need to be  
interruptible), so the interrupt handler calls schedule_work() to get  
the interrupt handled.  I'm not sure how much faster it is (if at  
all), but it's another method, and sounds less complicated than  
waiting on a semaphore.

Of course, I would suggest trying to avoid the buffer allocation  
functions you are using, or defer the work using NAPI, but it's  
impossible for me to tell whether that's a reasonable solution for you.

On May 29, 2006, at 10:35, Laurent Lagrange wrote:

>
> Hello everybody,
>
> I'm writing a custom network driver based on a MPC8260 FCC device  
> for a
> 2.6.9 linux kernel.
> In this driver, I need to use specific buffer allocation functions  
> which use
> down and up semaphore functions.
>
> As the interrupt handler can't be scheduled, I have made a kernel  
> thread
> which waits forever on a semaphore.
> This semaphore is set when a received packet interrupt occured. All  
> that
> mechanism works but the performances
> are very poor.
>
> Is there any solution to increase the kthread priority in the  
> scheduler ?
> Is there another solution than the semaphore to quickly wake up a  
> kthread ?
>
> Thanks a lot for your help.
> Laurent
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
