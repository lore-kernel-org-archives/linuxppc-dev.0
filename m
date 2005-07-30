Return-Path: <a.woellert@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 69A1D67CF4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 20:37:56 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 55so805123wri
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 03:37:55 -0700 (PDT)
Message-ID: <42EB587D.80403@gmail.com>
Date: Sat, 30 Jul 2005 12:37:49 +0200
From: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
MIME-Version: 1.0
To: Daniel Ann <ktdann@gmail.com>,  linuxppc-embedded@ozlabs.org
References: <9b7ca65705072918062249e41f@mail.gmail.com>
In-Reply-To: <9b7ca65705072918062249e41f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ann wrote:
> Hi folks,
> 
> Having all the kernel boot up log on console means that I've done some
> part right. But why am I not getting anything from the user processes
> on the console screen ?
> 
> Is there anything I need to do on the kernel config ?
> 

Hi, we've had the same problem some time ago on a tqm850l (mpc850). Our 
problem was, that we had registered two serial consoles in the kernel 
config or something like that. we had to disable all serial-driver stuff 
and enable just the platform-specific serial-console driver. we tracked 
this down with inserting a printk(buf) into the tty_write fs-op of the 
serial-port driver in drivers/char/tty_io.c. the ttyS0 was used but has 
taken another serial-driver than the platform specific.

may this help you :)


anton
