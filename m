Message-ID: <004d01bf6867$6b15bc50$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Alan Mimms" <alan@packetengines.com>, "Dan Malek" <dan@netx4.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Help about MPC823 Video and Cache
Date: Thu, 27 Jan 2000 09:39:44 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan,

Thanks,
More important, in my program, I througth following code to disable the
cache
for the display buffer memory:
============================================================================
 for (i=0,mem_addr=__va(video_fb_base);i<num_video_pages;i++) {
                pte = va_to_pte(&init_task, mem_addr);
                pte_val(*pte) |= _PAGE_NO_CACHE;
                flush_tlb_page(current->mm->mmap, mem_addr);
  mem_addr += PAGE_SIZE;
 }
============================================================================
Is it right?

Through the debug tool (EST visionProbe), if I just disable the I-Cache,
TV display almost OK, and disable the D-Cache and I-Cache both, it's
very well, but if I modify from write-through to write-back,
effection is not notable.

BRs,
Shuangjun


-----Original Message-----
From: Alan Mimms <alan@packetengines.com>
To: Shuangjun Zhu (r44089) <r44089@email.sps.mot.com>; Dan Malek
<dan@netx4.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Date: Thursday, January 27, 2000 9:26 AM
Subject: Re: Help about MPC823 Video and Cache


>Forgot this: One more possibility is to make the frame buffer region of
address
>space cacheable but write-thru rather than copy-back.
>
>a
>
>On Wed, 26 Jan 2000, Alan Mimms wrote: > We experimented at Apple with
>cacheable frame buffers and this is what we saw. >
>> I believe this is caused by the cache being on for the region of memory
used
>> for the frame buffer.  You'll see little 16 byte chunks of memory
sparkling as
>> the cache finally dumps out dirty cache lines into the real frame buffer.
>>
>> You can fix this by mapping the area of the frame buffer with cache
disabled,
>> or you can add code to some periodic timer handler to do a DCBF on the
region
>> of the frame buffer each time the timer ticks (this is not cheap,
however).
>>
>> a
>>
>> On
>> Wed, 26 Jan 2000, Shuangjun Zhu wrote: > Hello, everyone
>> >
>> > I'm using kernel version 2.2.13 on my MPC823 FADS board
>> > to display on TV. I have a problem:
>> >
>> > After the system boot up, the text on the TV flicker fiercely out,
>> > if I disable the I-Cache throught the EST visionProbe tool,
>> > TV will not flicker out again.
>> > Of course, if I disable the cache when the system boot up,
>> > TV display OK.
>> > So there is some relation between the cache and the video, I guess.
>> >
>> >
>> > Do you have any suggestion?
>> > Thanks in advacned!
>> >
>> > BRs,
>> > Shuangjun
>> --
>> Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
>>   USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
>> Despite the cost of living, have you noticed how popular it remains?
>>   -- Steven Wright?
>--
>Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
>  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
>Despite the cost of living, have you noticed how popular it remains?
>  -- Steven Wright?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
