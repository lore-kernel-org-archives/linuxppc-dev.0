Date: Fri, 13 Dec 2002 10:35:40 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NVRAM/RTC
Message-ID: <20021213103540.A8090@home.com>
References: <000901c2a20b$23472400$370da8c0@aman> <20021212145243.A5263@home.com> <00b801c2a2c1$70bc9470$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00b801c2a2c1$70bc9470$370da8c0@aman>; from aman@mistralsoftware.com on Fri, Dec 13, 2002 at 09:35:22PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 13, 2002 at 09:35:22PM +0530, Aman wrote:
> This might be a very basic question. By porting what do you mean?. As of now

By "porting", I mean adding a set of code that reflect the unique
characteristics of your custom board.

> I copied the ebony bsp to different location and did changes to boot on the
> custom board. Till now it was booting without any problem. Once I changed
> the EBC configuration to configure some other FPGA ,bcos of which  linux
> booting hangs at " Now Booting the kernel ".

Hrm, without knowing your custom board I can't really comment on
the potential source of something that is specific to your board.

You can try enabling early boot text messages.  Hopefully it still
works on 440, I heard a rumor that it might be broken which would
require some changes to head_440.S.  An easier path is, of course,
using a hardware debugger (BDI) to point you to where you are
dying...I usually just dump logbuf before the console is inited
so I can read the buffered oops message.

> I commented the ioremap of RTC, and the definitions of
> ppc_md.set_rtc_time = todc_set_rtc_time;
>
> ppc_md.get_rtc_time = todc_get_rtc_time;
>
>  still the same problem. Should I hv to do something else also.

You need to get rid of time_init, set_rtc_time, get_rtc_time,
nvram_read_val, nvram_write_val too.

You *will* get an oops from a machine check if you even have
todc_time_init enabled...it will be attempting to read from
some bogus location.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
