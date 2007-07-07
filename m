Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id 301E2DE141
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 23:29:58 +1000 (EST)
Date: Sat, 7 Jul 2007 15:34:14 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070707133414.GC32740@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
	<200707071508.04143.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707071508.04143.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

On Sat, Jul 07, 2007 at 03:08:03PM +0200, Arnd Bergmann wrote:
> Is this a superset of what the dmaengine API can do? If not, I would
> guess that things can get really confusing for the user.

dmatransfer should replace the dmaengine API. dmaengine has only one client
(the tcp/ip network stack - just a few lines of code) and provides only one
driver (ioatdma).

I would have added a ioatdma driver to dmatransfer but unfortunately I
don't have the hardware..

> Is it possible to wrap the existing dmaengine code inside of a
> dmatransfer implementation?

sure - but that wouldn't make much sense. dmaengine gives away exclusive
use rights to dma channels. so if dmatransfer is using dmaengine, noone
else could use it.

> You should probably have the authors of the dmaengine on Cc in
> your next version of the driver, if you indend to replace their
> code.

I'll write them a personal mail to get things rolling as soon as the next
dmatransfer release with the cleanups you suggested and scatter/gather as
well as fifo support is out.

yours,
 - clifford

-- 
ocaml graphics.cma <( echo 'open Graphics;;open_graph " 640x480"let
complex_mul(a,b)(c,d)=(a*.c-.b*.d,a*.d+.b*.c)let complex_add(a,b)(c
,d)=(a+.c,b+.d);;let rec mandel c n=if n>0 then let z=mandel c(n-1)
in complex_add(complex_mul z z)c else (0.0,0.0);; for x=0 to 640 do
for y=0 to 480 do let c=((float_of_int(x-450))/.200.0,(float_of_int
(y-240))/.200.0) in let cabs2(a,b)=(a*.a)+.(b*.b)in if cabs2(mandel
c 50)<4.0 then plot x y done done;;read_line()' )
