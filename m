From: Benjamin Herrenschmidt <bh40@calva.net>
To: Matthias Pfisterer <Matthias.Pfisterer@gmx.de>,
        Iain Sandoe
 <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: internal speakers on Pismo
Date: Sat, 29 Jul 2000 00:16:34 +0200
Message-Id: <20000728221634.5701@192.168.1.10>
In-Reply-To: <3981F1F7.9314DAD3@gmx.de>
References: <3981F1F7.9314DAD3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I got it working here too. I've pushed changes in my rsync tree
(dmasound 2.2, I'll take care of 2.4 later, I'll send you patches, Iain).

Basically, clearing the additional registers is not what made it work as
I originally expected ! What made it work was _not_ to enable the
parallel port output. However, it is needed on some machines. So what I
did was to enable it conditionally in a way similar to what Darwin does.
I also fixed up detection of screamer chips.

Oddly, the master volume doesn't work (but the speaker volume does).
Also, Apple code has some weird thing: They detect two different device-
id's for new iMacs (DV/SE). One is an inverted version. But they only
enable the parallel output one of them. I don't know if it's normal or if
it's actually a bug in their code. I did the same thing but left the case
of normal iMacDV in comments, so users of this machine can try and see if
it helps. I suspect that like other iMacs, there's an I2C amplifier/SRS
module that needs to be setup too, but I'm not completely sure.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
