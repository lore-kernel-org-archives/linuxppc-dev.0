Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <F9102D41F595D311ACA7009027DE2C8406AB8214@c3po.heurikon.com>
From: "Montgomery, Tim" <timm@artesyncp.com>
To: "'Eugene Surovegin'" <ebs@ebshome.net>,
	Wolfgang Denk <wd@denx.de>
Cc: "Johnson, Stephen" <stevebj@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Opps...with ELDK-2.1.0 (ppc_4xx) 
Date: Wed, 23 Apr 2003 12:18:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[Wolfgang]
> >
> >This means you have a RTC on the I2C bus, right? Same here. It  works
> >fine on all baords except those with a I2C based RTC. Which is why we
> >detected the problem so late.
>

[Eugene]
> It looks like a bug in m41t00_set_rtc_time.
>
> Generic I2C layer is very high-level subsystem and can not be
> used from the interrupt context.
>

If the i2c layer cannot be used in the (e.g. timer) interrupt context, wouldn't that preclude the use of the i2c layer to provide support (i.e. clock updates) to an i2c-based rtc?

Any suggestions on how to work around this?

Wolfgang:
I know you had some examples of i2c-based rtc support in your tree.  Assuming the above is the cause behind the oops, does your driver preclude rtc updates from the timer interrupt context?

Some time ago I queried the list on the best way to support an i2c-based RTC; at that time, there was no consensus.
Any more thoughts along these lines?

Regards,
Tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
