Date: Thu, 2 Dec 1999 00:27:19 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <991202072719.ZM11771@saguaro.lan>
In-Reply-To: Jason Kim <jwk2@eecs.lehigh.edu>
        "Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2" (Dec  2, 12:20am)
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
	<4.2.2.19991201162019.03c111b0@mail.lauterbach.com>
	<384574A2.A003F5F6@eecs.lehigh.edu>
	<99120114490800.04790@localhost.localdomain>
	<38460186.8CEC249C@eecs.lehigh.edu>
To: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Jason Kim <jwk2@eecs.lehigh.edu>
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Dec 2, 12:20am, Jason Kim wrote:

> Anybody have any examples of where there IS va_list passage from
> user code to existing dynlib code (or vice versa)?  I tried a bit,
> and couldn't find any, and am thinking that there isn't any.  If
> that is the case, then applying the patch en-mass seems harmless way
> for getting rid of the array based va_list once and for all.

How about anything that calls vprintf, vsprintf, or vsnprintf?

A more concrete example: Suppose you've compiled the perl library
to use the old interface and then compile an application which
uses it with your va_list interface.  Then suppose the application
calls sv_vsetpvfn() in the perl library.  Would it work?

I feel like I'm playing devil's advocate here because I would really
like it if you (or someone) could straighten out the ppc va_list
issues.  I've been bitten by problems similar to the ones that you've
encountered more than once over the years.  Recently I had to fix a
problem in gdb where it would've been nice to do a va_list copy. 
Instead, I restructured the code so that a copy wasn't necessary.  It
turned out to be doable in this instance, but I'm aware of some code
in libiberty that can't be restructured so easily.  (But for some
reason, it seems to be working now on linux/ppc.  I remember a time
when it didn't.)

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
