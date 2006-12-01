Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id BB11367B77
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 00:41:42 +1100 (EST)
Message-ID: <45702A07.2030303@smiths-aerospace.com>
Date: Fri, 01 Dec 2006 08:11:35 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: libfdt - flat tree manipulation library
References: <20061127055905.GA6428@localhost.localdomain>	<20061129055904.GA11883@localhost.localdomain>
	<20061201060038.GA25476@localhost.localdomain>
In-Reply-To: <20061201060038.GA25476@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Nov 29, 2006 at 04:59:04PM +1100, David Gibson wrote:
>> On Mon, Nov 27, 2006 at 04:59:05PM +1100, David Gibson wrote:
>> [snip]
>>> The code, such as it is, is at:
>>> 	git://ozlabs.org/home/dgibson/git/libfdt.git
>> Code for writing device trees from scratch, sequentially, is now
>> implemented.
> 
> And now support for random access read-write is implemented.  The
> library is now close to feature-complete, cleanups and convenience
> wrappers remain.

Hi David,

You have not gotten any feedback on your library efforts.  I just 
thought I would let you know I am interested in your code for possibly 
using it in u-boot.  I have not had time to review it carefully and 
compare it to (a) existing u-boot fdt code and (b) current linux fdt 
support but intend to do that soon.

The existing u-boot fdt code is pretty crude (IMHO - makes (a) above a 
nobrainer) and could bear replacing with something that has more 
widespread support and is more flexible.  Easier to use would be a big 
bonus. :-)

Size looks pretty comparable.
$ wc -l libfdt/*.c
   124 fdt.c
   237 fdt_ro.c
   310 fdt_rw.c
   226 fdt_sw.c
   115 fdt_wip.c
  1012 total

$ wc -l arch/powerpc/boot/flatdevtree*.c
   880 flatdevtree.c
    51 flatdevtree_misc.c
   931 total

For u-boot purposes, I would like to create a command that can dump a 
fdt starting at a give node (a string, e.g. "/" for the whole thing, 
"/cpus" for the entire CPU node and subnodes, or "/cpus/#cpus" to get 
just one property).  I don't see a way of doing that directly with your 
current interface.  Am I missing something or would I have to add 
something?  The kernel doesn't need to support interactive fdt 
manipulation, but that would be very beneficial for a bootrom like 
u-boot.  (FWIIW, I've done a "prototype" ;-) version of this command 
with the existing u-boot code.)

If the linux kernel were to adopt your library, how do you envision this 
happening?  Replace the existing code with wrappers (your "convenience 
wrappers"?) to provide a backwards compatible interface (looks nasty and 
negates your simplification advantages) or rip out 'n replace?

Thanks for your efforts,
gvb
