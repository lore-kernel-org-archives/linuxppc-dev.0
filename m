Date: Wed, 10 Jan 2001 14:28:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: menuconfig for PPC860T
Message-ID: <20010110142820.D29237@opus.bloom.county>
References: <Pine.GSO.4.21.0101090955400.18580-100000@eos> <3A5B5604.36EF3E2E@mvista.com> <20010109204801.A28095@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010109204801.A28095@opus.bloom.county>; from trini@kernel.crashing.org on Tue, Jan 09, 2001 at 08:48:01PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 09, 2001 at 08:48:01PM -0700, Tom Rini wrote:
>
> On Tue, Jan 09, 2001 at 01:18:44PM -0500, Dan Malek wrote:
> > Brian Ford wrote:
> >
> > > For about the last week, make xconfig has stopped working for the
> > > EST8260 board in the 2.5 bk tree.  It dies with:
> > >
> > > make[1]: Entering directory `/home/ford/linux/src/linuxppc_2_5/scripts'
> > > cat header.tk >> ./kconfig.tk
> > > ./tkparse < ../arch/ppc/config.in >> kconfig.tk
> > > statement not in menu
> > > make[1]: *** [kconfig.tk] Error 1
> >
> > Aside from this, I don't think anything but the manual 'make config' has
> > ever worked for the 8260.  The problem is I set two processor type
> > configuration variables, CONFIG_6xx and CONFIG_8260.  Most of the
> > scripts try to be "smart" and only allow one to be set.  I know
> > 'make menuconfig' doesn't work properly, I suspect 'make xconfig'
> > does the same (unless Tom has fixed this recently :-).
>
> I actually fixed menuconfig recently, in the 2_5 bk tree.  I'll try xconfig
> tomorrow and attempt to fix it.

Ok, I found the problem.  xconfig doesn't bother to parse sub menus.  So what
was killing it was dep_bool 'Some OF proc thing' CONFIG_SOMETHING
$CONFIG_FS_PROC, because CONFIG_FS_PROC is in fs/Config.in, which doesn't get
parsed until you click on the button(!).  I just fixed this in 2_5, by moving
the questions to fs/Config.in.  But I don't know if this will be blessed in
the end.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
