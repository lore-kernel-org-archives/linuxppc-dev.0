Date: Tue, 26 Feb 2002 08:00:48 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202261600.g1QG0mZ04026@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Cc: dan@embeddededge.com, linville@lvl7.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have seen similiar behaviour with our box, which uses the 8260. The problem
was traced down to the CPM and the external device (a pci bus master)
both accessing the 60x bus. I believe the fault was in the CPM itself.
The solution was to keep the CPM off the 60x bus, and instead use some
local bus ram for all the BD's and buffers. Also the GBL bit would be set to
0 also or there would be trouble. Our local bus ram was non-cacheable.

Our symptoms were strange crashing, strange addresses appearing on the bus,
just general flaky behaviour. If we had no external bus master, the system
was rock solid. Once an external bus master took control of the 60x bus
there would be trouble. I posted to this list more detailed information, so
it will be in the archives.

-Dave

>Dan,
>
>Could you elaborate on the problems associated w/ bus timings that
>you've seen on the 8xx?  We've been seeing a lot of unexplained Oops
>messages (and even crashes) on one of our hardware platforms.  The only
>common thread seems to be dereferncing bad pointer values, but they
>occur in so many different places...
>
>I've asked our hardware guys to take a look at the settings for the UPM
>we are using to control SDRAM.  Do you think we are on the right track?
>Can you provide any guidance?
>
>Thanks in advance for any help you can provide!  I'll buy you a beer and
>some maple candy the next time I'm up your way! :-)
>
>John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
