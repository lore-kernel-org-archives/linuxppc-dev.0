Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:34:01 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Disable external interrupts in bootwrapper
Message-ID: <20070328013401.GA7097@mag.az.mvista.com>
References: <20070327222840.GA1266@mag.az.mvista.com>
	<17929.44043.728362.712648@cargo.ozlabs.ibm.com>
	<20070328001215.GA25080@mag.az.mvista.com>
	<1175041735.14065.37.camel@localhost.localdomain>
	<20070328010305.GA302@mag.az.mvista.com>
	<20070328012622.GB27401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070328012622.GB27401@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 11:26:22AM +1000, David Gibson wrote:
> On Tue, Mar 27, 2007 at 06:03:05PM -0700, Mark A. Greer wrote:
> > On Wed, Mar 28, 2007 at 10:28:55AM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2007-03-27 at 17:12 -0700, Mark A. Greer wrote:
> > > > On Wed, Mar 28, 2007 at 09:43:07AM +1000, Paul Mackerras wrote:
> > > > > Mark A. Greer writes:
> > > > > 
> > > > > > Disable external interrupts very early in the bootwrapper in case
> > > > > > the firmware left a device generating interrupts.
> > > > > 
> > > > > Sounds reasonable, except that I wonder if systems running under a
> > > > > real OF want to do this...
> > > > 
> > > > I don't know.  Would someone who knows OF speak up?
> > > 
> > > OF isn't supposed to use external interrupts but I wouldn't bet on what
> > > Apple's one does... I think it's not safe to do that thus on OF based
> > > platforms.
> > 
> > Hrm...crap.  This may be a case where I need my own crt0.S then.
> 
> We could do some more weak symbol magic to make it an option in the
> crt0.S, like the BSS stack.

Yeah, that would be nice.  Other than not clearing MSR[EE], the current
crt0.S is works for me.  A little hook or somesuch there would be nice
so I don't have to duplicate the rest of crt0.S.

Mark
