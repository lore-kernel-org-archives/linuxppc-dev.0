Date: Thu, 26 Aug 2004 11:34:56 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	=?ISO-8859-1?Q?Stefan_St=FCrke?= <sst@pandatel.com>
Subject: Re: [SPAM] Re: m8xx hang in reboot
In-Reply-To: <8F645223-F76B-11D8-89B4-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.61.0408261110400.20706@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com>
 <cgk0lp$5dk$1@sea.gmane.org> <Pine.LNX.4.61.0408260822060.19804@chef.linux-wlan.com>
 <8F645223-F76B-11D8-89B4-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan, Stefan, all...

Yup, doing a read via the mtd device after the write to the mtd device
appears to take care of the problem.  Hmmm, is this an mtd bug?  or
perhaps a board specific thing.

Oh well, don't have time to debug the mtd stuff right now so I'll just do
the read-after-write workaround and move on.

My thanks to all for the suggestions and for making me think,
-Mark

BTW Dan: The wlan device does get shutdown (and driver is unloaded) before
          the reboot call.  The wierd thing is that I set up the system in
          a mode where the wlan device is never brought up at all, did the
          flash unlock/erase/write (no read), and issued the reboot...
          it worked just fine.  The reboot failure seems to require that
          the wlan device be operational.  Seems to imply that this problem
          is somehow tied to one or more of: pcmcia hw, wlan device hw,
          pcmcia sw, or wlan sw.  'Tis a quandry.  Perhaps we'll never
          know, I've got other fish to fry now...



On Thu, 26 Aug 2004, Dan Malek wrote:

>
> On Aug 26, 2004, at 8:28 AM, Mark S. Mathews wrote:
>
>> One item of info that I had left out of the original post (because I
>> hadn't verified 100% that this was truly part of the issue):
>>   The "certain circumstances" prior to the reboot failure are:
>>     1) we've just completed an unlock/erase/write on one of our flash
>>        partitions.
>
> Oh Geeze.....yeah, that could be a problem :-)
>
>>     2) the wlan device that's attached to the pcmcia interface was
>>        previously in use.
>
> Can you test these independently to see which is causing the
> trouble?  I'm also guessing it's number 1.
>
>> If the wlan device was not in use or if we don't do the flash
>> unlock/erase/write, then the reboot works just fine.  Strange
>> combination
>> of factors.
>
> Both of these make sense.  After you are done writing the flash,
> do something to read  it, so it returns to that state.  You may
> need to shut down the wlan before rebooting if that is causing
> the trouble.
>
>
> 	-- Dan
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

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
