Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 8 Apr 2005 23:04:58 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050408210458.GA16672@iram.es>
References: <20050408184442.GA13709@iram.es>
	<8497276598d775128a73efb06803a9ba@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8497276598d775128a73efb06803a9ba@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 02:01:13PM -0500, Kumar Gala wrote:
> >Now that I read it carefully, I realize that I was wrong. But there
> >is still some room for optimization; the parameter that you don't
> >need is %3: simply replace lwzx %0,0,%3 by lwz %0,-4(%4).
> 
> Doesn't help, realize that we are going to have "r3" with a pointer to 
> pte.  There is no way w/o an add to get to the next word for the lwarx.

I'd have to see the context. One less parameter to an asm block may
also make the compiler life easier. 

> 
> >But I'm not sure that OOO cannot play tricks on you, what guarantees
> > that the lwz is done after lwarx?
> 
> I'm assuming since its a single asm block, gcc is not allowed to 
> reorder it.

Not GCC, but the hardware. If loads can pass loads and lwarx has
more internal housekeeping overhead (obviously) than lwz. Especially
in the case of a processor with 2 LSU:
- lwarx issued to LSU1
- lwz issued LSU2 in the same clock cycle

I'm not sure at all that that you are guaranteed not to get 
potentially stale data from the lwz on SMP. Loads are weekly 
ordered in general wrt each other and lwarx is no exception
AFAIR. The fact that the two words are guaranteed to be in 
the same cache line makes it extremely unlikely, but not 
impossible.

	Gabriel
