Message-ID: <37DC9FFF.5C5A18F7@wanadoo.fr>
Date: Mon, 13 Sep 1999 08:55:59 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Joshua M. Thompson" <funaho@jurai.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
References: <Pine.LNX.4.10.9909130140010.29981-100000@ifurita.jurai.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Joshua M. Thompson" wrote:
> 
> On Sat, 11 Sep 1999, Martin Costabel wrote:
> 
> > I had seen the typo in drivers/char/Config.in, but forgot to correct it.
> > And then it seemed more logical to have the selection of ADB_MOUSE next
> > to ADB_KEYBOARD, but maybe it isn't.
> 
> It is more logical, and that's the way I have it listed on the 68K Mac
> port. What I believe should happen is that the ADB keyboard driver should
> be put in drivers/char where the mouse driver already resides. Then they
> can both be listed next to each other in the drivers/char/config.in file,
> bracked by a nice clean 'if [ "$CONFIG_ADB" = 'y' ];'

It's not so clear to me now. If one thinks of menus as in 'make
{x|menu}config', there is a submenu for mice, but nothing for keyboards,
probably because for PCs there is basically only one keyboard (?). When
USB support matures, this will have to change, I guess.

Another small nit to pick: The adbmouse driver is offered as a module,
but it doesn't compile when CONFIG_ADB_MOUSE=m is selected. The reason
is this new
__setup("adb_buttons=", adb_mouse_setup);
line which is a fallout from the implosion of init/main.c.
In <linux/init.h>, __setup is only defined #ifndef MODULE. I don't know
how other drivers handle this problem; in vger-2.3.18, the popular
"atyfb=" kernel argument seems to have disappeared completely, for
instance.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
