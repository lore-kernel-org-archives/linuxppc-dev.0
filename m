Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC v1] virtio: add virtio-over-PCI driver
Date: Thu, 19 Feb 2009 21:48:04 +1030
References: <20090217222425.GA18801@ovro.caltech.edu>
	<200902181713.03820.rusty@rustcorp.com.au>
	<20090218163835.GA29728@ovro.caltech.edu>
In-Reply-To: <20090218163835.GA29728@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902192148.05651.rusty@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 February 2009 03:08:35 Ira Snyder wrote:
> On Wed, Feb 18, 2009 at 05:13:03PM +1030, Rusty Russell wrote:
> > don't restrict yourself to 32 feature bits (only PCI does this, and they're
> > going to have to hack when we reach feature 32).
> 
> There isn't any problem adding more feature bits. Do you think 128 bits
> is enough?

Probably.  We have unlimited bits in lguest and s390, but 128 is reasonable
for the forseeable future (if not, you end up using bit 128 to mean "look
somewhere else for the rest of the bits).

> > How about prepending a 4 byte length on the host buffers?  Allows host to
> > specify length (for host->guest), and guest writes it to allow truncated
> > buffers on guest->host.
> > 
> > That won't allow you to transfer *more* than one buffersize to the host, but
> > you could use a different method (perhaps the 4 bytes indicates the *total*
> > length?).
> 
> I don't understand how this will help.
> 
> I looked at virtio_net's implemention with VIRTIO_NET_F_MRG_RXBUF, which
> seems like it could really help performance. The problems with that are:
> 1) virtio_net doesn't write the merged header's num_buffers field
> 2) virtio_net doesn't actually split packets in xmit
...
> I'm using two instances of virtio_net to talk to each other, rather than
> a special userspace implementation like lguest and kvm use. Is this a
> good approach?

Well, virtio in general is guest-host asymmetric.  I originally explored
symmetry, but it didn't seem to offer any concrete advantages, so we didn't
require it.  You aren't actually directly connecting two guests, are you?
So this is just a simplification for your implementation?

You could always add a VIRTIO_NET_F_MRG_TXBUF which did what you want, but
note that symmetry breaks down for other virtio uses, too: block definitely
isn't symmetric of course, but I haven't audited the others.

So I'd recommend asymmetry; hack your host to understand chained buffers.

Cheers,
Rusty.
