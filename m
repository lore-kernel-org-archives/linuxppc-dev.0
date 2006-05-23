Return-Path: <tsawyer@broadcom.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id D816067C46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 23:50:07 +1000 (EST)
Message-ID: <4473130D.3080805@broadcom.com>
Date: Tue, 23 May 2006 09:50:05 -0400
From: "Travis B. Sawyer" <tsawyer@broadcom.com>
MIME-Version: 1.0
To: "Travis B. Sawyer" <tsawyer@broadcom.com>
Subject: Re: Problem mapping GPIO regs on ppc440gx
References: <44730484.4090208@broadcom.com>
In-Reply-To: <44730484.4090208@broadcom.com>
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

Answering my own question here...

Travis B. Sawyer wrote:

>Greetings:
>
>We've been using a 2.4.30 kernel (with numerous patches) on a AMCC 440gx
>custom built board for quite some time now.
>
>We're building some new hardware that forces us to go to a 2.6 kernel.
>So, I've downloaded 2.6.16.16 from kernel.org and am porting everything
>forward from our 2.4.30 kernel.
>
>The problem lies in mapping the GPIO regs of the 440 to user space using
>/dev/mem:
>
>    gpio_fd = open("/dev/mem", O_RDWR | O_SYNC);
>
>    if (0 > gpio_fd) {
>        perror("mbGpioGet(): Unable to open gpio");
>        return(-1);
>    }
>
>    addr = (ppc440_gpio_regs_t *)mmap(0, getpagesize() * 2,
>                                      PROT_READ | PROT_WRITE,
>                                      MAP_SHARED, gpio_fd,
>                                      (off_t)(0x40000000));
>
>  
>
The above mmap call worked for 2.4.30, but for 2.6.16 I needed to change 
the offset
to be a multiple of page size, so:
(off_t)(0x40000000/getpagesize());

-travis
