From: Alan Mimms <alan@packetengines.com>
To: "Shuangjun Zhu" <r44089@email.sps.mot.com>, "Dan Malek" <dan@netx4.com>
Subject: Re: Help about MPC823 Video and Cache
Date: Wed, 26 Jan 2000 17:15:10 -0800
Content-Type: text/plain
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <002201bf6861$20f24d10$69f001dc@sjzhu.sps.mot.com>
In-Reply-To: <002201bf6861$20f24d10$69f001dc@sjzhu.sps.mot.com>
MIME-Version: 1.0
Message-Id: <00012617164708.05597@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We experimented at Apple with cacheable frame buffers and this is what we saw.

I believe this is caused by the cache being on for the region of memory used
for the frame buffer.  You'll see little 16 byte chunks of memory sparkling as
the cache finally dumps out dirty cache lines into the real frame buffer.

You can fix this by mapping the area of the frame buffer with cache disabled,
or you can add code to some periodic timer handler to do a DCBF on the region
of the frame buffer each time the timer ticks (this is not cheap, however).

a

On
Wed, 26 Jan 2000, Shuangjun Zhu wrote: > Hello, everyone
>
> I'm using kernel version 2.2.13 on my MPC823 FADS board
> to display on TV. I have a problem:
>
> After the system boot up, the text on the TV flicker fiercely out,
> if I disable the I-Cache throught the EST visionProbe tool,
> TV will not flicker out again.
> Of course, if I disable the cache when the system boot up,
> TV display OK.
> So there is some relation between the cache and the video, I guess.
>
>
> Do you have any suggestion?
> Thanks in advacned!
>
> BRs,
> Shuangjun
--
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
