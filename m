Date: Tue, 27 Aug 2002 17:36:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: acurtis@onz.com
Cc: dan@embeddededge.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260/8xx Embedded Boot patch
Message-ID: <20020828003612.GD22875@opus.bloom.county>
References: <20020828002353.GB22875@opus.bloom.county> <20020827172829.3580.h002.c007.wm@mail.directvinternet.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020827172829.3580.h002.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 27, 2002 at 05:28:29PM -0700, acurtis@onz.com wrote:
>
> > The first thing I saw was the define_bool CONFIG_ALL_PPC n.
> > If this was actually needed someplace, there's a bug there that needs to
> > be fixed.
>
> This is not required. All of the xxxx8260_defconfig files define this so you do
> not get all of the generic Mac stuff like IDE and video. If it is not appropriate
> take it out. It just serves to weed out a lot of options you are just going to
> turn-off anyway.

They shouldn't show up on 8260, since they don't show up on other,
non-CONFIG_ALL_PPC platforms.  Again, if they show up it's a bug.  The
bug is doing:
dep_{tristate,bool} 'Some pmac-specific driver' CONFIG_PMACSPEC $CONFIG_ALL_PPC
It should be:
if [ "$CONFIG_ALL_PPC" = "y" ]; then
   {bool,tristate} 'Some pmac-specific driver' CONFIG_PMACSPEC
fi

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
