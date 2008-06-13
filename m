Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Re-added support for FEC on MPC5121 from Freescale
	LTIB to current head
Date: Fri, 13 Jun 2008 11:32:17 +0200
References: <200806121344.26883.david.jander@protonic.nl>
	<200806121345.52293.david.jander@protonic.nl>
	<9DD9B395-38FF-422B-83D8-B91178AB46E1@kernel.crashing.org>
In-Reply-To: <9DD9B395-38FF-422B-83D8-B91178AB46E1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806131132.17700.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 June 2008 14:12:15 you wrote:
> On Jun 12, 2008, at 6:45 AM, David Jander wrote:
>
> Your commit message isn't exactly helpful as most people dont know
> what LTIB is and its not terribly relevant.  It just seems like you
> are adding support for the FEC on MPC5121 and this point.
>
>[...]
> > --- a/drivers/net/fec.h
> > +++ b/drivers/net/fec.h
> > @@ -59,6 +59,7 @@ typedef struct fec {
> > } fec_t;
> >
> > #else
> > +#if !defined(CONFIG_FS_ENET_MPC5121_FEC)
> >
> > /*
> >  *	Define device register set address map.
> > @@ -97,6 +98,48 @@ typedef struct fec {
> > 	unsigned long	fec_fifo_ram[112];	/* FIFO RAM buffer */
> > } fec_t;
> >
> > +#else /* CONFIG_FS_ENET_MPC5121_FEC */
> > +
> > +typedef struct fec {
> > [...]
> > +} fec_t;
> > +
> > +#endif /* CONFIG_FS_ENET_MPC5121_FEC */
> > #endif /* CONFIG_M5272 */
>
> I'm not exactly clear as to why this was done this way but this not
> acceptable as it means we can't build a multiplatform kernel that
> needs this driver.

Well, it wouldn't be possible either, since CONFIG_M5272 is a Cold-fire 
processor, and CONFIG_FS_ENET_MPC5121_FEC is for a PowerPC processor.
In this case.
Otherwise you are right, the driver breaks MPC83xx/MPC5121 multiplatform 
builds.

> I'm also not clear to me if the MPC5121 FEC is really the same device
> or close to it that it should be sharing this driver or have its own.

I am coming to the conclusion that it should have its own driver. 
Altough a lot of code could be shared, there are still enough differences, so 
that writing just ONE driver without some #ifdef's that would break 
multiplatform builds, would instead end up with a much bigger amount of if's, 
that would make it unreadable, unmaintainable and inefficient.
Here's why: The above struct fet_t for instance is mapped to a set of 
registers in the FEC. For processors with a CPM1, a CPM2 or without CPM (i.e. 
MPC5121) the register mapping seems to be significantly different, 
nevertheless the structs are all called "struct fec_t". How can one fix this 
at runtime without changing the name of the structs and then just use a lot 
of "if's" or a combination of macro's and if's everywhere a register of the 
FEC is accessed? I fear it will be a mess.

So I think it's either a separate driver, or break multiplatform builds.

Since I am learning from you that breaking multiplatform builds is a no-go, 
I'll settle for splitting up the driver.

Any suggestion on where to put that split-off? How to name it?
I would suggest drivers/net/fec_mpc512x/*

I just resubmitted PATCH 1/2 again without part 2 (which hasn't much to do 
with it anyway), so Grant may have a final look at it (hopefully I did it 
right this time). Part 2 (MPC5121_FEC) will have to wait until monday or so, 
since it will take me a while, and I have to do other things in between.

Any suggestions on how to solve the puzzle are of course welcome...

Thanks a lot for reviewing.

Best regards,

-- 
David Jander
Protonic Holland.
