Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [patch 0/6] Strong Access Ordering page attributes for POWER7
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <1215128392.7960.7.camel@pasglop>
References: <20080618223254.966080905@linux.vnet.ibm.com>
	<1215128392.7960.7.camel@pasglop>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 09:05:40 -0500
Message-Id: <1215439540.16098.15.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@au1.ibm.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-04 at 09:39 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2008-06-18 at 17:32 -0500, shaggy@linux.vnet.ibm.com wrote:
> > Andrew,
> > 
> > The first patch in this series hits architecture independent code, but the
> > rest is contained in the powerpc subtree.  Could you pick up the first
> > patch into -mm?  I can send the rest of them through the powerpc git tree.
> > The first patch and the rest of the set are independent and can be merged
> > in either order.
> 
>  ../..
> 
> I was wondering... how do we inform userspace that this is available ?
> Same question with adding the endian bit on 4xx which I plan to do using
> your infrastructure...

I hadn't really given it much thought.  Is there a simple way to
determine if the cpu is power 7 or newer?

It's not elegant, but a program could call mmap() with PROT_SAO set and
check for errno == EINVAL.  Then call again without PROT_SAO, if it
needs to.

> We haven't defined a user-visible feature bit (and besides, we're really
> getting short on these...). This is becoming a bit of concern btw (the
> running out of bits). Maybe we should start defining an AT_HWCAP2 for
> powerpc and get libc updated to pick it up ?

Joel,
Any thoughts?

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
