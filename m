Date: Sun, 23 May 2004 23:47:04 -0700
From: Jamie Heilman <jamie@audible.transient.net>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BriQ & Linux 2.6
Message-ID: <20040524064703.GI1946@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net> <1085181034.6755.7.camel@gaston> <20040521233523.GJ8520@audible.transient.net> <1085199239.9230.4.camel@gaston> <20040522064520.GM8520@audible.transient.net> <1085209944.9234.7.camel@gaston> <20040522193639.GO8520@audible.transient.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040522193639.GO8520@audible.transient.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well played around with the pcnet32 driver, reverting some of the
changes since 1.27a, and it didn't help at all, so I gave up on that
problem and focused on the spontaneous rebooting.  SMART tests on the
disk revealed nothing, acording to the selftests everything is fine.

On a whim I removed the gargoyle expansion board from the briq, and lo
and behold - stability improved dramatically.  Its hard to know why it
helped.  But more disturbing is that it didn't solve the issue by a
long shot.  So I ran bonnie++ for a few itterations ... and it worked
flawlessly (in 2.6.6-bk8).  Then I ran:
while :; do tar jxf linux-2.6.6-bk8.tar.bz2; echo -n .; done

The second time through the machine spontaneously rebooted.  :-(
So I booted up 2.4.24-2004021601briq from TI's site, reran the above
test, and it got through about 4 itterations before it locked up hard,
and VFD went dark (didn't reboot).  So then I stepped back to
2.4.23-2004012801briq also from TI... ran the test again, got maybe 1
itteration further and locked up again.  So, swearing up a storm, I
booted up 2.2.19 and ran the test again, this got through quite a few
itterations (like around 11 or 12) but in the end the machine still
locked up and the VFD went dark.

Frustrating; I'm starting to wonder if the software is the real issue
though.

--
Jamie Heilman                     http://audible.transient.net/~jamie/
"I was in love once -- a Sinclair ZX-81.  People said, "No, Holly,
 she's not for you." She was cheap, she was stupid and she wouldn't
 load -- well, not for me, anyway."                     -Holly

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
