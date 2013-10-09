Return-Path: <michael@ellerman.id.au>
Date: Wed, 9 Oct 2013 12:27:41 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9][v5] powerpc: implement is_instr_load_store().
Message-ID: <20131009012740.GB23780@concordia>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053519.GC17237@concordia>
 <20131008193117.GA699@us.ibm.com>
 <1381280599.15322.1.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381280599.15322.1.camel@concordia>
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 09, 2013 at 12:03:19PM +1100, Michael Ellerman wrote:
> On Tue, 2013-10-08 at 12:31 -0700, Sukadev Bhattiprolu wrote:
> > Michael Ellerman [michael@ellerman.id.au] wrote:
> > | bool is_load_store(int ext_opcode)
> > | {
> > |         upper = ext_opcode >> 5;
> > |         lower = ext_opcode & 0x1f;
> > | 
> > |         /* Short circuit as many misses as we can */
> > |         if (lower < 3 || lower > 23)
> > |             return false;
> > 
> > I see some loads/stores like these which are not covered by
> > the above check. Is it ok to ignore them ?
> > 
> > 	lower == 29: ldepx, stdepx, eviddepx, evstddepx
> > 
> > 	lower == 31: lwepx, lbepx, lfdepx, stfdepx,
> 
> Those are the external process ID instructions, which I've never heard
> of anyone using, I think we can ignore them.
> 
> > Looking through the opcode maps, I also see these for primary
> > op code 4:
> > 
> > 	evldd, evlddx, evldwx, evldw, evldh, evldhx.
> > 
> > Should we include those also ?
> 
> Yes I think so. I didn't check any of the other opcodes for you.

Paul points out these are for the SPE extension, which we also don't
care about. So ignore those as well.

cheers
