Return-Path: <benh@kernel.crashing.org>
Message-ID: <1333582195.3040.21.camel@pasglop>
Subject: RE: [PATCH 3/4] powerpc/mpic: Move internal interrupt source vector
 allocation to a separate function.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Date: Thu, 05 Apr 2012 09:29:55 +1000
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D0B77F9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1332850586-23610-1-git-send-email-Varun.Sethi@freescale.com>
 <84A55A49-747D-4C87-9E5C-E5C63C0CEDA7@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D0B11BA@039-SN2MPN1-013.039d.mgd.msft.net>
 <BA2352CD-6C54-4D33-86DB-F55DBDBA6E5F@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D0B77F9@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-04 at 19:09 +0000, Sethi Varun-B16395 wrote:
> > I think that is more due to how you added the MPIC error interrupts
> and
> > issues w/that code.  If you are treating the MPIC error interrupts
> as a
> > cascade than they should have a distinct linux IRQ space from the
> > standard MPIC interrupts.  This is how the MSIs work (as an
> example).
> In case of error interrupts we are depending on the mpic_host_maps
> for mapping and interrupt specifier translations. There is no separate
> initialization as in case of MSIs. That's the reason I am treating
> error interrupts as mpic internal interrupt sources. 

It makes sense to have an allocator for MPIC vectors but it should be a
single allocator shared with the MSI code.

Cheers,
Ben.
