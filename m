Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 49FB4DDE00
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jan 2007 09:23:39 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 32so6259206ugm
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jan 2007 14:23:37 -0800 (PST)
Message-ID: <528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
Date: Sat, 6 Jan 2007 15:23:37 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>,
	"Linux PPC DEV" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
In-Reply-To: <45A01416.6080401@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: Paul Mackerras <paulus@samba.org>, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/6/07, Matt Sealey <matt@genesi-usa.com> wrote:
>
> One basic problem is we're talking about changing Efika to adapt to the
> definitions, whims and determinations of the *Linux* community.

As opposed to the Linux community being asked to adapt to the
definitions, whims and determinations of a single corporate entity?
:-)

>
> What if NetBSD, FreeBSD, QNX and WindRiver disagree with you guys?

I'm pretty sure that Linux is the only OS which is requiring a device
tree for booting for new ports, and I'm also pretty sure that the
Efika is the only 52xx board with open firmware on it.  If I'm right
about this; then for the vast majority of 52xx boards, a device tree
is only needed if it is booting Linux, and therefore it is up to the
Linux community to define what it needs to look like.  It also makes
the Efika the exception, not the rule (as it's the only board which
will pass the device tree to non-Linux OSes)

> Who do we change for?
>
> You might understand, we all think you're being just a TAD unreasonable
> on this matter.

I'm not trying to say "Change Dammit!".  I'm trying to say, "This is
what I think it should look like; where should it go from here".  So
far I feel like I've been told: "we've done it this way, deal with it"

> Surely Linux should detect all available and present nodes, compatibility
> flags and so on, and not simply tell vendors to "shape up your firmware
> because we refuse to make Linux support anything we did not define and
> impose on you"?

Early on when we were trying to draft a standard for 52xx device trees
(mpc52xx-device-tree-bindings.txt), bplan refused to disclose what the
Efika device tree layout looked like.  In the absence of any input
from bplan, a draft 52xx device tree spec was written.  Mostly, the
draft spec followed the conventions already established for other
powerpc SoC devices (see booting-without-of.txt; and Yes, I realize
that the Efika has real-of; but I'm just referring to the naming
convention portions of that document).

Reference:
http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/powerpc/mpc52xx-device-tree-bindings.txt;h=d077d764f82b0ce73148063e694f842e7ab00ff9;hb=HEAD

At a later date, Nicolas made the statement that the firmware was set
and there would be not changes to the device tree, so I better just
copy what was done on the Efika.

I do not object to changing the definitions or what we are requesting
for the device tree layout.  I do object to being told, "we did it
this way, so just copy it" after refusing to discuss any kind of
device tree layout standard for the 52xx parts.  As someone who is not
getting paid to do this work, it does not particularly motivate me to
want to help you out.

> Specifically for the "sound" and "ac97" discrepency, the "sound" device
> type has some special implications for Open Firmware firmwares. It's
> set to ac97 as it is NOT an OF or CHRP standard "sound" node and should
> NOT be found as such in my personal opinion.

For the record; this has already been addressed:

http://patchwork.ozlabs.org/linuxppc/patch?id=8842

'ac97' was wrong, it should have been 'sound'

I do *NOT* want to claim that the proposed mpc52xx device tree binding
is correct or final.  My motivation is to see a consistent, well
thought out device tree specification for all 52xx boards before too
many vendors produce device trees that are utterly incompatible with
one another (due to inconsistent naming).

> Would you mind giving me a list of exactly WHAT you think is wrong (the
> patch doesn't define what is broken, it only blindly throws in the fixes
> with no explanation of why in comments or documentation..) and why we
> should fix it, and I can go through it with you, since I understand Nico is
> not up to discussing the matter being very busy and all :D

There are two issues here:

1. consistent mpc52xx soc device naming so that the appropriate
compatible device driver can be selected; two different 52xx devices
exist at the moment, and the Efika seems to report them as the wrong
one (ie. 5200 instead of 5200b).  Plus there are rumblings from
Freescale to be bringing out more 52xx devices.  These are the issues
that mpc52xx-device-tree-bindings.txt was written to address; and that
document also contains the rational for the naming convention.  As it
stands right now, Sylvain's patch provides a workaround for these
concerns, so the differences between the draft spec and the Efika are
contained within a single source file.

Once again, I am not opposed to changing the draft; the goal of the
document is to encourage consistency in board designs.

2. Dwmw2 says that reading the HD has an off-by-one showstopper bug
which prevents Linux from reading the partition table (and that it is
the same bug that was on the pegasos, but is now fixed).

I have not confirmed this issues as I don't have a working HD on my
Efika.  However, dwmw2 has stated that he cannot support the Efika in
Fedora until this issue is resolved.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
