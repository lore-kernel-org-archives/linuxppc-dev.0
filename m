Date: Tue, 28 May 2002 12:26:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Hymod board support and related changes ...
Message-ID: <20020528192652.GM1295@opus.bloom.county>
References: <17991.1022564915@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17991.1022564915@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 03:48:35PM +1000, Murray Jensen wrote:
> Hymod board support and related changes ...
>
> - Hymod board support
> - 8260 fcc_enet: more flexible (or at least readable) approach to
>   configuring i/o pins
> - 8260 fcc_enet: support different PHY interrupt "vector"s for each FCC
> - 8260 setup: fixed ppcboot jump address; should be 0x...110 not 0x...104
> - 8260 setup: turn off interrupts before jumping to the boot rom

Can you split this up into logical patches?  Also, instead of testing
TQM8260 || HYMOD for PPCBoot, why don't we just add in something like:
if [ "$CONFIG_TQM8260" = "y" -o  "$CONFIG_HYMOD" = "y" \
	-o "$CONFIG_TQM8xx" = "y" ] ;then
   define_bool CONFIG_PPCBOOT y
fi

And use that.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
