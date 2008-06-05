Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 84C91DE77B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:35:43 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so143680anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:35:42 -0700 (PDT)
Message-ID: <fa686aa40806050935g63a8071co1bc52407c97108cc@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:35:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <484811DE.9@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de> <4848036D.5060004@freescale.com>
	<484809D1.2070300@scram.de> <48480B3C.9080101@freescale.com>
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
	<484811DE.9@freescale.com>
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

On Thu, Jun 5, 2008 at 10:18 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> multifunction@0 {
>>         #size-cells = <1>;
>>         #address-cells = <1>;
>>         ranges = <0 0xe00000000 0x1000>;
>>         i2c@0 {
>>                 cell-index = <0>;
>>                 regs = <0 0x100>;
>>         }
>>         i2c@100 {
>>                 cell-index = <1>;
>>                 regs = <0x100 0x100>;
>>         }
>> }
>> multifunction@1 {
>>         #size-cells = <1>;
>>         #address-cells = <1>;
>>         ranges = <0 0xe10000000 0x1000>;
>>         i2c@0 {
>>                 cell-index = <0>;
>>                 regs = <0 0x100>;
>>         }
>>         i2c@100 {
>>                 cell-index = <1>;
>>                 regs = <0x100 0x100>;
>>         }
>> }
>
> What resources are being shared in this example?  Each I2C device has its own
> address ranges.  I don't see how cell-index provides any useful info here.

As I said; *assume* that the i2c devices have shared resources.  I
didn't explicitly show them in the example, but assume that there are
shared registers in the multifunction nodes.

cell-index provides details about which bits in the shared registers
belong to the device, but since there are 2 identical multifunction
devices in the system there are 2 sets of shared regs.  You cannot now
use the values 0, 1, 2 and 3 for each cell index because '2' and '3'
have no valid meaning on how to reference the shared resource.  So,
cell-index isn't useful for enumerating the i2c busses at the system
level.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
