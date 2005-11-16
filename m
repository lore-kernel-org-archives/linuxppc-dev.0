Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 16 Nov 2005 10:36:09 +0100
To: Becky Bruce <becky.bruce@freescale.com>
Message-ID: <20051116093609.GA26269@iram.es>
References: <1132032910.23979.6.camel@gaston>
	<00eecfdbd5bccc7b293d847033121eee@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00eecfdbd5bccc7b293d847033121eee@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 15, 2005 at 08:19:58PM -0600, Becky Bruce wrote:
> Ben,
> 
> Yeah,  I clearly shouldn't run testcases at 11pm, because I got in a 
> rush and only confirmed that lmw/stmw were actually taking the 
> exception.  Those 2 are working beautifully.  To test the others, I 
> need to run on a different board which, of course,  isn't bootable at 
> the moment.  As soon as I can get that up and running, I'll try some of 
> the other cases and let you know how it goes......
> 
> BTW, Based on the pile of docs I have here, I think the list of 
> alignment-exception-causing events on FSL's current parts (603, 603e, 
> 750, 74x, 74xx, e500) is:

The 603 is still in production? And is the upcoming 8641 exactly 
the same as the 74xx series in this respect? 

> 
> - lmw/stmw (all procs, non-word aligned)

Do we really want to emulate these instructions? 

Their purpose is to minimize code size in functions prologue and
epilogue. If you hit an alignment execption with lwm/stmw, your 
stack is probably misaligned for some stupid reason or bug (back 
chain pointer corrrupted because of some buffer overflow comes to 
mind, and you want to know ASAP).

> - single and double precision floating point ld/st ops (non-E500, non 
> data size aligned)

Hmm, you can load a double from any 4 byte aligned address AFAIR.

> - dcbz to WT or CI memory (all procs)
> - dcbz with cache disabled (all procs but 603e?)
> - misaligned little endian accesses (603e)

I understand that you mention it for completeness since we 
don't care about LE mode AFAICT. But I believe that there
were some differences between 603 and 603e in this area.

However we do care about byte reversal instructions, which 
probably believe like the corresponding normal instruction
(i.e., lwbrx has the same rules as lwzx, etc.)

> - lwarx/stwcx (all procs)

And ldarx/stdcx. on 64 bit, but these ones should not 
be emulated. So it's easy ;-)

> - multiple/string with LE set (750, 603e, 7450, 7400)

Again LE mode is probably irrelevant.

> - eciwx/ecowx (750, 7450, 7400)

Have these instructions ever been used for something 
under Linux?

> - a couple of others related to vector processing

Which ones? The Altivec load and store instructions
simply mask the low order bits AFAIR.

> If anybody knows offhand of something missing there, let me know.

Nothing, but did you check when crossing a segment (256MB) boundary.
I seem to remember that some processors performed misaligned 
load/store across pages but not across segments.

	Regards,
	Gabriel
