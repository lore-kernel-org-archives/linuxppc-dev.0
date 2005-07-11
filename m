Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 32A3B67C1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 00:27:08 +1000 (EST)
To: "Absolut Hunter" <absoluthunter@comcast.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Jul 2005 06:38:11 PDT."
	<20050711134713.D767067C13@ozlabs.org>
Date: Mon, 11 Jul 2005 16:22:50 +0200
Sender: wd@denx.de
Message-Id: <20050711142250.BC3253539FE@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4.25 / MPC8280 / ram config vs Linux instability? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050711134713.D767067C13@ozlabs.org> you wrote:
> 
> If I leave the SRAM mapped at higher addresses 0x10000000 and SDRAM at
> 0x00000000, like U-boot defaults to Linux works great. However, my goal is
> to map SRAM <8ns speeds> down to the address 0x00000000, to map the vector
> table, so I can achieve a very fast interrupt response time.

How fast is your bus? 8 ns is not exactly very fast.

> I hacked U-boot a little bit to remap these addresses, after all the init

Hacked? No hack at all should have been necessary. This  is  standard
configuration stuff.

> reported to Linux, in the bd->memsize. However, now Linux crashes randomly
> all over the place, mostly sig11's task: swapper. I know this is not an

SO one or your memory banks does not work reliably.

> issue with SDRAM stability, and I can't imagine SRAM having problems seeing
> as its 8ns capable and we're running at 15ns at the moment (66mhz).

And what about the state of your hardware? Did you check the signals,
especially when the CPU is stressing the bus in burst mode?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Let the programmers be many and the managers few -- then all will  be
productive.               -- Geoffrey James, "The Tao of Programming"
