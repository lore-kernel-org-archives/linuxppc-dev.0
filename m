Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0401291029360.2221-100000@opal.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0401291029360.2221-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1075378209.1241.34.camel@gaston>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 23:10:09 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-29 at 20:30, Michael Schmitz wrote:
> > > OK. I put a mdelay(100) between the PMU_SYSTEM_READY request and the
> > > pmu_suspend() call in pmu_sys_resume and it seems to work so far. Side
> > > note: if you are saving a large system and have multiple swap files, play
> > > with swap priorities to make sure the pages are swapped out to the file
> > > _not_ used for suspend.
> >
> > Hrm... Remove the PMU_SYSTEM_READY, it's a bug to call it on a 101...
> > And it's not needed anyway.
>
> I'm trying a if (pmu_kind != 3) around that call - should it rather be <= 3 ?

Just remove it for you tests. Only KEYLARGO based PMUs have this call

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
