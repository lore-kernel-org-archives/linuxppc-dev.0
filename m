Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJKXm3BwnzDqYg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 00:59:52 +1000 (AEST)
Date: Mon, 30 May 2016 09:59:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for book3s
 64
Message-ID: <20160530145943.GB13157@gate.crashing.org>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464557231.3078.185.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2016 at 07:27:11AM +1000, Benjamin Herrenschmidt wrote:
> > > This enables us to share the same page table code for
> > > both radix and hash. Radix use a hardware defined big endian
> > > page table
> > This is measurably worse (a little over 2% on POWER8) on a futex
> > microbenchmark:
> 
> That is surprising, do we have any idea what specifically increases the
> overhead so significantly ? Does gcc know about ldbrx/stdbrx ? I notice
> in our io.h for example we still do manual ld/std + swap because old
> processors didn't know these, we should fix that for CONFIG_POWER8 (or
> is it POWER7 that brought these ?).

GCC knows about ldbrx.  ldbrx is v2.06, i.e. POWER7 (Cell also has it).
As Michael says, we really want to have a byterev insn as well :-)

GCC does not know this is a big sequence of instructions, and it only
_has_ it as one insn, until after register allocation.  If things get
put in memory it is one insn, but the reg-reg sequence is a whopping
nine instructions :-/


Segher
