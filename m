Date: Thu, 11 Apr 2002 16:18:37 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411161837.E18158@ecam.san.rr.com>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net> <20020411153642.C18158@ecam.san.rr.com> <3CB5B452.3080603@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CB5B452.3080603@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 04:05:38PM +0000, Armin wrote:
> This patch did not remove BASE_BAUD from the headers??? Having an option
> for early boot is a good thing, this patch removes that option.  Your
> patch would only affect the walnut?  David's is at least in setup.c
> where more boards have access to the early serial init code.

This patch was more a proof of concept. I need it on our devel board that
may run at different speeds. It becomes hard to find a good overall base baud
rate that will work for multiple clock speeds, that doesn't cause rounding
errors that throw off the final baud rate.

Since BASE_BAUD is defined in the platform section I though to put the code
in the same area. I did not look around for the best place to put it so setup.c
may be a better spot.

If a external serial clock is used the BaseBaud still needs to be correct.
So that is one reason not to remove the define completely, but for anything
that uses the internal clock BaseBaud could be set to 0.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
