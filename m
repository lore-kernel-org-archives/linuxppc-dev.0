Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393417336.17341.0.camel@concordia>
Subject: Re: [PATCH] powerpc: ftrace: bugfix for test_24bit_addr
From: Michael Ellerman <mpe@ellerman.id.au>
To: ananth@in.ibm.com
Date: Wed, 26 Feb 2014 23:22:16 +1100
In-Reply-To: <20140226043552.GA14672@in.ibm.com>
References: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140226043552.GA14672@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Liu Ping Fan <kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-02-26 at 10:05 +0530, Ananth N Mavinakayanahalli wrote:
> On Wed, Feb 26, 2014 at 10:23:01AM +0800, Liu Ping Fan wrote:
> > The branch target should be the func addr, not the addr of func_descr_t.
> > So using ppc_function_entry() to generate the right target addr.
> > 
> > Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> > ---
> > This bug will make ftrace fail to work. It can be triggered when the kernel
> > size grows up.
> > ---
> >  arch/powerpc/kernel/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> > index 9b27b29..b0ded97 100644
> > --- a/arch/powerpc/kernel/ftrace.c
> > +++ b/arch/powerpc/kernel/ftrace.c
> > @@ -74,6 +74,7 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
> >   */
> >  static int test_24bit_addr(unsigned long ip, unsigned long addr)
> >  {
> > +	addr = ppc_function_entry((void *)addr);
> 
> Won't this break on LE?

ppc_function_entry() just needs to be a nop on LE, as it already is on 32-bit.

cheers
