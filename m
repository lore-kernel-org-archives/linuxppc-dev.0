Return-Path: <michael@ellerman.id.au>
Message-ID: <1347597912.6883.1.camel@concordia>
Subject: Re: [PATCH] powerpc: Add an xmon command to dump one or all pacas
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 14 Sep 2012 14:45:12 +1000
In-Reply-To: <20120912210704.54cc517b6f39c8e2f73523af@canb.auug.org.au>
References: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
 <20120912210704.54cc517b6f39c8e2f73523af@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-12 at 21:07 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Wed, 12 Sep 2012 17:52:40 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > +#define DUMP(name, format) \
> > +	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, p->name, \
> > +		(u64)((void *)&(p->name) - (void *)p));
> 
> I must say that I hate macros that reference (assumed) globals 

Well sure, but it's xmon :)

I can change it to take p as a parameter.

> shouldn't you use offsetof(struct paca_struct, name) (from
> linux/stddef.h)?

Yes!

cheers
