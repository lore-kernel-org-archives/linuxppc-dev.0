Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1327702113.24487.19.camel@pasglop>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <4F1DD6DF.4080706@gmail.com> <4F200DFD.7070407@ti.com>
 <4F204F1C.70908@gmail.com>
 <CACxGe6vA6CSCAU82uuMaycqDBt+JG3KvXzAURDWQ0Deyeg13Ow@mail.gmail.com>
 <1327702113.24487.19.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 27 Jan 2012 15:13:02 -0700
Message-ID: <CACxGe6v2AuUrQu1xdfJkmXk05uHm2SgR3LD0_qTNRfvu-YxH1w@mail.gmail.com>
Subject: Re: [RFCv2 00/14]
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Jan 27, 2012 at 3:08 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2012-01-26 at 14:33 -0700, Grant Likely wrote:
>
>> I've got the x86 fix in my tree now. =A0It will be part of the next
>> merge. =A0MIPS, Microblaze and OpenRISC cannot turn on CONFIG_IRQ_DOMAIN
>> without rework. =A0I just hacked together the microblaze version, but
>> Michal will have to verify that it is correct. =A0I just posted it. =A0I=
t
>> will be similar for the other two.
>>
>> The real problem is sparc which does something entirely different for
>> irqs. =A0Rather than resolving irqs on-demand, it calculates the Linux
>> irq numbers at boot time for every node in the tree. =A0The irq_domains
>> will need to be set up for all interrupt controllers before sparc
>> begins it's big walk of the tree to resolve interrupts. =A0I haven't dug
>> into everything that needs to be done to support this.
>>
>> I don't think you can count on turning on IRQ_DOMAIN on all
>> architectures just yet. =A0Adding irq_domain support directly to
>> irq_generic_chip is going to be difficult for that reason. =A0However,
>> it would be useful to have an irq_domain+irq_generic_chip wrapper that
>> can be enabled only when IRQ_DOMAIN is enabled.
>
> Beware also that there are plenty of cases where 1 irq domain !=3D 1 irq
> chip, for example on cell or xics where a single domain can encompass
> multiple chips. I don't know whether x86 APICs are the same, they could
> be tho :-)

Right, there will be some controllers using multiple irq_generic_chip
instances for a single irq_domain.  Anything with banks of irq
registers is a candidate here.

g.
