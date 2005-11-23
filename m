Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16EF6687F1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 04:31:36 +1100 (EST)
Date: Wed, 23 Nov 2005 10:00:33 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@kernel.crashing.org>, Dan Malek <dan@embeddededge.com>,
	"'Aristeu Sergio Rozanski Filho'" <aris@cathedrallabs.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Message-ID: <20051123120033.GA3551@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2005 at 10:05:19AM -0600, Kumar Gala wrote:
> 
> On Nov 23, 2005, at 3:11 AM, Marcelo Tosatti wrote:
> 
> >On Wed, Nov 23, 2005 at 01:40:38PM +1100, Paul Mackerras wrote:
> >>Marcelo Tosatti writes:
> >>
> >>>Paul, you're OK with the following definitions on asm-ppc/io.h?
> >>>
> >>>+/* access ports */
> >>>+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(& 
> >>>(_addr)) |  (_v))
> >>>+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(& 
> >>>(_addr)) & ~(_v))
> >>>+
> >>>+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(& 
> >>>(_addr)) |  (_v))
> >>>+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(& 
> >>>(_addr)) & ~(_v))
> >>
> >>I guess so... how many drivers need these things?
> >
> >Many.
> 
> Shouldn't these go into some non-arch specific location?  I hate  
> making drivers only build on a give arch.

Hi Kumar,

I dont really know the policy for driver placement, but it seems that
it works on a case by case basis.

The files in arch/ppc/8xx_io/ (which is what I think you refer to as
candidates for drivers/), are:

1) commproc.c 
Basic API for dpram access. Core code.

2) micropatch.c
microcode update code/data. Core code.

3) cs4218.h
4) cs4218_tdm.c

cs4218 does not compile at the moment due to syntatical problems,
I've fixed them up and the driver compiles, but I don't know 
if it works (patch attached).

I would not be surprised if the driver has been broken since
long time ago.

Does anyone have hardware to test it? Dan? 

Otherwise we should remove it from the tree, since its unmaintained
and unused.

5) enet.c
6) fec.c

The ENET/FEC network drivers are obseleted by fs_enet.

However there are some PHY descriptions in fec.c which are missing from
fs_enet - we'd better make sure to have them all in the new driver
before removing the old one.

Aris, would you mind looking into this?

Once we have that we can set a deadline at Documentation/feature-removal.txt 
if desired.

Other than those there are no 8xx drivers in arch/ppc/ AFAIK.


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cs42.patch"

@@ -1380,7 +1381,7 @@
 }
 
 static DEFINE_TIMER(beep_timer, cs_nosound, 0, 0);
-};
+//};
 
 static void cs_mksound(unsigned int hz, unsigned int ticks)
 {
@@ -1462,7 +1463,7 @@
 }
 
 static MACHINE mach_cs4218 = {
-	.owner =	THIS_MODULE,
+//	.owner =	THIS_MODULE,
 	.name =		"HIOX CS4218",
 	.name2 =	"Built-in Sound",
 	.dma_alloc =	CS_Alloc,
@@ -2475,6 +2476,7 @@
 	volatile smc_t		*sp;
 	volatile smc_uart_t	*up;
 	volatile immap_t	*immap;
+	unsigned long	dp_addr;
 
 	has_sound = 0;
 

--XsQoSWH+UP9D9v3l--
