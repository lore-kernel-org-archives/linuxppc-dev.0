Message-Id: <5.1.0.14.2.20030423101917.02ca96a8@mail.ebshome.net>
Date: Wed, 23 Apr 2003 10:24:34 -0700
To: "Montgomery, Tim" <timm@artesyncp.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: Opps...with ELDK-2.1.0 (ppc_4xx) 
Cc: Wolfgang Denk <wd@denx.de>,
	"Johnson, Stephen" <stevebj@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <F9102D41F595D311ACA7009027DE2C8406AB8214@c3po.heurikon.com
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:18 AM 4/23/2003, Montgomery, Tim wrote:

>[Wolfgang]
> > >
> > >This means you have a RTC on the I2C bus, right? Same here. It  works
> > >fine on all baords except those with a I2C based RTC. Which is why we
> > >detected the problem so late.
> >
>
>[Eugene]
> > It looks like a bug in m41t00_set_rtc_time.
> >
> > Generic I2C layer is very high-level subsystem and can not be
> > used from the interrupt context.
> >
>
>If the i2c layer cannot be used in the (e.g. timer) interrupt context,
>wouldn't that preclude the use of the i2c layer to provide support (i.e.
>clock updates) to an i2c-based rtc?

Unfortunately, it looks so

>Any suggestions on how to work around this?

We can start kernel thread and call i2c from it (or maybe use one which is
already available in the kernel?) .
<foo>_set_rtc_time will notify this thread when it needs to update RTC from
interrupt.

If you worry about accuracy, we may also remember "jiffies" at the time of
<foo>_set_rtc_time and adjust time accordingly when calling i2c (but I
doubt it's worth it).

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
