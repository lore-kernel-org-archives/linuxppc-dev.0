Date: Thu, 26 Aug 2004 08:28:40 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: =?ISO-8859-1?Q?Stefan_St=FCrke?= <sst@pandatel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: [SPAM] Re: m8xx hang in reboot
In-Reply-To: <cgk0lp$5dk$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0408260822060.19804@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com>
 <cgk0lp$5dk$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-250195270-1093523320=:19804"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-250195270-1093523320=:19804
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT


This is interesting, thanks Stefan.

One item of info that I had left out of the original post (because I
hadn't verified 100% that this was truly part of the issue):
   The "certain circumstances" prior to the reboot failure are:
     1) we've just completed an unlock/erase/write on one of our flash
        partitions.
     2) the wlan device that's attached to the pcmcia interface was
        previously in use.

If the wlan device was not in use or if we don't do the flash
unlock/erase/write, then the reboot works just fine.  Strange combination
of factors.

Thanks Stefan,
-M


On Thu, 26 Aug 2004, Stefan Stürke wrote:

>
> Mark S. Mathews wrote:
>>
>> Hey Folks,
>>
>> I've got an mpc850 based setup running 2.4.27 that, under certain
>> circumstances, hangs in the the m8xx_restart() function (instead of
>> rebooting) when I issue the usermode reboot cmd.
>>
>> I've traced all through the path and confirmed that yes, it is hanging in
>> this function.  ;-)
>
> Maybe you can have a look at your boot flash when you enter the
> m8xx_restart() function. I had a similar problem and found that
> my boot flash was in read status state in that moment, so it was
> impossible to fetch the correct programm code after reset.
>
> HTH,
> Stefan
>
> --
> PANDATEL AG
> Bayernstrasse 33
> 30855 Langenhagen
> Germany
>
> Tel.: +49 (0)511 978199-15
> Fax.: +49 (0)511 978199-77
> mailto:sst-news2003@pandatel.com
> www.pandatel.com
>
>
>
>

--

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286
--8323328-250195270-1093523320=:19804--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
