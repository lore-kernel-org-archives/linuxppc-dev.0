Date: Thu, 24 Oct 2002 07:59:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org, scop@digitel.com.br,
	thomas@corelatus.com
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Message-ID: <20021024145931.GI669@opus.bloom.county>
References: <200210241423.g9OENV4d024137@blooper.utfors.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210241423.g9OENV4d024137@blooper.utfors.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 24, 2002 at 04:23:31PM +0200, Joakim Tjernlund wrote:

> This is the second version of my patch that removes the expensive memcpy of
> received
> ethernet frames in interrupt context.
>
> I have 1 report(from Ricardo Scop) of 20% increase in packets/second, packet
> size 1500 when
> applied to 8260 FEC(needs to be applied manually). But min packet size
> decreased with 10 %.
> This version should fix the 10% decrease case.
>
> This patch could be adapted 8xx_io/fec.c and 8260_io/enet.c and
> 8260/fcc_enet.c with little effort.
>
> Better fix a bug in set_multicast_list(), move the dmi list forward when
>     walking it(dmi = dmi->next;)
>
> New stuff:
>    - Configrable: copy small packets or pass them directly, see
> COPY_SMALL_FRAMES in code.
>    - Collision reporting fix form Thomas Lange.
>    - Don't pass receive frames which has error upwards.
>    - Report RX_OV errors as fifo errors, not crc errors.
>
> Please test and report any problems and performace improvements.

All of this sounds good, but can you please break this one patch up into
seperate logical patches?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
