Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DCC1667A60
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 08:17:31 +1000 (EST)
Date: Tue, 30 May 2006 00:17:30 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Done] Re: snd-aoa: Sound gone after snd-aoa updates, on PB5,8
Message-ID: <20060529221730.GA3138@localhost>
References: <20060529020027.GA3107@localhost> <20060529021756.GB3107@localhost>
	<1148869725.3918.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148869725.3918.12.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

Sorry for responding a bit late: I had to leave the house today ...


On Mon, May 29, 2006 at 12:28:45PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-05-29 at 04:17 +0200, Wolfgang Pfeiffer wrote:
> > On Mon, May 29, 2006 at 04:00:27AM +0200, Wolfgang Pfeiffer wrote:
> > > 
> > > Hi
> > > 
> > > After some updates from http://johannes.sipsolutions.net/snd-aoa.git/
> > > in the last few hours/minutes sound's gone here. Without changing
> > > sound settings intentionally here. 
> > > 
> > > 
> > 
> > On Debian/unstable:
> > After downgrading libasound2 from 1.0.11-6 to 1.0.11-3 I have sound
> > again: 1.0.11-6 was, IINM, installed a few hours ago, which
> >  - as it seems - broke sound here.
> 
> Have you tested that it wasn't just the renaming/re-ordering of some
> controls ? Alsa is pretty bad with that, you may just have to go back to
> alsamixer and reset some controls after updating the driver.

That's what I tried after reading your mail:

$ apt-cache policy libasound2
libasound2:
  Installed: 1.0.11-6
  Candidate: 1.0.11-6

The problem is: with libasound2 1.0.11-6 I cannot even *start* 
alsamixer:

------------------------
$ alsamixer
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL default

alsamixer: function snd_ctl_open failed for default: No such file or directory
-------------------------

----------------------------
$ alsamixer -c 0  
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0

alsamixer: function snd_ctl_open failed for hw:0: No such file or directory
---------------------------

amixer:

------------------------
$ amixer -dD controls
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL controls
amixer: Mixer attach controls error: No such file or directory
---------------------------


But the last 2 examples may hint amixer at least sees some sound card:

---------------
$ amixer -c 1 controls
Invalid card number.
Usage: amixer <options> [command]

Available options:

[ ... ]
---------------------


-------------------
$ amixer -c 0 controls
ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
amixer: Control hw:0 open error: No such file or directory
-----------------------

Suggestions? Did I miss something?

Thanks in anticipation

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
