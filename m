Return-Path: <jmasel@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 352EB679FE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 01:38:01 +1000 (EST)
From: "Jonathan Masel" <jmasel@arabellasw.com>
To: "'McMullan, Jason'" <jason.mcmullan@timesys.com>
Date: Thu, 19 May 2005 18:37:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1116509554.9050.127.camel@jmcmullan.timesys>
Message-Id: <E1DYn5o-0000PK-00@gold.webfusion.co.uk>
Cc: 'PPC_LINUX' <linuxppc-embedded@ozlabs.org>
Subject: RE: Arabella Resource Manager
Reply-To: jmasel@arabellasw.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jason,
The code is actually much more flexible than that. I only sent a sample
yesterday (you got down to the nitty-gritty a little quicker than I had
thought!). I've uploaded all RM source code to our FTP server
(ftp.arabellasw.com - user ft.rm, passwd arabella). There's no real
documentation (outside source/comments) on the internals - sorry.

Chip-specific code registers the resource types, etc something like you
suggest. API's can be at the very generic RM level (see resmgr.h) but a chip
driver would usually operate at the more convenient chip-level interface.
So, the chip-specific RM code decides which types of resources can be
alloc/freed by the RM (for PQ's that's usually xcc, clocks, pins and dpram)
and the parameters necessary in each case.

We've never used it (yet) outside PQ family, though I don't see any reason
why it can't be.

The files in the tar file (misnamed resmsg.gz.tar!) are
pq1brddef.h - PQ1-specific board definitions
pq1defs.h - PQ1-specific chip definitions
pqrm.c - PQ1-specific RM code (should be called pq1rm.c!)
pq1rm.h - PQ1-specific RM definitions

pq2brddef.h - PQ2-specific board definitions
pq2defs.h - PQ2-specific chip definitions
pq2rm.c - PQ2-specific RM code
pq2rm.h - PQ2-specific RM definitions

pq3brddef.h - PQ3-specific board definitions
pq3defs.h - PQ3-specific chip definitions
pq3rm.c - PQ3-specific RM code
pq3rm.h - PQ3-specific RM definitions

pqbrddef.h - PQ family board-specific information
pqdefs.h - PQ family chip definitions
pqrm.h - PQ family RM code

resmgr.c - generic RM code
resmgr.h - generic RM definitions

Jonathan


Jason wrote:
> 
> Interesting code, but not generic enough.
> What would be nicer would be an API like the following, that can be
> easily extended, and work for more than just PQ (and ppc, for that
> matter)
> 
> enum bres_type {
> 	BRES_TYPE_CLOCK = 0,
> 	BRES_TYPE_PIN,
> 	BRES_TYPE_CPM_SRAM,
> 	...
> 	BRES_TYPE_MAX,
> }
> 
> struct bres_pool {
> 	struct resource *pool;
> 	int (*set)(int id, ...);
> 	int (*clear)(int id);
> };
> 
> /* Board setup will set up the available regions
>  * into this array, similar as to how the PCI
>  * system sets up the iomem areas.
>  */
> struct bres_pool *board_resource[BRES_TYPE_MAX];
> 
> /* Request a resource out of the available pools
>  */
> int bres_request(enum bres_type type, const struct resource *req);
> 
> /* Free a requested resource
>  * This also calls the 'clear' function of the pool.
>  */
> int bres_release(enum bres_type type, const struct resource *res);
> 
> 
> /* After request completes, you can 'instance'
>  * the resource.
>  */
> 
> /* Wire a pin
>  * pin is the same as you requested in the resource
>  * pin type is defined in either the board or SoC CPU headers
>  *  (ie CPM_PB17_SDL)
>  */
> static inline int bres_pin_wire_as(int pin, int pin_type)
> {  return board_resource[BRES_TYPE_PIN].instance(pin, pin_type); }
> 
> /* Wire a clock
>  */
> static inline int bres_clock_wire_as(int clock, int clock_target,
> 			int multiplier, int divider)
> {  return board_resource[BRES_TYPE_CLOCK].instance(pin, pin_type); }
> 
> ...etc....
> 
> 
> 
> --
> Jason McMullan <jason.mcmullan@timesys.com>
> TimeSys Corporation
