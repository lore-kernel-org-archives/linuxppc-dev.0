Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 6A622DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 07:26:02 +1100 (EST)
Date: Thu, 26 Feb 2009 12:25:58 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
Message-ID: <20090226202558.GB19523@ovro.caltech.edu>
References: <20090224000002.GA578@ovro.caltech.edu>
	<200902261715.28440.arnd@arndb.de>
	<alpine.LRH.2.00.0902261752310.29190@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0902261752310.29190@vixen.sonytel.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 05:53:56PM +0100, Geert Uytterhoeven wrote:
> On Thu, 26 Feb 2009, Arnd Bergmann wrote:
> > On Tuesday 24 February 2009, Ira Snyder wrote:
> > > +/* Virtio-over-PCI descriptors: 12 bytes. These can chain together via "next" */
> > > +struct vop_desc {
> > > +	/* Address (host physical) */
> > > +	__le32 addr;
>                ^^^^
> Only 32-bit? Is this future-proof?
> 

Probably not. If I use __le64 instead, how do I write 64 bytes over the
PCI bus? There isn't an iowrite64()/ioread64() anywhere in Linux.

Thanks,
Ira
