To: Matteo Bortolin <matteo.bortolin@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org, llandre@wawnet.biz
Subject: Re: Problem with i2c-algo-ibm_ocp driver on ppc405 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jan 2004 09:25:40 +0100."
             <6.0.1.1.1.20040128085052.01b12d40@192.168.2.1>
Date: Wed, 28 Jan 2004 10:14:29 +0100
Message-Id: <20040128091434.28ECCC108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Matteo,

in message <6.0.1.1.1.20040128085052.01b12d40@192.168.2.1> you wrote:
>
> This would mean that a kernel that use  i2c-algo-ibm_ocp.c and a i2c
> RTC-driver cannot work properly
> with CONFIG_RTC_11_MINUTE_MODE!!!
>
> Is this correct?

This is correct.  This  is  exactly  the  reason  why  we  added  the
CONFIG_RTC_11_MINUTE_MODE config option in our kernel tree - with the
official kernels you will ALWAYS crash, as there is no such option.

> If yes, how can I solve my problem?

Do not enable CONFIG_RTC_11_MINUTE_MODE?

Do you understand what 11 minute  mode  means?  And  do  you  really,
really  want  such  a  behaviour?  In  almost all cases I've seen the
accuracy of the external RTC was much better than that of the  system
clock.  In  such  a case you may either just set the system time from
the RTC at boot time (and then let  the  system  time  drift  out  of
sync),  or  run NTPD to keep the system time synced with the RTC (the
RTC being the normal). I have been told that there are  installations
where  the  11 minute mode is being used (and believed to be useful),
but I don't know any. Especially not in embedded systems.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The light at the end of the tunnel is usually a "No Exit" sign.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
