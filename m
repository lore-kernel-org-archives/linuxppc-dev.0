Date: Thu, 6 Sep 2001 17:10:02 -0400
From: Armando Di Cianno <armando@nycap.rr.com>
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Cardbus issues on TiBook
Message-Id: <20010906171002.26712d35.armando@nycap.rr.com>
In-Reply-To: <3B97DA58.6894B342@acm.org>
References: <3B97DA58.6894B342@acm.org>
Reply-To: diciaa@rpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 06 Sep 2001 13:19:36 -0700
Ira Weiny <iweiny@acm.org> wrote:

> As some of you may know I am trying to get an IBM microdrive working on
> my TiBook.  I know there is an issue with irq's which I am trying to
> work out but I have run into another issue I don't understand.

Uhmm, I have my microdrive working fine on my TiBook.  It maintains a happy little crypto filesystem for quick and easy removability. Ahh, the joys of being paranoid.

Anyway, here's what I did to make it work and my current config:
- 2.4.9 (benh0)
- built all pcmcia stuff from the kernel itself (pcmcia support compiled in, pcmcia ide support as a module)
- updated pcmcia package to rebuild the userspace controls (just wanted to update for no particular reason)

Now, I needed to change some things in two files, however both changes to do were mentioned in the pcmcia package README.
- /etc/pcmcia/config
--+ change every instance of 'ide_cs' to 'ide-cs' (someone changed this in the kernel source when they last monkeyed around with it) or that module will not load correctly
- /etc/pcmcia/config.opts
--+ if you have the 'default' config.opts file, after "# System resources available for PCMCIA devices" there are, I think, 3 lines (I deleted the incorrect ones) that start with 'include port' and 'include memory', comment-out/remove thouse lines and use this:
--------------
include port 0x100-0x4ff, port 0x1000-0x17ff
include memory 0x80000000-0x80ffffff
--------------

You should now be golden.  Hope that helps!

__Armando Di Cianno
diciaa@rpi.edu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
