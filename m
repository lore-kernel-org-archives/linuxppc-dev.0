Return-Path: <benh@kernel.crashing.org>
Message-ID: <1505356038.12628.179.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2] core: implement OPAL_SIGNAL_SYSTEM_RESET with
 POWER9 scoms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org, Alistair Popple
 <alistair@popple.id.au>
Date: Thu, 14 Sep 2017 12:27:18 +1000
In-Reply-To: <20170913232716.138ca093@roar.ozlabs.ibm.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
 <20170912160553.13422-2-npiggin@gmail.com>
 <1505258314.12628.151.camel@kernel.crashing.org>
 <20170913232716.138ca093@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-13 at 23:27 +1000, Nicholas Piggin wrote:
> On Wed, 13 Sep 2017 09:18:34 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2017-09-13 at 02:05 +1000, Nicholas Piggin wrote:
> > > This implements a way to raise system reset interrupts on other
> > > cores. This has not yet been tested on DD2 or with deeper sleep
> > > states.  
> > 
> > Reminds me, we need to workaround a bug with XSCOMs on P9
> > 
> > PSCOMs to core in the range 20010A80-20010Ab8 (list below) can fail
> > occasionally with an error of 4 (PCB_ADDRESS_ERROR). We need to
> > (silently) retry up to 32 times.
> 
> [snip]
> 
> So, just put a loop into xscom_read and xscom_write for those
> addresses for P9 chips?

Right. Well, the top bit of the address needs filtering since it's the
target core, ie, 0x20 is core 0, 0x21 is core 1 etc... to 0x37.

Cheers,
Ben.
