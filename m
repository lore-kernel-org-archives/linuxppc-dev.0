From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15333.58608.870439.900641@cargo.ozlabs.ibm.com>
Date: Mon, 5 Nov 2001 12:01:36 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Fixups for Longtrail (2.4.14-pre7)
In-Reply-To: <20011103152503.H29932@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011103152503.H29932@cpe-24-221-152-185.az.sprintbbd.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> Hey all.  I pulled out my Longtrail to play again, and I found some
> wierd problems.  If I keep the 'default' type cards in it (What I
> _think_ are the original video & ethernet, or at least known-OF-happy
> ones), the box actually works.  But If I throw in a PC video card
> (Matrox Millennium 1 in this case) I get oopses all over the place.  I
> think the problem is that the firmware doesn't go and set all of the
> properties, so lots of strcmp's blow up.  The followig gets me both

Instead of checking node->name everywhere, I would prefer that the
prom.c code makes sure that node->name is never NULL.  That is a
change in one place rather than N, and it will fix the places that you
didn't find as well as the ones you did. :)

The OF standard says that each node should have a name property, so I
think it's reasonable for users of the device tree to assume that
node->name is non-NULL.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
