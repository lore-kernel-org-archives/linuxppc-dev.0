Message-ID: <40C47DBB.3060300@mvista.com>
Date: Mon, 07 Jun 2004 09:37:47 -0500
From: Mark Hatle <mhatle@mvista.com>
MIME-Version: 1.0
To: bharat <bharat@coraltele.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: regarding ld.so.preloads,ld.so.cache
References: <28007367.1086432866812.JavaMail.administrator@RnDserver>
In-Reply-To: <28007367.1086432866812.JavaMail.administrator@RnDserver>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Two things.  First ld.so.preloads and ld.so.cache (and ld.conf) are all
optional, and usually won't exist on an embedded system.  (You might get
some arguments by some about ld.so.cache.. but the point is it does NOT
need to exist).

Second I believe you NFS problems are probably unrelated.  Specifically
on system without a proper RTC, the timestamps for NFS requests will
reset to a previous time stamp.  NFS uses time stamps to make sure that
requests are always moving "forward" in time.  If you reboot your
embedded system, the time stamp goes back in time.. you can easily get
lockups with the NFS server not responding.

First thing to try, reboot the NFS server, and see if it works once..
then stops working for subsequent boots.  If that is the case, then you
will need to figure out how to seed the kernel (on your embedded system)
with a reasonable "time/date" combo if you don't have an RTC.

--Mark

bharat wrote:
> hello everyone
>                     i am using Hardhat embedded linux for my customerized
> board everything went fine till th dhell init as soon as the init is called
> the control starts looking for ld.so.preloads,ld.so.cache and then after
> loading  some files from NFS mounted  file sytem from server this goes hangs
> i am looking for an answer since last three days and it is driven me mad
> please help me
> bharat
>
>
>
> !-- Virus-Free Mail Using PostMaster Enterprise AvAc & QuickHeal Engine --!
>
> -----------------------------------
> Coral Telecom Limited, Noida, India
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
