From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook hang from post-sleep cdrom access - fix
Date: Thu, 27 Jul 2000 12:36:11 +0200
Message-Id: <20000727103611.19275@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.10.10007271058170.18614-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10007271058170.18614-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Should be called from the IDE notify chain perhaps. See the last function
>in ide-pmac().

Yep, this should be done juste before the pmac_ide_dma_onoff() call in
ide-pmac.c/idepmac_notify_sleep(). It should be done regardless of the
disk beeing in a bay or not since new machines will ultimately support
sleep on desktop boxes too. Something like

switch(drive->media) {
  case ide_disk:
    // spin up the disk
    break;
  case ide_cdrom:
    // do whatever you need here
    break;
  case ide_floppy:
    // do whatever you need here
    break;
}

Note that at his point, IDE interrupts have been re-enabled, so we should
be careful about the way the IDE layer is called from here.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
