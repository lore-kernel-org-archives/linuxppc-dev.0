Date: Sat, 23 Sep 2000 18:09:24 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: R Shapiro <reshapiro@mediaone.net>
cc: Michel Dänzer <daenzerm@student.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <14796.52485.753924.552345@ipa.ne.mediaone.net>
Message-ID: <Pine.LNX.4.10.10009231802380.1165-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > > Specifics: with the ati driver selected, xf throws away my mode def,
>  > > since it thinks (incorrectly) that there isn't enough vram,
>  >
>  > Does it probe the correct amount of VRAM? Do you use Option "UseFBDev" ?
>
> The xf probe says 2MB, but in fact I have 4MB.  The dmesg line says:

That might be due to a bug in the ati driver (last time I rsynced in
mid-July, there was a bug in Mach64PPCPreInit:


	pScrn->videoRam = fbdevHWGetVidmem(pScrn) / 1024;

	/* hack */
	pScrn->videoRam = 2048;

	/* TODO kludge for GI chip */

	pATI->VideoRAM = pScrn->videoRam;

The hack to unconditionally set pScrn->videoRam to 2M should be removed,
that should be all. I was planning to send Ani another patch as soon as
the 16 bit color stuff was solved but I never got around to it (neither
solving the 16 bit problem nor sending a diff), sorry.

> I just rebuilt it myself, with the rsync xfree, on the G4.  The
> rebuilt version works fine there (I'm using it now) with the r128
> driver.  I won't be able to test the newly built ati driver on the G3s
> until Monday.  Can I just move that driver to the drivers diretory of
> the current installation on the two G3s, or do I need to do a complete
> rebuild/reinstall on each of them?

Just copy ati_drv.o over.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
