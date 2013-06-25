Return-Path: <michael@ellerman.id.au>
Date: Tue, 25 Jun 2013 11:50:12 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] Do not update sysfs cpu registration from invalid context
Message-ID: <20130625015012.GB14051@concordia>
References: <51C8543F.6080905@linux.vnet.ibm.com>
 <20130624171804.GB3869@cerebellum>
 <20130624191611.GC3869@cerebellum>
 <51C89D47.3050504@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51C89D47.3050504@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 24, 2013 at 02:25:59PM -0500, Nathan Fontenot wrote:
> On 06/24/2013 02:16 PM, Seth Jennings wrote:
> > On Mon, Jun 24, 2013 at 12:18:04PM -0500, Seth Jennings wrote:
> >> On Mon, Jun 24, 2013 at 09:14:23AM -0500, Nathan Fontenot wrote:
> >>> The topology update code that updates the cpu node registration in sysfs
> >>> should not be called while in stop_machine(). The register/unregister
> >>> calls take a lock and may sleep.
> >>>
> >>> This patch moves these calls outside of the call to stop_machine().
> >>>
> >>> Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>
> >>
> >> Reviewed-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
> > 
> > Gah! I _knew_ I should have waited for my cross compiler to finish
> > building.  This thing doesn't build:
> > 
> >   CC      arch/powerpc/mm/numa.o
> > /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c: In function 'arch_update_cpu_topology':
> > /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: 'update' undeclared (first use in this function)
> > /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: (Each undeclared identifier is reported only once
> > /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: for each function it appears in.)
> > 
> > s/update/ud/ in the *_cpu_under_node() calls.
> 
> Oops! Time for patch submission re-education training.

We've all done it, but yes :)

I try to stick to:

  1. write code.
  2. build code.
  3. test code.
  4. submit code.

I imagine you tested an early version of the patch, or on RHEL or
something, but that can bite you like this. Whenever possible you should
build & test the exact code you submit, though that can be hard when
trees are moving quickly underneath you.

cheers
