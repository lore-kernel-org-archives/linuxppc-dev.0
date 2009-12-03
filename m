Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C15CB7BBD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:49:09 +1100 (EST)
Subject: RE: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pravin Bathija <pbathija@amcc.com>
In-Reply-To: <9D1E2BDCB5C57B46B56E6D80843439EB097BB063@SDCEXCHANGE01.ad.amcc.com>
References: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
	<20091203085628.5140FE6D391@gemini.denx.de>
	<9D1E2BDCB5C57B46B56E6D80843439EB097BB063@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 10:48:38 +1100
Message-ID: <1259884118.2076.1232.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Eric.Moore@lsi.com, Wolfgang Denk <wd@denx.de>,
	linux-scsi@vger.kernel.org, "Desai, Kashyap" <Kashyap.Desai@lsi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 15:21 -0800, Pravin Bathija wrote:
> Hi Wolfgang,

 .../...
 
> > I'm not sure if this one-liner really covers all the related issues.
> > We submitted a similar (but apparently more complete) patch more than
> > a year ago. Dunno why it has never been picked up. See
> > http://thread.gmane.org/gmane.linux.scsi/46082 for reference.
> > 
> 
> I submitted a patch on similar lines several weeks ago and it wasn't
> accepted on grounds that it was too tied to the powerpc platform. Below
> is a link
> 
> http://article.gmane.org/gmane.linux.scsi/55794

I believe the simple patch is fine. But only testing can tell, so it's
up to you guys to test it :-)

None of the churn related to PIO that was in the previous patches is
necessary.

PIO on powerpc "appears" to work just like x86, the illusion is
maintained by the arch code. PIO resources always fit inside 32-bit,
never need to be ioremapped etc... so as long as you use the result of
pci_resource_start() and pass that (or an offset from that) to
inb/outb/intw/outw... PIO should just work, no change is required to the
driver. IE. PIO resources don't contain physical addresses. The powerpc
PCI code puts in there an offset from _IO_BASE to an already ioremapped
area mapping the PCI host bridge IO space. It can use funky pointer
arithmetic so don't be surprised if the values look like negative 32-bit
ints, but it should just work.

The only problem I can see with the driver, which is fixed by the simple
patch, is that for -MMIO-, the resources (which in the case of MMIO do
contain physical addresses) can be >32 bit, and thus must be stored into
a type of the right size before being passed to ioremap(). This is what
the one-liner patch does and according to the patch author, it was
tested and appears to work.

So I'm happy with the one liner patch. If you have more concerns, please
explain precisely what you believe will not work :-)

Cheers,
Ben.
