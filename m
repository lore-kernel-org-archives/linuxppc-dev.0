Return-Path: <nicholas.piggin@gmail.com>
Date: Wed, 25 Oct 2017 21:24:08 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Vipin K Parashar
 <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, <skiboot@lists.ozlabs.org>
Subject: Re: [PATCH] powernv: Avoid checkstop on HMI and MCE
Message-ID: <20171025212408.112bf00f@roar.ozlabs.ibm.com>
In-Reply-To: <1508929182.27418.19.camel@neuling.org>
References: <20171024092005.3861-1-mikey@neuling.org>
 <871slr1qip.fsf@concordia.ellerman.id.au>
 <1508929182.27418.19.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cc'ing skiboot

On Wed, 25 Oct 2017 21:59:42 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On Wed, 2017-10-25 at 12:16 +0200, Michael Ellerman wrote:
> > Michael Neuling <mikey@neuling.org> writes:
> >   
> > > On an unrecoverable HMI or MCE only generate an checkstop (via
> > > PLATFORM ERROR opal reboot call) when panic_on_oops is set.
> > > 
> > > We currently generate an checkstop as an attempt for the FSP to grab a
> > > dump and then reboot us. Unfortunately this never works and no one  
> > 
> > Never? WT#.  
> 
> Well no one I've talked but I'm posting this so someone will stand up and say
> they want it.
> 
> > > I've talked to has ever seen a resulting dump, let alone got useful
> > > information from it.
> > > 
> > > Even worse, the checkstop gets in the way of debugging real
> > > problems. If we hit a software bug that results in this, we get no
> > > opportunity to debug it live. Similarly if the bug is due to hardware
> > > that is not in the dump (say PCI or NVLINK GPU), we get no information
> > > in the dump about that hardware.
> > > 
> > > So let's remove it unless someone sets panic_on_oops.  
> > 
> > Nick just rewrote pnv_platform_error_reboot(), so please talk to him to
> > make sure you're not stepping on each other.  
> 
> OK, will do.

I've got nothing really.

I couldn't find out how to do something useful with the crash. My patches
were along the same line as this, which was to make more Linux crash data
printed and try to avoid panic'ing the system when we can recover.
Apparently it does set a firmware log.

Only thing I thought is that it's not really an oops, but a hardware error
(except when it is a software error/oops). I thought it fits
panic_on_unrecovered_nmi better (or we make our own one since that looks
like it's x86 only).

We just need to go through and think about behaviour we want and make it
all consistent. For example right now if we think we can recover the
system because there's an unrecoverable machine check in process context,
then we try to just kill the process (opal_recover_mce()). Someone who
sets the panic_on_ here would like to panic in those cases too probably.

> 
> > > diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c
> > > b/arch/powerpc/platforms/powernv/opal-hmi.c
> > > index c9e1a4ff29..23780970d0 100644
> > > --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> > > +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> > > @@ -284,6 +285,11 @@ static void hmi_event_handler(struct work_struct *work)
> > >  			print_hmi_event_info(hmi_evt);
> > >  		}
> > >  
> > > +		if (!panic_on_oops) {
> > > +			die("Unrecoverable HMI exception", NULL, SIGBUS);
> > > +			return;  
> > 
> > I don't think we should return.
> > 
> > Otherwise we risk persisting corrupt data to disk and so on.  
> 
> ok
> 
> > If we're getting unrecoverable HMI/MCEs that are not actually indicative
> > of something bad happening then we need to filter those out somewhere.  
> 
> We hit this with some new HMIs for NVLINK and the Vector Load one, so we need to
> handle them, and we have code that does (or is coming).
> 
> In the mean while, it's very hard to debug them once we xstop.

The pnv_platform_error_reboot() wasn't able to print anything to
console in that case? I'd like to try improve that if it's not working,
because even in the panic case we should try to get something useful to
console.

Thanks,
Nick
