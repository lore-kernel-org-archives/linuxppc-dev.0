Message-ID: <3AC179EB.C77A2EB5@mvista.com>
Date: Wed, 28 Mar 2001 00:43:07 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PVR hell
References: <3AC0EF44.E2BCE2F6@mvista.com> <20010327225138.22949@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> So what I propose is to have head.S parse a table, and when a matching
> CPU is found, call it's init function (pointed to by a table entry) and
> load the feature value from it.

That will work.

> The init function can then fill other ppc_md fields if needed. That can
> be done
> as a second step

I didn't necessarily mean to use ppc_md, just the idea of a one time
initialization of function pointers early in head.S based upon the PVR.

> ......... There is
> a quite clear distinction between embedded CPUs and "desktop" CPUs,

Not among CPUs.  Less than 25% of 74xx processors are used by Apple
in all of their systems, where do you suppose all the rest go?  The
disctinction is based upon system configurations, that you can't
assume 74xx processors are going to boot with OF, or even have a disk
for that matter.  I'm just asking we don't build software with these
assumptions, as most of the 74xx processors are going into deeply
embedded hybrid DSP environments.

>  ...... and
> I see no immediate need to have a binary kernel that can run them all.
> (I may be wrong here, please correct me if I am).

That isn't what I was suggesting either.  Even among processors we
think should be similar, like the 74xx family, there are some major
differences.  The old test and branch based upon PVR is turning into
a twisted mess of code, that I think would be better understood,
written,
and more reliable if we adopted a more modular and indirect calling
method (which I believe you are suggesting as well).

> For now, my primary concern is about things that will affect the desktop
> systems, especially the powermacs using the whole range of PPC "32 bit
> desktop" CPUs from 601 to 7450.

The only 7450 systems running Linux today are embedded PPMC with a DINK
boot rom that boot from flash........those aren't desktops.  Someday
Apple may have something available for you desktop guys, but the
initial development is for Linux embedded targets :-).

I think your table lookup stuff is just fine, and I'm ready to rewrite
some of head.S to use something different.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
