Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 13D56DEBCE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:10:23 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so141316anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:10:22 -0700 (PDT)
Message-ID: <fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:10:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <48480B3C.9080101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de> <4848036D.5060004@freescale.com>
	<484809D1.2070300@scram.de> <48480B3C.9080101@freescale.com>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 9:50 AM, Timur Tabi <timur@freescale.com> wrote:
> Jochen Friedrich wrote:
>> Hi Timur,
>>
>>> In situations where it doesn't matter which I2C bus is #1 and which one is #2,
>>> then I think the code should just initialize idx based on the order the nodes
>>> are found in the tree.
>>>
>>> In situations where it does matter, then we should use cell-index.
>>
>> that's what I did in i2c-cpm, as well. However, here I use the property
>> "linux,i2c-index" instead (see http://patchwork.ozlabs.org/linuxppc/patch?id=18603).
>
> Well, I just don't see the point of having two different properties that say the
> same thing.  I'm not an IEE 1275 purist, so I don't think we should be hampered
> by old node definitions.  I especially don't like having a property specifically
> for indexing I2C nodes that can't be used to enumerate other nodes.
>
> The DMA and SSI controllers on Freescale parts use cell-index to enumerate them.
>  It just seems dumb to invent a new property.
>
> Will there ever be a situation where a node will contain "cell-index" and
> "linux,i2c-index"?

You are trying to describe 2 different things.  cell-index is purely
for identifying multiple devices within a silicon block that share
resources.  Indexing devices has a very different scope.  The whole
scheme breaks the moment you put down 2 identical multifunction
peripherals into the same system.  If the chip has multiple devices
that share resources, and those resources are described with cell
index; then you'll get something like this (notice how cell-index
values are duplicated):

multifunction@0 {
        #size-cells = <1>;
        #address-cells = <1>;
        ranges = <0 0xe00000000 0x1000>;
        i2c@0 {
                cell-index = <0>;
                regs = <0 0x100>;
        }
        i2c@100 {
                cell-index = <1>;
                regs = <0x100 0x100>;
        }
}
multifunction@1 {
        #size-cells = <1>;
        #address-cells = <1>;
        ranges = <0 0xe10000000 0x1000>;
        i2c@0 {
                cell-index = <0>;
                regs = <0 0x100>;
        }
        i2c@100 {
                cell-index = <1>;
                regs = <0x100 0x100>;
        }
}

cell-index must *not* be repurposed as a system level index.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
