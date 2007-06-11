Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D6BDBDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 01:27:21 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1181548600.5217.16.camel@mark>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8009e52995468cb801ebd94b144fa629@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class driver
	subsystem
Date: Mon, 11 Jun 2007 09:35:42 -0500
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon Jun 11 17:56:40 EST 2007, Mark Zhan wrote:
> Add the support of ST M48T59 RTC chip driver in RTC class subsystem for
> Wind River SBC PowerQUICCII 82xx board

...
> +#define M48T59_CNTL            0x1ff8
> +#define M48T59_WATCHDOG                0x1ff7
> +#define M48T59_INTR            0x1ff6
> +#define M48T59_ALARM_DATE      0x1ff5
> +#define M48T59_ALARM_HOUR      0x1ff4
> +#define M48T59_ALARM_MIN       0x1ff3
> +#define M48T59_ALARM_SEC       0x1ff2
> +#define M48T59_UNUSED          0x1ff1
> +#define M48T59_FLAGS           0x1ff0
> +
> +#define M48T59_WDAY_CB         0x20    /* Century Bit */
> +#define M48T59_WDAY_CEB                0x10    /* Century Enable Bit 
> */
> +
> +#define M48T59_CNTL_READ       0x40;
> +#define M48T59_CNTL_WRITE      0x80;
> +
> +#define M48T59_FLAGS_WDT       0x80    /* watchdog timer expired */
> +#define M48T59_FLAGS_AF                0x40    /* alarm */
> +#define M48T59_FLAGS_BF                0x10    /* low battery */
> +
> +#define M48T59_INTR_AFE                0x80    /* Alarm Interrupt 
> Enable */
> +#define M48T59_INTR_ABE                0x20
>

Another style is to put the flag and control register values 
immediately after the register, indenting the values an additional tab 
to distinguish them from the list of registers.   Either way is ok with 
me.

> +/**
> + * NOTE: M48T59 only uses BCD mode
> + */
> +static int m48t59_rtc_read_time(struct device *dev, struct rtc_time
> *tm)
> +{
> +       unsigned char val;
> +
> +       /* Issue the READ command */
> +       M48T59_WRITE((M48T59_READ(M48T59_CNTL) | 0x40), M48T59_CNTL);
> +
...
> +       /* Clear the READ bit to restore the update */
> +       M48T59_WRITE((M48T59_READ(M48T59_CNTL) & ~0x40), M48T59_CNTL);

Should you clear READ and WRITE when your driver starts in case the 
previous driver got interrupted (say the system crashed)?  Or is it ok 
for READ and WRITE to be set?

You aren't using the READ and WRITE flag bits you defined above.   If 
the line gets too long, you might create a SET_BITS / CLEAR_BITS macro.

milton
