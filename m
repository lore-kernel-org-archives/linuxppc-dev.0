Date: Thu, 27 Dec 2001 19:17:01 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112280317.fBS3H1o00191@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 + cache/dma issues
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


WD forgot to cc the newsgroup but I thought this worth including here.

Thanks for the information! I don't know if that applies to our situation
though, it seems impossible to believe that motorola could release a chip
with such a critical design flaw. The cache support is supposed to be a
selling point for the chip.

We're using FCC's with ethernet with the data cache enabled, and that
appears to be working ok, at least until other stuff starts happening
(such as a pci device acting as a bus master writing into local bus ram,
while doing some heavy process that uses __copy_tofrom_user, and there
is incoming ethernet traffic, in which case lockups occur).

-Dave

>>
>> >Which mask revision are you using?
>> >
>> >Are you running in 60x bus mode, or in 8260 bus mode?
>> >
>> >Is ther L2 cache on your board?
>> >
>> >Wolfgang Denk
>>
>> The mask is A.1.
>>
>> It is running in 60x bus mode.
>
>I'm afraid there is bad news for you. From what I've seen so far, all
>systems with rev. A.1 (0K26N) silicon had serious problems when doing
>DMA transfers with data cache enabled (usually this shows when  using
>one of the FCC's with some traffic on the ethernet).
>
>Either you turn off the data cache, or you use  a  more  recent  mask
>revision (at least rev. C.2 - 6K23A).
>
>The kernel source on our FTP server has a config option to  turn  off
>the  data  cache  (CONFIG_DCACHE_DISABLE), but be warned: performance
>breaks down to a f*cking 10%; you can find our kernel at
>ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-11-24.tar.bz2
>
>Hope this helps,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Quote from a recent meeting:   "We are going to continue having these
>meetings everyday until I find out why no work is getting done."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
