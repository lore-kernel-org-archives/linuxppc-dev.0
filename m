Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 17:12:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Message-ID: <20070328001215.GA25080@mag.az.mvista.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
	<17929.44043.728362.712648@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17929.44043.728362.712648@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 09:43:07AM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Disable external interrupts very early in the bootwrapper in case
> > the firmware left a device generating interrupts.
> 
> Sounds reasonable, except that I wonder if systems running under a
> real OF want to do this...

I don't know.  Would someone who knows OF speak up?

> > +	li	r9,(1<<15)@l	/* Disable external intrs (clear MSR[EE]) */
> 
> That will actually get us ffff8000 in r9.

Oops.

> > +	mfmsr	r10
> > +	andc	r10,r10,r9
> 
> I suggest this sequence instead:
> 
> 	mfmsr	r10
> 	rlwinm	r10,r10,0,~(1<<15)	/* clear MSR_EE */

That works.  Respin in a bit.

Thanks,

Mark
