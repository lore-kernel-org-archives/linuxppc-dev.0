Return-Path: <alistair@popple.id.au>
From: Alistair Popple <alistair@popple.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] powerpc/powernv: implement NMI IPIs with
 OPAL_SIGNAL_SYSTEM_RESET
Date: Thu, 14 Sep 2017 16:43:22 +1000
Message-ID: <2623107.WiHgLWVaNd@new-mexico>
In-Reply-To: <20170914163228.0510251a@roar.ozlabs.ibm.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
 <1505355889.12628.177.camel@kernel.crashing.org>
 <20170914163228.0510251a@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2017 04:32:28 PM Nicholas Piggin wrote:
> On Thu, 14 Sep 2017 12:24:49 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2017-09-13 at 23:13 +1000, Nicholas Piggin wrote:
> > > On Wed, 13 Sep 2017 02:05:53 +1000
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > >   
> > > > There are two complications. The first is that sreset from stop states
> > > > come in with SRR1 set to do a powersave wakeup, with an sreset reason
> > > > encoded.
> > > > 
> > > > The second is that threads on the same core can't be signalled directly
> > > > so we must designate a bounce CPU to reflect the IPI back.  
> > > 
> > > Here is an updated Linux patch for the latest OPAL patch. This has
> > > a few assorted fixes as well to make it work nicely, I roll them into
> > > one patch here to make it easy to apply for testing the OPAL patch.  
> > 
> > Why can't you sreset threads of the same core on P9 ?
> 
> It looks like we can, I think I had some other bugs still not ironed
> out when I previously tested it.
> 
> That simplifies things a lot on the Linux side. It may be that the
> bounce is still required if we implement it on POWER8 using ramming,
> but I'll get the POWER9 code in first.

Right, the bouncing is still required on P8 because we need to ram instructions
and you can only ram instructions if all threads on a core are quiesced.

- Alistair

>
> Thanks,
> Nick
