Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4294DDE00
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 20:18:38 +1100 (EST)
Message-ID: <45A20C66.8060506@genesi-usa.com>
Date: Mon, 08 Jan 2007 09:18:30 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>	
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	
	<45A1535C.1080007@genesi-usa.com>
	<1168222654.14763.92.camel@shinybook.infradead.org>
In-Reply-To: <1168222654.14763.92.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> On Sun, 2007-01-07 at 20:09 +0000, Matt Sealey wrote:
>> I would expect that it is so much easier, even if it does not strike
>> you as too "clean", to forget about naming compatibility nodes here,
>> and concentrate on the real showstoppers. I would consider the AC97
>> PSC not being set up, the IrDA PSC not being set up, the disk
>> numbering and any problems we're having with USB devices (argh) to
>> be real showstoppers. 
> 
> I'm inclined to agree. What I said was "since they have showstopper bugs
> to fix, we might as well let them fix the less important device-tree
> stuff at the same time."

The problem is that the firmware development and testing cycle is pretty
intensive; if we change any string in the code, if it is publically
present then it needs to be passed through a set of tests to make sure
it is working. If it means collaborating with Linux developers it means
sending out firmware updates, getting results back.. just for changing
one string to another.

When it doesn't make any difference at all ("sram" and "memory" and
"ac97" to "sound", the difference between mpc5200-blah and mpc5200b-blah
and a couple of stray null characters) I feel there's no point whatsoever
in doing it when it entails that much work.

In the Pegasos 1.2 firmware we definitely had some stupid spelling
mistakes (one RTAS token at LEAST was wrong :) but since nobody ever
used them, they were never really fixed. The CPU node presented l3
cache data for the 7447 even though we never made a 7457 card and
could differentiate between them at the point that firmware was out.

But nobody cares. It doesn't make a single bit of functional difference
where the thing is fixed if it IS needed though. It may be cleaner in
the firmware, but what I saw here is Sylvain saying that these fixes
will "never be accepted in the mainline" because they should be fixed
in firmware. We can't fix the 1.3 firmware, it's already on the
first production batch, end of story. No committee or discussion does
anything to change that. We can and will fix as much as is relevant
in the next one but if we can't.. does that mean Linux is intentionally
crippling itself?

I don't care if it makes the platform look full of bugs as long as
Linux runs on it. I am concerned when a real hardware bug is marked
as a platform bug (Via IDE IRQ quirk for Pegasos is a good example,
this is a Via chipset bug, not a PowerPC or Pegasos-specific thing)
but these are really just platform bugs, that we would like to see
code fixed up for it. If it means MPC5200 drivers have Efika fixes
in it, then *sorry* but I am thinking of people who want to use
PowerPC Linux here.

I really want to give the customers the choice; because sometime soon
we may have NetBSD, FreeBSD, QNX, whatever else on the board, and
we could be saying "well, these OS's all work fine, Linux does too
up to a point, but they have crippled it" because it would be the truth.

> Please can we have a firmware with the important stuff fixed, and
> preferably the simple and uncontentious device-tree fixes too; like
> perhaps no longer pretending to be CHRP?

That should be most definitely fixed in February. We like CHRP for what it
is but the reality of it is that it's so weakly defined in Linux and not
used at all in any other OS, there is no point to it. RTAS is totally
misused in places. We have a solution for it.. maybe a little contentious
but at least it will not be presenting our systems as a standard they
may only half-be (Pegasos was VERY CHRP besides the interrupt controller,
Efika is about as CHRP as my grandmother's handbag).

> The other device-tree stuff you're arguing about is less important,
> because it isn't _that_ hard to fix it up in prom_init() -- although it
> would have been nice if the debate had happened when people were trying
> to put the spec together in the first place, rather than only now.

We had the final firmware pretty much completed and in a no-minor-tweaks
phase before any spec was ever considered on this mailing list, which is
the whole problem. Being a little pioneering about it means we fell afoul
of the guys who think everything should be discussed to death before doing
it. Efika was already delayed 6 months because of errata and RoHS problems,
and we just don't have the time in any case to sit here and discuss a
million minor things when the number of boards in production was a big fat
zero, or now that boards are out in the field and need support.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
