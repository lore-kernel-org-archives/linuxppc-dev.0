Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 13:49:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va
 in tlb invalidate
Message-ID: <20120723034912.GA5019@drongo>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
 <1343006528.29855.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343006528.29855.25.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2012 at 11:22:08AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-07-23 at 09:56 +1000, Paul Mackerras wrote:
> > > That indicate we should not mask the top 16 bits. So remove the
> > same.
> > 
> > Older versions of the architecture (2.02 and earler) require the
> > masking, so we can't just unconditionally remove it, since that would
> > potentially break POWER5 and PPC970.  People are definitely still
> > running Linux bare-metal on PPC970s (though arguably not on POWER5). 
> 
> Are you sure ? I couldn't convince myself ... the old architectures say
> that it only uses some of the bits but it doesn't mark the other ones as
> "reserved" (as in must be 0).
> 
> (At least 1.x, I haven't looked at 2.x with x < 03)

2.01 and 2.02 say bits 0..15 must be zero.

Paul.
