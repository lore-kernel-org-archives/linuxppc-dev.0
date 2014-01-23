Return-Path: <linux@prisktech.co.nz>
Received: from server.prisktech.co.nz (server.prisktech.co.nz [115.188.14.127])
 by ozlabs.org (Postfix) with ESMTP id 2606B2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 19:04:13 +1100 (EST)
Message-ID: <52E0CD18.5080104@prisktech.co.nz>
Date: Thu, 23 Jan 2014 21:04:40 +1300
From: Tony Prisk <linux@prisktech.co.nz>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>	<52E0C889.6000106@prisktech.co.nz>
 <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
In-Reply-To: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Kevin Hilman <khilman@deeprootsystems.com>, linux <linux@lists.openrisc.net>,
 Sekhar Nori <nsekhar@ti.com>, Michal Simek <monstr@monstr.eu>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>,
 Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard Weinberger <richard@nod.at>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>,
 Ingo Molnar <mingo@redhat.com>, microblaze-uclinux@itee.uq.edu.au,
 David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 linux-arm-msm@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 davinci-linux-open-source@linux.davincidsp.com,
 linux-samsung-soc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
 uml-user <user-mode-linux-user@lists.sourceforge.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Jim Cromie <jim.cromie@gmail.com>,
 Hanjun Guo <guohanjun@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Bryan Huntsman <bryanh@codeaurora.org>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/01/14 20:58, Geert Uytterhoeven wrote:
> On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>    -static inline int clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>>    {
>>>          return __clocksource_register_scale(cs, 1, hz);
>>>    }
>>
>> This doesn't make sense - you are still returning a value on a function
>> declared void, and the return is now from a function that doesn't return
>> anything either ?!?!
>> Doesn't this throw a compile-time warning??
> No, passing on void in functions returning void doesn't cause compiler
> warnings.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
Doesn't seem right to me (even if there is no warning) but that's 
probably because I used to program in Pascal where functions with no 
return were 'procedures' :)
Whether it needs to be changed or not:

For the vt8500 part -
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk
