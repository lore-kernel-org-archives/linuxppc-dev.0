Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLHBc08FpzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 00:22:31 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9NDMTHh015961
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 13:22:29 GMT
Date: Mon, 23 Oct 2017 16:20:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexander.Steffen@infineon.com
Cc: jarkko.sakkinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 elfring@users.sourceforge.net, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 clabbe.montjoie@gmail.com, jgunthorpe@obsidianresearch.com,
 jsnitsel@redhat.com, kgold@linux.vnet.ibm.com, mpe@ellerman.id.au,
 nayna@linux.vnet.ibm.com, paulus@samba.org, PeterHuewe@gmx.de,
 stefanb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Message-ID: <20171023132045.nsfim65xlhznbgfy@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <20171018144811.klfmzikibuux77pf@linux.intel.com>
 <8afa2fb8d8704aff804cd8da15e931da@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8afa2fb8d8704aff804cd8da15e931da@infineon.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 04:58:23PM +0000, Alexander.Steffen@infineon.com wrote:
> > On Tue, Oct 17, 2017 at 11:50:05AM +0000, Alexander.Steffen@infineon.com
> > wrote:
> > > > > Replace the specification of data structures by pointer dereferences
> > > > > as the parameter for the operator "sizeof" to make the corresponding
> > > > > size
> > > > > determination a bit safer according to the Linux coding style
> > > > > convention.
> > > >
> > > >
> > > > This patch does one style in favor of the other.
> > >
> > > I actually prefer that style, so I'd welcome this change :)
> > >
> > > > At the end it's Jarkko's call, though I would NAK this as I think some
> > > > one already told this to you for some other similar patch(es).
> > > >
> > > >
> > > > I even would suggest to stop doing this noisy stuff, which keeps people
> > > > busy for nothing.
> > >
> > > Cleaning up old code is also worth something, even if does not change
> > > one bit in the assembly output in the end...
> > >
> > > Alexander
> > 
> > Quite insignificant clean up it is that does more harm that gives any
> > benefit as any new change adds debt to backporting.
> > 
> > Anyway, this has been a useful patch set for me in the sense that I have
> > clearer picture now on discarding/accepting commits.
> 
> Indeed. I have now a better understanding for why some code looks as ugly as it does.
> 

These patches aren't a part of a sensible attempt to clean up the code.

The first two patches are easy to review and have a clear benefit so
that's fine any time.

Patch 3 updates the code to a new style guideline but it doesn't really
improve readability that much.  Those sorts of patches are hard to
review because you have to verify that the object code doesn't change.
Plus it messes up git blame.  It's good for new code and staging, but
for old code, it's probably only worth it if there are other patches
which make worth the price.  You're basically applying it to make the
patch sender happy.

With patch 4, the tpm_ibmvtpm_probe() function was buggy and it's still
buggy after the patch is applied.  It's a waste of time re-arranging the
code if you aren't going to fix the bugs.

regards,
dan carpenter
