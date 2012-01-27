Return-Path: <benh@kernel.crashing.org>
Message-ID: <1327702113.24487.19.camel@pasglop>
Subject: Re: [RFCv2 00/14]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 28 Jan 2012 09:08:33 +1100
In-Reply-To: <CACxGe6vA6CSCAU82uuMaycqDBt+JG3KvXzAURDWQ0Deyeg13Ow@mail.gmail.com>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <4F1DD6DF.4080706@gmail.com> <4F200DFD.7070407@ti.com>
 <4F204F1C.70908@gmail.com>
 <CACxGe6vA6CSCAU82uuMaycqDBt+JG3KvXzAURDWQ0Deyeg13Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Cousson, Benoit" <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Rob Herring <robherring2@gmail.com>, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-01-26 at 14:33 -0700, Grant Likely wrote:

> I've got the x86 fix in my tree now.  It will be part of the next
> merge.  MIPS, Microblaze and OpenRISC cannot turn on CONFIG_IRQ_DOMAIN
> without rework.  I just hacked together the microblaze version, but
> Michal will have to verify that it is correct.  I just posted it.  It
> will be similar for the other two.
> 
> The real problem is sparc which does something entirely different for
> irqs.  Rather than resolving irqs on-demand, it calculates the Linux
> irq numbers at boot time for every node in the tree.  The irq_domains
> will need to be set up for all interrupt controllers before sparc
> begins it's big walk of the tree to resolve interrupts.  I haven't dug
> into everything that needs to be done to support this.
> 
> I don't think you can count on turning on IRQ_DOMAIN on all
> architectures just yet.  Adding irq_domain support directly to
> irq_generic_chip is going to be difficult for that reason.  However,
> it would be useful to have an irq_domain+irq_generic_chip wrapper that
> can be enabled only when IRQ_DOMAIN is enabled.

Beware also that there are plenty of cases where 1 irq domain != 1 irq
chip, for example on cell or xics where a single domain can encompass
multiple chips. I don't know whether x86 APICs are the same, they could
be tho :-)

Cheers,
Ben.
