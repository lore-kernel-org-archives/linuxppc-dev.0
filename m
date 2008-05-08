Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 May 2008 11:57:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Use dcr infrastructure.
Message-ID: <20080508015704.GF5156@yookeroo.seuss>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
	<fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
	<20080506061444.GB17798@yookeroo.seuss>
	<4777b221c199009151e8f5b7b5f16de3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4777b221c199009151e8f5b7b5f16de3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 06, 2008 at 12:56:44PM +0200, Segher Boessenkool wrote:
>> Current standard practice is not to represent the DCR bus as node with
>> subnodes for the DCR-controlled devices.  That's because the DCR bus
>> tends to run in addition to other on-chip busses, and some things have
>> to go on another on-chip bus to make sense, but still have DCR control
>> registers (for example the internal bus bridges on 4xx).
>
> Yeah.
>
>> Arguably for DCR-only devices we should instead have a node
>> representing the DCR bus and just put the devices under it with the
>> DCR number encoded in reg in the normal way.
>
> Right.
>
>> But then its
>> inconsistent with the devices that need the other DCR representation.
>
> OTOH, it _is_ consistent with all other (non-DCR) devices that way.
>
> What you could do right now is to give such DCR-only devices both
> normal "reg" etc., and the "dcr-reg" etc. properties, containing
> both the same info.  If you do that, your device tree will be
> correct (because you got all the standard stuff right), and the
> kernel will like it as well (because it looks for the "dcr-reg"
> stuff).

> Then maybe later, if/when the kernel supports the standard addressing
> for DCR as well, you could drop the "dcr-reg" things from your DTS.
> Or you could just keep it.
>
> David, will this work, do you think?

Um.. yeah, I guess that should work.  Don't forget to slap on
"simple-bus" as appropriate.

>> Segher and I did toss around some ideas for generalizing the DCR
>> representation to a way of representing that any node has some
>> presence on a bus other than its "primary" parent (e.g. other-bus-reg
>> = <&dcr-bus 0x0d0 0x010 &strange-i2c-control-bus 0xabc>).  Then
>> DCR-only devices would use normal "reg", devices that sit on another
>> bus would sit on that bus and use this representation to show their
>> DCR control registers.  Maybe one day.
>
> One day perhaps, yes :-)
>
> It sounds cleaner to split such a prop into separate props per bus.
> Maybe I said the opposite before, heh :-)

No I think you said that before, too, but I'm not sure I agree.
Seperate props per bus (well, per bus type, really) is probably more
human-readable, but a single prop has the advantage that we can have a
common parser that will interpret future variations on this theme
correctly without having to add things to some list of properties to
look for.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
