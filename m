From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Fixups for Longtrail (2.4.14-pre7)
Date: Sun, 4 Nov 2001 09:07:38 +0100
Message-Id: <20011104080738.27893@smtp.wanadoo.fr>
In-Reply-To: <20011103152503.H29932@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011103152503.H29932@cpe-24-221-152-185.az.sprintbbd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hey all.  I pulled out my Longtrail to play again, and I found some
>wierd problems.  If I keep the 'default' type cards in it (What I
>_think_ are the original video & ethernet, or at least known-OF-happy
>ones), the box actually works.  But If I throw in a PC video card
>(Matrox Millennium 1 in this case) I get oopses all over the place.  I
>think the problem is that the firmware doesn't go and set all of the
>properties, so lots of strcmp's blow up.  The followig gets me both
>video cards (and I even logged into a mingetty on 'em) and seems to be
>OK with some light testing.  Now the question is, is the following patch
>worth pushing?  It does fix some technical problems, but I'm willing to
>bet only Longtrail is bitten.  Comments?

Your patch is right, I also noticed a few oldworld macs do have
missing required properties here or there.

Olaf also found a case in offb where we don't test for the
node pointer to be NULL before calling device_is_compatible,
which is wrong as the bootx case will pass NULL. I'll push a
fix as soon as I'm back, that is in a few hours now ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
