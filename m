Date: Thu, 27 Jul 2000 14:12:56 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
In-Reply-To: <20000727103611.19275@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10007271407230.23151-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Should be called from the IDE notify chain perhaps. See the last function
> >in ide-pmac().
>
> Yep, this should be done juste before the pmac_ide_dma_onoff() call in
> ide-pmac.c/idepmac_notify_sleep(). It should be done regardless of the
> disk beeing in a bay or not since new machines will ultimately support
> sleep on desktop boxes too. Something like
>
> switch(drive->media) {
>   case ide_disk:
>     // spin up the disk

Aye. Can you be more specific about 'do whatever needs to be done'? Can I
just send the disk a read command to wake it up? Send a reset
command?? Will a reset command hurt if I always send a drive reset
there?
I'll try that on my Lombard to see if I can save the nasty timeout when
the drive was powered off with hdparm -Y ?? That would help fake sleep
mode on the Pismo, or did you implement pmu sleep/wakeup there yet?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
