MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16312.7017.405972.816440@cargo.ozlabs.ibm.com>
Date: Mon, 17 Nov 2003 11:50:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Modra <amodra@bigpond.net.au>
Cc: Kumar Gala <kumar.gala@motorola.com>, benh@kernel.crashing.org,
	Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	David Edelsohn <dje@watson.ibm.com>
Subject: Re: kernel oops due to unaligned access with lswi
In-Reply-To: <20031116221932.GD14287@bubble.sa.bigpond.net.au>
References: <20031115210449.GA10105@suse.de>
	<20031115222430.GA13820@suse.de>
	<200311152230.hAFMUwT32990@makai.watson.ibm.com>
	<20031115224342.GA16897@suse.de>
	<200311152259.hAFMxGT27464@makai.watson.ibm.com>
	<1068977831.681.8.camel@gaston>
	<3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>
	<20031116221932.GD14287@bubble.sa.bigpond.net.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Modra writes:

> Yes.  I can't see any problem with gcc's behaviour here, and I'm
> surprised that some processor is taking alignment exceptions on lswi.
> book3 ppcas says lswi will generate an alignment exception when "the
> operand is in storage that is Write Through Required or Caching
> Inhibited, or the processor is in Little-Endian mode".  It can also
> happen for operands that cross segment boundaries or page boudaries with
> different attributes.

Well, firstly PPCAS didn't exist when the 601 was designed, and
secondly the architecture allows implementations to consist of a mix
of hardware and software - meaning that hardware can take an exception
on any condition it likes and expect software to fix it up (provided
hardware gives software enough information to fix it up, etc.).

The original PPC architecture talks about one of the reasons for an
alignment interrupt being that "the operand of an elementary string
load or store crosses a protection boundary".  And the 601 manual says
that a string load or store (except lscbx) will only cause an
interrupt if it crosses a page boundary and it is not word aligned.
Olaf, do we know what the source and destination addresses were?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
