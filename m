From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Costabel <costabel@wanadoo.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Benh-2.4.4-pre3 kills linuxconf
Date: Thu, 19 Apr 2001 22:12:34 +0200
Message-Id: <20010419201234.23660@smtp.wanadoo.fr>
In-Reply-To: <3ADF422F.CBC1EC7@wanadoo.fr>
References: <3ADF422F.CBC1EC7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>For a long time, I have been using linuxconf to switch between home and
>office configurations on my iBook. This worked up to kernel version
>2.4.4-pre1 (rsynced from the benh tree on April 12). With 2.4.4-pre3,
>rsynced yesterday, linuxconf doesn't work any more. When I type
>"linuxconf", it just sits there and waits, doing nothing. When I stop it
>with ^C, then subsequent calls of linuxconf come back immediately saying
>"Broken pipe." The kernel config is the same in both cases.
>
>Has anyone seen this?

No, but I don't use linuxconf...

>I am trying newer kernels mainly because of the recent improvements in
>the pmud and the firewire subsystems. I am still hoping that one day my
>iBook will be able to sleep *and* wake up correctly. Until now it
>sleeps, but usually crashes after wakeup, or at least the network
>system, ethernet and airport, is dead until the next reboot. My firewire
>disk (the old 10GB IBM travelstar, free after I upgraded the iBook to
>20GB, put into a firewire+USB enclosure) doesn't work either, even with
>all the recent ieee1394 patches applied :-(

Well, I didn't notice the ethernet problem. Does it happen if you
ifconfig the interface down before sleep and back up after sleep ?
Airport is known to not survive to sleep, you have to bring it down
before and back up after. If you forget, bringing in down and back up
should get it back as well.

Does it work with another kernel or without sleep ? I have not yet
written any specific code to handle firewire sleep, so it's possible that
it doesn't survive well to sleep. In that case, you can also try
rmmod'ing the IEEE1394 host controller driver before sleep and insmod'ing
it back up after wakup.

Tell me if any of these helps.

Also, do you experience crashes (not related to the above issues) when
sleeping from X ? I know there are still some problems related to console
sleep.

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
