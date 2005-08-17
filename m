Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id 9A36B67F6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 11:53:54 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so65295wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 18:53:53 -0700 (PDT)
Message-ID: <c3d0340b05081618535468581e@mail.gmail.com>
Date: Tue, 16 Aug 2005 18:53:53 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <c3d0340b050811154148164691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050811154148164691@mail.gmail.com>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> When the kernel is booting, it gets to the point where console_init()
> is called, which calls individual early console initialization
> functions. In my case it's serial8250_console_init(). Before
> register_console() is called in serial8250_console_init(), everything
> seems fine because the debugging logs are printed on the serial port.
> But once register_console() is called, the serial port continues
> spitting out =E0. See the following message. What's wrong?

FYI. The problem was caused by the endianess of io mem access. My
16550-compatible uart port is on a 32-bit bus. The io mem is big
endian. The current serial8250 driver always call read*/write*() to
access uart control registers. These functions are implemented for
little endian access only. So I have to add some awful #ifdef in the
driver to call big endian access functions.

Regards,
-Shawn.
