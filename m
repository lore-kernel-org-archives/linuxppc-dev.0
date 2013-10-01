Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 18:25:48 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] hwrng: Add a driver for the hwrng found in power7+
 systems
Message-ID: <20131001082547.GA27484@concordia>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-2-git-send-email-michael@ellerman.id.au>
 <1380182487.28561.22.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380182487.28561.22.camel@pasglop>
Cc: tytso@mit.edu, kvm@vger.kernel.org, gleb@redhat.com,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 agraf@suse.de, herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com, pbonzini@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 26, 2013 at 06:01:27PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-09-26 at 16:31 +1000, Michael Ellerman wrote:
> 
> > +       pr_info("registered powernv hwrng.\n");
> 
> First letter of a line should get a capital :-) Also since
> it's per-device, at least indicate the OF path or the chip number or
> something ...

It's not the first letter, it looks like this:

  powernv-rng: registered powernv hwrng.

Which looks nice to me, but I can make it this if you prefer:

  powernv-rng: Registered powernv hwrng.


And it's not per-device due to the trick in the probe routine. It's a
bit sneaky but we need to make it a proper driver for module loading to
work, but we only want to register one hwrng device.

cheers
