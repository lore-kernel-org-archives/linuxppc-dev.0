Return-Path: <benh@kernel.crashing.org>
Message-ID: <1348193607.1132.38.camel@pasglop>
Subject: Re: Deprecating reserve-map in favor of properties
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 21 Sep 2012 12:13:27 +1000
In-Reply-To: <8C5A5EB8-6CD7-4E35-AACF-A2CC04CDBE48@kernel.crashing.org>
References: <1348179051.1132.32.camel@pasglop>
 <8C5A5EB8-6CD7-4E35-AACF-A2CC04CDBE48@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-09-20 at 20:35 -0500, Kumar Gala wrote:
> If you do this, please update the code in dtc/libfdt to construct the
> new nodes.  We use this in u-boot to reserve kernel, dtb, initrd, etc
> regions.  So would be nice to have drop in replacement code that could
> use same APIs if possible.

The kernel would of course still understand the reserve map and I don't
intend to remove it from the header immediately, so I think that can
stay.... unless we make it a function of the version.

It's non-trivial to make the same (stateless) API in libfdt deal with
setting properties. I'd rather avoid that problem initially by not
changing the blob format, keeping the reserve map around for "legacy"
purposes and simply making the kernel capable of understanding the
properties.

Cheers,
Ben.
