Date: Sun, 22 Jul 2001 15:15:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: kernel ftp ?
Message-ID: <20010722151518.A6437@work.bitmover.com>
References: <20010716111241.M29668@work.bitmover.com> <Pine.LNX.4.10.10107162014480.20269-100000@zirkon.biophys.uni-duesseldorf.de> <20010716115734.P29668@work.bitmover.com> <20010722153020.A13085@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010722153020.A13085@altus.drgw.net>; from hozer@drgw.net on Sun, Jul 22, 2001 at 03:30:20PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> fact, BK takes MORE bandwidth than rsync on a 'clone' operation because it
> has to ship the complete revision history along.

Wow.  Amazing insight, that.  You could say "copying 100MB takes MORE
bandwidth than copying 50MB because you have to ship the second 50MB",
and that would be an equally amazing insight.

> I think rsync has beaten you to the punch... it's already used to mirror
> most of the major source repository out there, and it doesn't care if the
> data is source code, tarballs, pictures, or whatnot. It also only
> transfers data that has changed, like bk. I will admit that BK is finer
> grained that rsync and transfers less uneeded stuff, but they are both
> still on the same order of magnitude.

That may be true for small sites, but it doesn't scale.  People tend to
update automatically, i.e., out of cron.  A null pull of a BK tree will
transfer about 9KB for the whole operation and will stat/open less than
ten files.  Rsync will stat *every* file.  In other words, rsync places
a load on your server proportional to the number of files, not number of
repositories.

The number of repositories that you could host with BK is orders of
magnitudes higher than the number you could host with rsync, holding
the bandwidth/disks/memory/CPU constant.

It's not rsync's "fault", rsync has no mechanism to know what changed
other than looking at everything, BK records that once at commit time
and then it just knows.  Rsync is great at what it does, but that
doesn't mean that what it does is the only thing that needs to be done
nor is it the best way to do it.

The fact that you can host a handful of trees on a machine with lots of
CPU and memory is rather unimpressive.  Multiply that by 10,000 and get
back to me.

If I sound sarcastic, good, I intend to be.  People being wasteful is
distasteful to me.  We live in a world of finite resources and people
constantly think there will just be more.  More money, more electricity,
more bandwidth.  That stuff is not free, someone is paying for it.

I get the feeling that you, Troy, are just arguing to win the argument
because you want to win.  That's called winning the battle and losing
the war.  Not widely considered to be a smart approach.  How about you
use your smarts to waste less instead of winning meaningless battles?
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
