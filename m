Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ABCE68802
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 02:42:18 +1100 (EST)
Message-ID: <43A2E054.6090506@digis.net>
Date: Fri, 16 Dec 2005 08:42:12 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Frank Bennett <bennett78@digis.net>
References: <43A2071A.3030802@digis.net> <43A29A21.8080102@varma-el.com>
	<43A2DE2C.6010708@digis.net>
In-Reply-To: <43A2DE2C.6010708@digis.net>
Content-Type: multipart/alternative;
	boundary="------------010809020208020409030401"
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC5200 ppc_md.set_rtc_time
Reply-To: Frank Bennett <bennett78@digis.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010809020208020409030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

bennett78 wrote:

> Andrey Volkov wrote:
>
>>Hello Frank,
>>
>>bennett78 wrote:
>>  
>>
>>>Hi:
>>>   How / when does "ppc_md.set_rtc_time" get filled
>>>in for Lite5200?
>>>
>>>Config for support /dev/rtc enables CONFIG_PPC_RTC
>>>which enable driver/char/rtc.c which mentions CMOS_WRITE
>>>panics the kernel!
>>>
>>>I trying to use driver/char/genrtc.c.   I can set date
>>>but not hwclock.
>>>
>>>    
>>>
>>>>hwclock --set --date="9/22/96 16:45:05"
>>>>      
>>>>
>>>gen_set_rtc_irq_bit:exit
>>>gen_rtc_ioctl RTC_SET_TIME 00000060
>>>RTC_SET_TIME: Invalid argument
>>>ioctl() to /dev/rtc to set the time failed.
>>>
>>>bash-2.05b# cat /proc/driver/rtc
>>>rtc_time        : 00:50339648:36914
>>>rtc_date        : -1072186980-497--1073718072
>>>rtc_epoch       : 1900
>>>alarm           : 00:00:00
>>>DST_enable      : no
>>>BCD             : yes
>>>24hr            : yes
>>>square_wave     : no
>>>alarm_IRQ       : no
>>>update_IRQ      : no  <----- how can I hook one?
>>>periodic_IRQ    : no
>>>periodic_freq   : 0
>>>batt_status     : okay
>>>
>>>
>>>thanks,
>>>
>>>*/Frank Bennett
>>>/*
>>>    
>>>
>>For 2.6 kernel, check arch/ppc/syslib/lite5200.c, especially
>>platform_init() (at the end of file).
>>    
>>
is this your point?
linux-2.6.12/arch/ppc/platforms/lite5200.c
      /* No time keeper on the LITE5200 */
    ppc_md.time_init    = NULL;
    ppc_md.get_rtc_time = NULL;
    ppc_md.set_rtc_time = NULL;

I don't see any arch/ppc/syslib/lite5200.c

>>  
>>
> Andrey:
>     Thanks, sorry I forgot to mention I'm on DENX linuxppc_2_4_devel.
> Where is the linuxppc 2.6.x distribution?
> Is anyone maintaining a checklist of working features for imbedded 2.6?
> Is this mail list searchable? (other than a month at a time?)
>
> Merry Christmas
> Frank Bennett
>
>>--
>>Regards
>>Andrey Volkov
>>
>>
>>
>>
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>  
>>
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



--------------010809020208020409030401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
bennett78 wrote:
<blockquote cite="mid43A2DE2C.6010708@digis.net" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
Andrey Volkov wrote:
  <blockquote cite="mid43A29A21.8080102@varma-el.com" type="cite">
    <pre wrap="">Hello Frank,

bennett78 wrote:
  </pre>
    <blockquote type="cite">
      <pre wrap="">Hi:
   How / when does "ppc_md.set_rtc_time" get filled
in for Lite5200?

Config for support /dev/rtc enables CONFIG_PPC_RTC
which enable driver/char/rtc.c which mentions CMOS_WRITE
panics the kernel!

I trying to use driver/char/genrtc.c.   I can set date
but not hwclock.

    </pre>
      <blockquote type="cite">
        <pre wrap="">hwclock --set --date="9/22/96 16:45:05"
      </pre>
      </blockquote>
      <pre wrap="">gen_set_rtc_irq_bit:exit
gen_rtc_ioctl RTC_SET_TIME 00000060
RTC_SET_TIME: Invalid argument
ioctl() to /dev/rtc to set the time failed.

bash-2.05b# cat /proc/driver/rtc
rtc_time        : 00:50339648:36914
rtc_date        : -1072186980-497--1073718072
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no  &lt;----- how can I hook one?
periodic_IRQ    : no
periodic_freq   : 0
batt_status     : okay


thanks,

*/Frank Bennett
/*
    </pre>
    </blockquote>
    <pre wrap=""><!---->For 2.6 kernel, check arch/ppc/syslib/lite5200.c, especially
platform_init() (at the end of file).
    </pre>
  </blockquote>
</blockquote>
is this your point?<br>
linux-2.6.12/arch/ppc/platforms/lite5200.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No time keeper on the LITE5200 */<br>
&nbsp;&nbsp;&nbsp; ppc_md.time_init&nbsp;&nbsp;&nbsp; = NULL;<br>
&nbsp;&nbsp;&nbsp; ppc_md.get_rtc_time = NULL;<br>
&nbsp;&nbsp;&nbsp; ppc_md.set_rtc_time = NULL;<br>
<br>
I don't see any arch/ppc/syslib/lite5200.c
<blockquote cite="mid43A2DE2C.6010708@digis.net" type="cite">
  <blockquote cite="mid43A29A21.8080102@varma-el.com" type="cite">
    <pre wrap="">  </pre>
  </blockquote>
Andrey:<br>
&nbsp;&nbsp;&nbsp; Thanks, sorry I forgot to mention I'm on DENX linuxppc_2_4_devel.<br>
Where is the linuxppc 2.6.x distribution?<br>
Is anyone maintaining a checklist of working features for imbedded 2.6?<br>
Is this mail list searchable? (other than a month at a time?)<br>
  <br>
Merry Christmas<br>
Frank Bennett<br>
  <blockquote cite="mid43A29A21.8080102@varma-el.com" type="cite">
    <pre wrap="">--
Regards
Andrey Volkov




_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
  </blockquote>
  <br>
  <br>
  <div class="moz-signature">
  </div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<br>
<div class="moz-signature">
<pre wrap="">
</pre>
</div>
</body>
</html>

--------------010809020208020409030401--
