Return-Path: <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20060519081654.GB22952@iram.es>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519081654.GB22952@iram.es>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:22:21 +1000
Message-Id: <1148624542.8089.94.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-19 at 10:16 +0200, Gabriel Paubert wrote:

> Is this bug really going to be exposed in the wild or is it
> an early silicon bug that will only bite early-testers?

In the wild.

> >  - Additional Altivec instructions (load/store right/left). A new
> > feature bit for these ?
> 
> Yes. So IBM was not happy with Altivec instructions to generate
> vsel control words and got their inspiration from MIPS?

No idea ;)

> Is it really important? These instructions become nop on Cell, so their
> impact on performance should be minimal while they may be useful in
> code designed to run on any processor having Altivec.

We can ignore that problem (datastream, I cut too much of the original
message :) I suppose but I'd like to have as much point of views here as
we are tackling kernel ABI issues so we can't change things every five
minutes here.

> I believe that a Cell bit would be useful. After all you need a bit
> that tell you that you have the SPUs and related infrastructure?

We already have microarchitecture and SPUs can be detected via the
device-tree or sysfs. But that dcbt X form also exist on other
processors

> >  - Not strictly Cell specific but we currently don't expose the support
> > for optional instructions
> >    fres and frsqte (which are supported by Cell)
> 
> Should be exposed IMHO. But these instructions have been present
> in a lot of PPC processors AFAIR, they are in my original 603 and
> 604 manuals from 1994 (fsel is also marked as optional and is not
> implemented on the 601, but I'm not sure it's really supported
> anymore). I don't know about Power processors. 

So what do you suggest I do ? Add feature bits for them and for fsel
too ?
