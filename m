Return-Path: <tglx@linutronix.de>
Date: Wed, 24 Mar 2010 22:25:51 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH 01/10] irq: move some interrupt arch_* functions into
	struct irq_chip.
In-Reply-To: <1269458163.28761.859.camel@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.1003242150400.3147@localhost.localdomain>
References: <1269221770-9667-1-git-send-email-yinghai@kernel.org>
	<1269221770-9667-2-git-send-email-yinghai@kernel.org>
	<alpine.LFD.2.00.1003220950570.3147@localhost.localdomain>
	<1269437531.10129.67616.camel@zakaz.uk.xensource.com>
	<alpine.LFD.2.00.1003241824500.3147@localhost.localdomain>
	<1269458163.28761.859.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "lguest@ozlabs.org" <lguest@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Paul Mundt <lethal@linux-sh.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 24 Mar 2010, Ian Campbell wrote:
> On Wed, 2010-03-24 at 17:44 +0000, Thomas Gleixner wrote: 
> > On Wed, 24 Mar 2010, Ian Campbell wrote:
> > 
> > > On Mon, 2010-03-22 at 10:19 +0000, Thomas Gleixner wrote:
> > > > On Sun, 21 Mar 2010, Yinghai Lu wrote:
> > > > 
> > > > > From: Ian Campbell <ian.campbell@citrix.com>
> > > > > 
> > > > > Move arch_init_copy_chip_data and arch_free_chip_data into function
> > > > > pointers in struct irq_chip since they operate on irq_desc->chip_data.
> > > > 
> > > > Not sure about that. These functions are solely used by x86 and there
> > > > is really no need to generalize them.
> > > 
> > > I thought the idea of struct irq_chip was to allow the potential for
> > > multiple IRQ controllers in a system? Given that it seems that struct
> > > irq_desc->chip_data ought to be available for use by whichever struct
> > > irq_chip is managing a given interrupt. At the moment this is not
> > > possible because we step around the abstraction using these arch_*
> > > methods.
> > 
> > Right, but you have exactly _ONE_ irq_chip associated to an irq_desc,
> > but that same irq_chip can be associated to several irq_descs. So
> > irq_desc->data is there to provide data for the irq_chip functions
> > depending on what irq they handle (e.g. base_address ...). 
> > 
> > irq_desc->chip_data is set when the irq_chip is assigned to the
> > irq_desc.
> > 
> > So there is no point in having functions in irq_chip to set
> > irq_desc->chip_data.
> 
> So how do you know which is the appropriate irq_chip specific function
> to call given an irq_desc that you want to copy/free/migrate? The
> contents of the chip_data pointer will take different forms for
> different irq_chips. The way the generic code is currently structured it
> appears you can't (or at least don't) just do a shallow copy by copying
> the irq_desc->chip_data pointer itself -- you need to do a deep copy
> using a function which understands that type of chip_data.

The design of sparse_irq or to be honest the lack of design grew that
crap and it's not only this detail which is a nightmare. That pointer
should probably be simply copied. Either that or if the chip data
require to be node bound we need something along the line:

struct sparse_irq_chip_data {
       void *data;
       void (*copy)(...);
       void (*free)(...);
};

and a corresponding field in irq_desc.

I'm looking into sparse_irq right now anyway because it has other way
more serious short comings.

> How is this operation different to having pointers in irq_chip for
> enabling/disabling/masking interrupts for each irq_chip?

Because that's the purpose of the irq_chip perhaps ?

Thanks,

	tglx
