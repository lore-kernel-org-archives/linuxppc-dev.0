Date: Wed, 16 Jan 2002 19:59:33 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Gavin Hemphill <hemphill@drea.dnd.ca>
Cc: Larry McVoy <lm@bitmover.com>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <3C459C8B.1020203@drea.dnd.ca>
Message-ID: <Pine.LNX.4.33.0201161946310.21073-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Jan 2002, Gavin Hemphill wrote:

>
> Couldn't the pre-trigger actually check with an ntp server at the bk end
> and put up a warning if the commit times are off by "too much".

It is simpler to have the clock of the server be phase-locked on an NTP
server. I don't know where the bk servers are located but they almost
certainly have an NTP server within 100ms RTT (round-trip time). If
paranoid, the pre-trigger script could even refuse any changeset as long
as the local clock is not phase-locked, i.e., during the first few minutes
after a reboot (however the ntpdate <time-server-host> which is performed
normally during boot scripts to initially set the clock before starting
the NTP daemon should be more than sufficient).

Besides that, this is a good idea, it should only check the timestamp on
the Changeset is not in the future (bk already ensures that timestamps
ordering in the graph of changesets). A time well in the past is
acceptable since a changeset or set of changesets can be pushed well after
being done in a private tree.

After this, a developer with a bad clock can either wait to push
(if it's only a few minutes or hours in the future) or undo and redo his
changeset(s) if his/her clock was far too much in advance.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
