MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16026.33208.382857.751115@gargle.gargle.HOWL>
Date: Mon, 14 Apr 2003 11:39:04 +0200
From: mikpe@csd.uu.se
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.x swim3 performance problem on PM4400 identified
In-Reply-To: <16005.35950.570218.844672@nanango.paulus.ozlabs.org>
References: <16004.27866.270601.561756@gargle.gargle.HOWL>
	<16005.35950.570218.844672@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras writes:
 > Mikael Pettersson writes:
 >
 > > With 2.4 kernels, writes to floppy are about a factor of 10 slower
 > > on my PowerMac 4400 than they are with 2.2 kernels.
 > >
 > > The cause for this is a poll-loop in swim3.c which doesn't exist
 > > in the 2.2 version. The patch below reverts that change, and
 > > restores floppy write performance to 2.2 levels. I've built many
 > > boot floppies with this modified driver w/o any problems.
 >
 > This finally prodded me to look at the mach driver.  I've hacked the
 > linux swim3 driver to do things in a more similar fashion to what the
 > mach driver does.  It now seems to not get stuck on the dreaded 04
 > error and generally seems a lot more robust.  Try this patch and let
 > me know how it goes.

I finally got around to testing your updates to swim3.c. I haven't
observed any problems with it, and it solved my slow-writes problem.
Great work -- thanks.

There are two compile warnings on unused variables 'swim3_buf' and
'max_wait_inactive' that your update introduces. Did you intend
to use them or what?

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
