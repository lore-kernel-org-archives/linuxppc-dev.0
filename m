From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Thu, 10 Aug 2000 00:48:02 +0200
Message-Id: <20000809224802.27760@192.168.1.10>
In-Reply-To: <Pine.HPX.4.10.10008092142330.22126-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008092142330.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I strongly suspect that we might want a single rtc access function in
>ppc_md and add a first parameter telling what we want it to do, the second
>being a pointer to a tv_sec, and perhaps more parameters.
>
>[.../...]
>
>This last function could also be performed by returning the timebase in
>the READ_TIME function as an extra parameter. The best solution is the one
>which gives the minimal permanent kernel size, __init code size is
>irrelevant.

Ok.

>What use does it have if no daemon will change the timezone anyway ?

Well, when travelling with a PowerBook, you tend to regulary change the
timezone, and you like the kernel to remember what it was ;) Paul added
the write back of the sys_tz, so I beleive he has some userland tool to
set it too, Paul ?
With this current code, any write to our pmac-specific /dev/rtc will
cause ppc_md.set_rtc_time to update both the RTC and the xpram sys_tz.

So either we make a userland tool for that, or eventually add such a
feature to pmud along with other PowerBook-specific tasks, accessing /
dev/nvram directly, or we find a way to make sure updates to sys_tz are
written back to nvram. I was not specifically thinking about results of a
DST change. We could eventually add this code along with other nvram
write code (for flash based nvram) in the restart/shutdown routines if we
don't want to do it from every ppc_md.set

>How does MacOS handle DST changes (on the fly or only at reboot) ?

On the fly.

>You never (well hardldy ever) pass localtime to userland in Unix and
>that's a big big big plus, each process/user can set TZ as it wishes. IOW
>the value of sys_tz is at best a system wide default but is not imposed to
>anybody. Here at the telescope on all Linux machines, /etc/localtime is
>set as UTC, but then I set TZ=Europe/Madrid in my .profile to avoid too
>much confusion with my PC which has localtime set to Europe/Madrid.  And
>right now I am running a shell with TZ set to Pacific/Tahiti to believe
>that I'm on holiday ;-)

Ok, I understand that. That's indeed a nice feature. Changing the
"global" timezone is specifically useful for portables. You can consider
it as the machine's physical location instead of a kind of "global" timezone.

>Done and booted (although I will probably orphan the changeset).

Heh ;)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
