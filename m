In-Reply-To: <37EE3B3A.F40E0D62@netx4.com>
Date: Mon, 27 Sep 1999 10:57:28 +0200
To: Dan Malek <dan@netx4.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: SndConfig for Linux/PPC
Message-Id: <19990927105728.005663@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Sep 26, 1999, Dan Malek <dan@netx4.com> wrote:

>What version are you looking at?  The current version works and
>has mixer support.  The Rigth Way is always a personal opinion,
>and rewriting something for the sake of changing variable names
>or personal coding style is a waste of time.
>
>If you decide you have time to waste on this, make sure you start
>with the latest 2.3.x version, and ask me for all of the updates
>I have queued to test and check in over the next couple of weeks.

By the way, if someone is working on the sound driver, I'd be glad if
this person could have a look at the sleep/wakeup code and especially
make sure it works fine when a sound is currently playing. (In this case,
playback should be either resumed on wakeup or samples just killed and
the driver would then wait for more samples).

It works fine on my machine, but several users are experiencing trouble
with it, and I won't have time to do much work on linux this week. (With
luck, I'll be able to finish the new BootX version and cleanup a couple
of patches I have here, but that's all).

It looks like when atyfb.c is present, sleep tends to keep sound alive
which is not the case when disabling atyfb. The main difference is that
atyfb introduces a pause of approximately 500ms before the actual sleep
(and just after the wakeup).

Also, Geert, I don't know if you manage to find better default values for
MCLK, but it looks like the hangs on sleep/wakeup with chipID = 4c50 are
due to too high MCLK values. Lowering down the MCLK to 60 allowed one
user to sleep and wakeup without my horrible hack (which was to abort the
wait-chip-to-be-suspend when chipID 4c50 is encountered). 
I'm wondering if we should add code to limit the default MCLK (unless
manually specified) to 60 on the chips known to be in powerbooks. (or do
this whenever we are on a powerbook).


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
