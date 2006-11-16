Return-Path: <leisun124@gmail.com>
Message-ID: <f9a7e7a80611160842o1dffb2d8u10e4b838dc59ddd2@mail.gmail.com>
Date: Thu, 16 Nov 2006 11:42:04 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Subject: Re: memory corruption after MMU turned on
In-Reply-To: <1628E43D99629C46988BE46087A3FBB97AFFDC@ep-01.EmbeddedPlanet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80611160744t7071ff6clf5e1d42cfaa2c856@mail.gmail.com>
	<1628E43D99629C46988BE46087A3FBB97AFFDC@ep-01.EmbeddedPlanet.local>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am using codewarrior and USB+TAP for debugging(didn't got BDI yet).
One problem seems like if i set a break point at some place, when the
code reach there, it did stopped, but the instruction on that location
became 0x00000000 !
Any also, the kernel is loaded at physical address 0x0, how do  i set
the break point to 0xC000XXX address? I suppose i should set the break
point at the physical address instead.
I don't have the hardware to try right now.

Thank you for your reply!

lei

On 11/16/06, Steven Blakeslee <BlakesleeS@embeddedplanet.com> wrote:
> Generally stepping over the rfi command will cause the problem.
> Instead, set a breakpoint at the address that the rfi command will jump
> to, the C000XXX address.  Then step through code from then on.
>
>
>
> > -----Original Message-----
> > From:
> linuxppc-embedded-bounces+blakeslees=embeddedplanet.com@ozlabs.org
> > [mailto:linuxppc-embedded-
> > bounces+blakeslees=embeddedplanet.com@ozlabs.org] On Behalf Of Lei Sun
> > Sent: Thursday, November 16, 2006 10:45 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: memory corruption after MMU turned on
> >
> > Hi all:
> >    I am trying to bring up customized board based on MPC8270, the
> > kernel version is 2.4.30, it works fine on one of the Eval board
> > (PQ2FADS-VR, which use MPC8275).
> >    The kernel hangs after uncompressing is done, further debug shows
> > that it hangs right after "rfi " instruction of the turn_on_mmu:
> > function in head.S
> >
> >  turn_on_mmu:
> >     240     mfmsr   r0
> >     241     ori r0,r0,MSR_DR|MSR_IR
> >     242     mtspr   SRR1,r0
> >     243     lis r0,start_here@h
> >     244     ori r0,r0,start_here@l
> >     245     mtspr   SRR0,r0
> >     246     SYNC
> >     247     RFI             /* enables MMU */
> >
> > After i step over the RFI instruction, the PC points to C000XXX , but
> > all memory content is 0 by then.
> > my BATU0 is 0xC000FFE0  BATL0 is 0x00000002, I have 128MB RAM. The
> > u-boot works fine, without MMU turned on. We do have some hardware
> > problem, such that i have to lower the bus frequency to make the SDRAM
> > stable. What physical parameter could cause the board not working with
> > MMU on?
> >
> > Any suggestion?
> >
> > Thanks
> > lei
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
