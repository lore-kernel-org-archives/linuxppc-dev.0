Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D23B680F3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Sep 2005 00:58:06 +1000 (EST)
Date: Thu, 1 Sep 2005 11:51:56 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050901145156.GC15489@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet>
	<20050901085319.GB6285@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050901085319.GB6285@isilmar.linta.de>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thu, Sep 01, 2005 at 10:53:19AM +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> > Russell: The driver is using pccard_nonstatic_ops for card window
> > management, even though the driver its marked SS_STATIC_MAP (using
> > mem->static_map).
> 
> This is obviously broken. Where does it fail if pccard_static_ops is used?

IIRC pcmcia_request_io() fails to dynamically allocate IO windows for PCMCIA 
cards because find_io_region returns NULL. 

OTOH, as Magnus noted, the memory windows are static:

 * Because of the lacking offset register we must map the whole card.
 * We assign each memory window PCMCIA_MEM_WIN_SIZE address space.
 * Make sure there is (PCMCIA_MEM_WIN_SIZE * PCMCIA_MEM_WIN_NO
 * * PCMCIA_SOCKETS_NO) bytes at PCMCIA_MEM_WIN_BASE.
 * The i/o windows are dynamically allocated at PCMCIA_IO_WIN_BASE.
 * They are maximum 64KByte each...

socket[i].socket.features = SS_CAP_PCCARD | SS_CAP_MEM_ALIGN | SS_CAP_STATIC_MAP;
socket[i].socket.io_offset = 0;

> > +typedef struct  {
> > +	u_int regbit;
> > +	u_int eventbit;
> > +} event_table_t;
> 
> No typedefs, please.

OK, will fix.
