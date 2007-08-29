Return-Path: <jofsama@yahoo.com>
Received: from web51603.mail.re2.yahoo.com (web51603.mail.re2.yahoo.com
	[206.190.38.208]) by ozlabs.org (Postfix) with SMTP id 50FE3DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 14:25:54 +1000 (EST)
Date: Tue, 28 Aug 2007 21:19:13 -0700 (PDT)
From: Jarrod O'Flaherty <jofsama@yahoo.com>
Subject: Where to put tip to fix very jerky mouse on iBook G3?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <221915.41093.qm@web51603.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
 
SHORT VERSION:
--------------

1. I had a problem with my USB mouse on an iBook G3.
2. It took a lot of hard work to solve the problem.
3. I'd like to know where to put my solution for others to find (and find easily!
;).

For more details read on...


LONG VERSION:
-------------

I am wondering where I should put this tip/solution I worked out for fixing a very
jerky mouse pointer under X on my iBook G3.
 
The problem goes something like this:
 - While running X (happens in both Gnome and KDE)
 - and using the mouse
 - the pointer will freeze 
 - at irregular intervals
 - for about 0.5 sec or so
 - then jump, to where it (probably?) "should be"
 - by which point I have "over moved" the mouse
 - and missed the button I was trying to hit
 - all of which
 - results in a system which is very hard to use.

I noted that the problem was *less* pronounced when the system was under heavy load
(eg. by running system monitor - which takes a lot of CPU!). This made sense once I
discovered the cause of the jerkiness.

The specs of the machine/setup are:
 - Apple iBook G3 600MHz
 - 384 MB RAM
 - USB Mouse Connected
 - Debian Etch (4.0)

And uname -a gives:
 >> Linux ibook3 2.6.18-5-powerpc #1 Sun Aug 12 21:01:27 UTC 2007 ppc GNU/Linux
 
So, as for the solution...

It turns out the cause is apparently the CPU frequency switching done by (power
saving part of) the linux kernel.

I don't believe the issue is necessarily with the kernel itself, though I could be
wrong. It seems more likely it is some hardware problem, where a CPU frequency
change causes a pause in processing. And perhaps only with this generation and model
of iBook?

For anyone else who has this problem, my tip is to: 
 - Try disabling the cpu frequency switching of the linux kernel.

To do so, my current method is to execute:
 >> echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

This confines the governor to using a range between 600 and 600MHz, instead of
between 400 and 600MHz as it is at bootup, which effectively disables frequency
switching.

It took me about 2 days to work out the cause and above solution. I actually found
one very fleeting hint indicating a link between such system hiccups and CPU
frequency changes on a website while Googling early one, but it was another 1.5 days
before, after trying a bunch of other methods, I decided I really should work out if
completely disabling it would do the trick. Playing with governors, which I did at
various points, did seem to help some, but didn't make the problem disappear
altogether. 

Unfortunately, no amount of Googling since then has brought up that "life saving"
site, or any other that mentions anything similar. So I guess I was very lucky I
found it!

I also guess not too many other people have suffered this problem, since, as I said,
I can't get much on Google about the issue. But just in case someone does try
installing Debian + Linux 2.6 on an iBook G3 and does just happen to have the same
problem crop up, I thought I should park my tip somewhere they would be able to find
it.

My question therefore is:
 > Where should we be putting such tips on issues with Linux on iBook hardware?

Any and all advice is appreciated (including how to disable frequency switching
permanently!).
 

Cheers,
Jarrod.
