Date: Mon, 17 Nov 2003 08:49:32 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: benh@kernel.crashing.org, Olaf Hering <olh@suse.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	David Edelsohn <dje@watson.ibm.com>
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031116221932.GD14287@bubble.sa.bigpond.net.au>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com> <20031115224342.GA16897@suse.de> <200311152259.hAFMxGT27464@makai.watson.ibm.com> <1068977831.681.8.camel@gaston> <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C0F7C71-185D-11D8-976A-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 16, 2003 at 11:49:32AM -0600, Kumar Gala wrote:
> If Ben's comments are correct simply removing -mstring as an option
> passed to the build should get the desired behavior.

Yes.  I can't see any problem with gcc's behaviour here, and I'm
surprised that some processor is taking alignment exceptions on lswi.
book3 ppcas says lswi will generate an alignment exception when "the
operand is in storage that is Write Through Required or Caching
Inhibited, or the processor is in Little-Endian mode".  It can also
happen for operands that cross segment boundaries or page boudaries with
different attributes.

--
Alan Modra
IBM OzLabs - Linux Technology Centre

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
