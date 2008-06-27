Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jun 2008 11:30:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc: add of_find_next_property andof_get_aliased_index
Message-ID: <20080627013031.GA17621@yookeroo.seuss>
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<4863BBE2.2060107@freescale.com>
	<20080626142732.0ff6e64c@lappy.seanm.ca>
	<200806262041.12275.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806262041.12275.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 08:41:12PM +0200, Stefan Roese wrote:
> On Thursday 26 June 2008, Sean MacLennan wrote:
> > > Well, there's a lot of disagreement on this subject.  Not only do we
> > > not agree on a method of enumerating devices, a lot of people have a
> > > problem with the concept of enumerating them in the first place!
> >
> > An interesting point is that I enforced an index in the i2c-ibm_iic
> > driver with no disagreement at all ;)
> 
> You have been lucky I suppose. :)

Ah... that's because IIC does have a correct reason to have cell-index
- like most of the 4xx devices, we may need the index for programming
the CPM power control retisters - and we didn't notice you were also
using for the incorrect purpose of supplying an index to the i2c
layer.

Please note that cell-index *does* *not* *work* for the global index
if there are multiple SoC-like units in the system.  For its correct
purpose of indexing the CPM registers, cell-index must be local to the
SoC, for the global index it must not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
