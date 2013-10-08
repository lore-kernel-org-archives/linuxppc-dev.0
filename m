Return-Path: <michael@ellerman.id.au>
Date: Tue, 8 Oct 2013 15:00:17 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9][v5] powerpc: implement is_instr_load_store().
Message-ID: <20131008040016.GC31666@concordia>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003053519.GC17237@concordia>
 <20131003190325.GB21561@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003190325.GB21561@us.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
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

On Thu, Oct 03, 2013 at 12:03:25PM -0700, Sukadev Bhattiprolu wrote:
> Michael Ellerman [michael@ellerman.id.au] wrote:
> | On Tue, Oct 01, 2013 at 05:15:06PM -0700, Sukadev Bhattiprolu wrote:
> | > Implement is_instr_load_store() to detect whether a given instruction
> | > is one of the fixed-point or floating-point load/store instructions.
> | > This function will be used in a follow-on patch to save memory hierarchy
> | > information of the load/store.
> | 
> | Anyway, I think the following logic is all we need for opcode 31:
> | 
> | bool is_load_store(int ext_opcode)
> 
> how about I call this is_load_store_2_06() and add a comment. Horrible
> but minimizes chance of misuse.

Actually it's is_opcode_31_load_store_2_06() - which is even more
horrible :)

But you can probably fold it in to the main routine and then call that
is_load_store_2_06(). Or whatever seems best, but yeah I think we should
make it very clear that it's only for 2.06.

cheers
