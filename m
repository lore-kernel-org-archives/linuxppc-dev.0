Date: Thu, 10 Aug 2000 05:08:10 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809224802.27760@192.168.1.10>
Message-ID: <Pine.HPX.4.10.10008100048080.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 10 Aug 2000, Benjamin Herrenschmidt wrote:

> >This last function could also be performed by returning the timebase in
> >the READ_TIME function as an extra parameter. The best solution is the one
> >which gives the minimal permanent kernel size, __init code size is
> >irrelevant.
>
> Ok.

So now it might be time to start coding :-)

> >What use does it have if no daemon will change the timezone anyway ?
>
> Well, when travelling with a PowerBook, you tend to regulary change the
> timezone, and you like the kernel to remember what it was ;) Paul added
> the write back of the sys_tz, so I beleive he has some userland tool to
> set it too, Paul ?

Perhaps timeconfig does this.

BTW, from hwclock manual on my PC about DST:

       locality at the present time.  In practice, the  DST  part
       of the timezone value is almost never used, so if the geo-
       graphical part were to be set to its  correct  value,  the
       users  of  the  timezone  value would actually compute the
       wrong local time.

       Therefore, hwclock violates the definition of the kernel's
       timezone  value  and always sets the DST part to zero.  If
       DST is supposed to be in effect, hwclock  simply  adds  an
       hour to the geographical part.

So it's still another convention, where as usual theory and practice
are different, but in practice match MacOS RTC. My head hurts...

Given the broken FAT code which needs fixing, couldn't we simply decide
that DST in the kernel is merely informative and that
localtime = UTC - sys_tz.minutes_west (hopefully I got the sign right).

> With this current code, any write to our pmac-specific /dev/rtc will
> cause ppc_md.set_rtc_time to update both the RTC and the xpram sys_tz.
>
> So either we make a userland tool for that, or eventually add such a
> feature to pmud along with other PowerBook-specific tasks, accessing /
> dev/nvram directly, or we find a way to make sure updates to sys_tz are
> written back to nvram. I was not specifically thinking about results of a
> DST change. We could eventually add this code along with other nvram
> write code (for flash based nvram) in the restart/shutdown routines if we
> don't want to do it from every ppc_md.set

I have no strong feeling about this, maybe I'll have the day I can afford
a PowerBook ;-)

>
> >How does MacOS handle DST changes (on the fly or only at reboot) ?
>
> On the fly.

Ok, that changes a few things in the equation. But I would not like to
type `make' around a DST change on a filesystem which uses local time.

> Ok, I understand that. That's indeed a nice feature. Changing the
> "global" timezone is specifically useful for portables. You can consider
> it as the machine's physical location instead of a kind of "global" timezone.

I still don't get it. For my portable physical location would be my house,
and I might change TZ or /etc/localtime when I travel, but if I have a
filesystem which uses localtime, I would prefer these to be correct for
the most frequent case: when I'm at home. Otherwise it becomes a nightmare
when you have a mixture of local time and UTC filesystems:

- I'm in California, I do a copy from ext2 to hfs with local time set to
Pacific coast (GMT-8).

	ext2 timestamp 6 pm, hfs time 10 am
	I reboot under MacOS (why not), modify the file, let us
	say that it takes an hour so the modification time is now 11am
	Reboot under Linux, ls shows ext2 at 10 am, hfs at 11am

- now I go back to Europe, I change the kernel timezone to Madrid (GMT+1)

	ls shows now 7pm for ext2, but 12am for hfs, so the timestamp
	order has been screwed up.

My opinion is that any change which make potentially reorder timestamps
between file systems is so bad that it should be avoided at all costs.

Conclusion: you should never change the kernel timezone if you don't want
this to happen and you have a mixture of UTC and non UTC filesystems.
(Note that I did not put a network transfer in the example, if you do
this, you rapidly reach the conclusion that you must be able to always get
the timestamps back to UTC from whatever the filesystem stores).

Hmm, from what I see, HFS+ seems to use UTC filestamps. That's fine.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
