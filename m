From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
Date: Thu, 27 Jul 2000 15:12:40 +0200
Message-Id: <20000727131240.11712@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.10.10007271407230.23151-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10007271407230.23151-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Aye. Can you be more specific about 'do whatever needs to be done'? Can I
>just send the disk a read command to wake it up? Send a reset
>command?? Will a reset command hurt if I always send a drive reset
>there?

I don't know yet ;) I have to look more closely at my ATA spec. It may
not be necessary to wakeup the disk in fact, the current code seems to be
ok for the hard disk once the timeout has been bumped.

What bugs me is that on wakeup, the CD-ROM should automatically send a
request unit attention on the first command to signal a disk change. So
in theory, sending the media change command should not be necessary.
Well, it can do no harm, I'll see what can be done.

>I'll try that on my Lombard to see if I can save the nasty timeout when
>the drive was powered off with hdparm -Y ?? That would help fake sleep
>mode on the Pismo, or did you implement pmu sleep/wakeup there yet?

Not yet, i've not yet figured out all the details, this machine seems to
be more complicated to put to sleep (and to wakeup) than older ones, and,
as usual, I have absolutely no docs nor specs.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
