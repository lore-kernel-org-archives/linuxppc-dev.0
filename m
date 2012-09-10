Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Ian Molton <ian.molton@codethink.co.uk>
Subject: Re: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
Date: Mon, 10 Sep 2012 14:22:13 +0000
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <5028D040.60604@codethink.co.uk> <502D201E.9030304@codethink.co.uk>
In-Reply-To: <502D201E.9030304@codethink.co.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201209101422.13875.arnd@arndb.de>
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, ben.dooks@codethink.co.uk,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 16 August 2012, Ian Molton wrote:
> Ping :)
> 
> Can we get some consensus on the right approach here? I'm loathe to code
> this if its going to be rejected.
> 
> I'd prefer the driver to be properly split so we dont have the MDIO
> driver mapping the ethernet drivers address spaces, but if thats not
> going to be merged, I'm not feeling like doing the work for nothing.
> 
> If the driver is to use the overlapping-address mapped-by-the-mdio
> scheme, then so be it, but I could do with knowing.
> 
> Another point against the latter scheme is that the MDIO driver could
> sensibly be used (the block is identical) on the ArmadaXP, which has 4
> ethernet blocks rather than two, yet grouped in two pairs with a
> discontiguous address range.
> 
> I'd like to get this moved along as soon as possible though.

Following up on the old discussion, I talked briefly about this
issue with BenH at the kernel summit. The outcome basically is that
it's a bit sad to have incompatible bindings, but it's not the end
of the world,and it's more important to do it right this time.

Just make sure that you use different values for the 'compatible'
strings and then do what you need to get the ARM hardware working.

Ideally, the new binding should be written in a way that powerpc
machines can use the same one, but the existing ones all use
an version of Open Firmware that is not going to get updated
and it's also not too likely that we are going to see new
powerpc machines based on this chip.

	Arnd
