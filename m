To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Opps...with ELDK-2.1.0 (ppc_4xx) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Apr 2003 14:38:23 CDT."
             <F9102D41F595D311ACA7009027DE2C840527B194@c3po.heurikon.com>
Date: Tue, 22 Apr 2003 21:50:25 +0200
Message-Id: <20030422195030.4B9A7C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steve,

in message <F9102D41F595D311ACA7009027DE2C840527B194@c3po.heurikon.com> you wrote:
> Here's the results of ksymoops for the ppc_4xx kernel. Hopefully this is consistent with what has been observed.

It is pretty much consisten with what we're seeing here...

> Trace; c000f2dc <schedule+94/57c>
> Trace; c000f1ec <schedule_timeout+98/cc>
> Trace; c000fcec <interruptible_sleep_on_timeout+68/ac>
> Trace; c00dc510 <iic_wait_for_irq+88/1b0>
> Trace; c00dc860 <iic_sendbytes+228/29c>
> Trace; c00dcf74 <iic_xfer+1bc/1d0>
> Trace; c00da7a0 <i2c_transfer+8c/e0>
> Trace; c00db5cc <i2c_smbus_xfer_emulated+218/298>
> Trace; c00db720 <i2c_smbus_xfer+d4/f0>
> Trace; c00db110 <i2c_smbus_write_byte_data+34/44>
> Trace; c00dd664 <rtc_write+28/58>
> Trace; c00dd7e4 <m41t00_set_rtc_time+150/1b0>
> Trace; c0004f04 <timer_interrupt+1c4/254>
> Trace; c000376c <ret_from_intercept+0/8>
> Trace; c00228c8 <check_pgt_cache+20/30>
> Trace; c0004d04 <idled+58/70>
> Trace; c0004d2c <cpu_idle+10/24>
> Trace; c00011d0 <rest_init+30/40>
> Trace; c0181598 <start_kernel+168/17c>
> Trace; c0000224 <skpinv+1b8/1f0>

This means you have a RTC on the I2C bus, right? Same here. It  works
fine on all baords except those with a I2C based RTC. Which is why we
detected the problem so late.


Thanks a lot for the feedback!


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
