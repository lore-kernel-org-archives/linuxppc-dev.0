Date: Thu, 26 Aug 2004 08:46:02 -0400 (EDT)
From: "Mark S. Mathews" <mark@linux-wlan.com>
To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: m8xx hang in reboot (fwd)
In-Reply-To: <065ACD8E84315E4394C835E398C8D5EB5DAF80@cossmgmbx02.email.corp.tld>
Message-ID: <Pine.LNX.4.61.0408260843020.19804@chef.linux-wlan.com>
References: <065ACD8E84315E4394C835E398C8D5EB5DAF80@cossmgmbx02.email.corp.tld>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the input, but I don't believe this is it.  We're accessing a
location IMAP_ADDR+someoffset that's reserved space to generate a bus
error.

Thanks for the consideration,
-M

On Thu, 26 Aug 2004, VanBaren, Gerald (AGRE) wrote:

>
> OK, I'll add my guess :-).  Do you have the address IMAP_ADDR cached
> (which would be a Very Bad Thing!)?  If so, you sometimes would read the
> cached value (no machine check) rather than the physical value (machine
> check -> reset).
>
> gvb
>
>
>> -----Original Message-----
>> From: owner-linuxppc-embedded@lists.linuxppc.org
>> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
>> Of Mark S.
>> Mathews
>> Sent: Wednesday, August 25, 2004 5:26 PM
>> To: linuxppc-embedded
>> Subject: Re: m8xx hang in reboot (fwd)
>>
>>
>>
>> The saga continues...  ;-)
>>
>> I added code to explicitly clear the CHSTPE bit in the DER register.
>> Didn't make any difference.
>>
>> I'm stumped.
>>
>> -M
>>
>> On Wed, 25 Aug 2004, Mark S. Mathews wrote:
>>
>>>
>>> A little more info.  The hang occurs on this line:
>>>
>>> 	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
>>>
>>> Which is _supposed_ to generate a machine check I believe.
>>>
>>> So I guess my next step is to see if somehow the DER got
>> set and we're
>>> popping into debug mode instead of resetting...
>>>
>>> -M
>>>
>>> --
>>>
>>> Mark S. Mathews
>>>
>>> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
>>> 721-D North Drive          e-mail: mark@linux-wlan.com
>>> Melbourne, FL 32934        Phone:  321.259.0737
>>> USA                        Fax:    321.259.0286
>>>
>>> ---------- Forwarded message ----------
>>> Date: Wed, 25 Aug 2004 16:22:00 -0400 (EDT)
>>> From: Mark S. Mathews <mark@linux-wlan.com>
>>> To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
>>> Subject: m8xx hang in reboot
>>>
>>> Hey Folks,
>>>
>>> I've got an mpc850 based setup running 2.4.27 that, under certain
>>> circumstances, hangs in the the m8xx_restart() function (instead of
>>> rebooting)
>>> when I issue the usermode reboot cmd.
>>>
>>> I've traced all through the path and confirmed that yes, it
>> is hanging in
>>> this
>>> function.  ;-)
>>>
>>> I'm still looking over the databook and what this code
>> does.  Just figured
>>> I'd
>>> ask around and see if anyone else has seen this behavior.
>>>
>>> Thanks,
>>> -Mark
>>>
>>> --
>>>
>>> Mark S. Mathews
>>>
>>> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
>>> 721-D North Drive          e-mail: mark@linux-wlan.com
>>> Melbourne, FL 32934        Phone:  321.259.0737
>>> USA                        Fax:    321.259.0286
>>>
>>>
>>>
>>
>> --
>>
>> Mark S. Mathews
>>
>> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
>> 721-D North Drive          e-mail: mark@linux-wlan.com
>> Melbourne, FL 32934        Phone:  321.259.0737
>> USA                        Fax:    321.259.0286
>>
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
