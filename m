Message-ID: <3CD7F08C.3050906@pacbell.net>
Date: Tue, 07 May 2002 08:19:40 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>,
	linuxppc-embedded@lists.linuxppc.org, kuster@pacbell.net,
	acmay@acmay.homeip.ne
Subject: Re: IBM ocp I2C circular dependency
References: <NCBBIINEHIPFGJPLBEIFMEJMDGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
> I can not speak toward the modularization issue but if the i2c is anything
> like the old 8260 version, change the interruptible_sleep_on() to
> interruptible_sleep_on_timeout(). IMHO this is the easiest fix.
>
>
> i2c-adap-ibm_ocp.c uses
> 	i2c_iic_add_bus and i2c_iic_del_bus from i2c-algo-ibm_ocp.c
>
> i2c-algo-ibm_ocp.c uses
> 	iic_ibmocp_waitforpin from i2c-adap-ibm_ocp.c
>
> This makes it impossible to build as a module. I'am not shure how you want
> to
> solv this.
>
> Also I found a problem with the code when I access a i2c memory from
> userspace and no chip is present at that address. After that it's not
> possible to access anything else on the I2C bus. Works OK as long as I use
> addresses that have a device that answers (I think).
>

Thanks,  I like easy

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
