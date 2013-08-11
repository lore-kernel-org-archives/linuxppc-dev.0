Return-Path: <michael@ellerman.id.au>
Date: Mon, 12 Aug 2013 09:57:58 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Vince Weaver <vince@deater.net>
Subject: Re: [PATCH 5/7] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20130811235758.GA29824@concordia>
References: <20130810174831.GA15551@us.ibm.com>
 <20130810175153.GF15551@us.ibm.com>
 <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 10, 2013 at 10:34:58PM -0400, Vince Weaver wrote:
> On Sat, 10 Aug 2013, Sukadev Bhattiprolu wrote:
> 
> > 
> >  include/uapi/linux/perf_event.h |   55 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 55 insertions(+), 0 deletions(-)
> 
> > +#define __PERF_LE	1234
> > +#define __PERF_BE	4321
> > +
> > +#if defined(__KERNEL__)
> 
> I could be wrong, but I thought files under uapi weren't supposed to 
> contain __KERNEL__ code.  Wasn't that the whole point of uapi?

Yes.
 
> Also having the perf_event interface depend on endianess just seems like a 
> complicated mess.  Can't we just declare the interface to be a certain 
> endianess and have the kernel byte-swap as necessary?

Yes I think so. The interface is already defined and it's little endian,
so on big endian we just need to swap.

The only part I'm not clear on is how things are handled in perf
userspace, it seems to already do some byte swapping.

cheers
