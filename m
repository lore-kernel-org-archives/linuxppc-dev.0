Message-ID: <3BF65B8B.EB015B30@intrex.net>
Date: Sat, 17 Nov 2001 07:43:55 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>, Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax>
		<20011116045737.A24130@cx258813-a.chnd1.az.home.com>
		<20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net>
		<20011116094210.B3473@beef.az.mvista.com>
		<20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net>
		<3BF5A01D.4040502@embeddededge.com>
		<20011117114330.G12763@zax>
		<20011116191832.D9923@cpe-24-221-152-185.az.sprintbbd.net> <15350.18199.593968.834376@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just a note that might influence you.  The sprs of each 405 will be the same,
but there is NO gurantee that the DCR, any of them look anything like any
other DCR in any other DCR.

I suggest core, chip, and then platform specfic.

Chip

Paul Mackerras wrote:

> Tom Rini writes:
>
> > > No need - the board's platform_init() can call the processor general
> > > functions if necessary.
> >
> > But why not do this once instead of many times?  Right now, each of the
> > 405GP 'board' file would look awful similar.  I think what Dan said
>
> As a philosophical thing, I think it is better to give control to the
> platform-specific code early and let it call back to generic stuff.
> This is very much the Linux philosophy - it's basically what Linus did
> with the USB code for instance (the old code worked its way down
> through several layers to the HCI driver, Linus' new code called
> straight into the HCI driver which then called a library of support
> routines).
>
> I think that each platform (ep405, walnut, etc.) should have its own
> platform_init(), and if all that does is ppc405_init(), that's fine.
> The fact that we have board_init() at present suggests that some
> platforms will do more than just ppc405_init.  And having a
> platform_init() for each platform is consistent with our approach on
> other platforms as well.  Then ppc4xx_setup.c becomes a library of
> pieces of code that can be called or not as appropriate.
>
> Paul.
>

--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
