Date: Wed, 29 May 2002 12:05:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@mvista.com>
Subject: Re: Unrecognized opcode: `mtdcr'
Message-ID: <20020529190544.GO5997@opus.bloom.county>
References: <20020529134822.A4429@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020529134822.A4429@zuul.cca.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 01:48:22PM -0500, Stephen Cameron wrote:
>
> Hi,
>
> I just started trying to play with my new Ebony board...
>
> I noticed now 'as' complains: Unrecognized opcode: `mtdcr'
> when I do this:
> 	make ebony_config
[snip]
> But, if I do this:
> 	make walnut_config
[snip]
> Any ideas?

I think we need to change arch/ppc/Makefile from:
ifdef CONFIG_40x
CFLAGS := $(CFLAGS) -Wa,-m405
endif

To:
ifdef CONFIG_4xx
CFLAGS := $(CFLAGS) -Wa,-m405
endif

For the moment.  Until there's some 440-specific opcodes we use (are
there any?) which means we'll need to do -Wa,-m440.

Matt, do you want to do this or shall I?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
