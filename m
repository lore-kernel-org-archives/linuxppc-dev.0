Return-Path: <prvs=01563da3ac=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2572E2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 19:42:41 +1100 (EST)
Message-ID: <532AA9F8.3060406@keymile.com>
Date: Thu, 20 Mar 2014 09:42:32 +0100
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2, 2/2] powerpc/mpc85xx: add support for Keymile's kmcoge4 board
References: <1392119407-29490-3-git-send-email-valentin.longchamp@keymile.com>
 <20140319230813.GA30481@home.buserror.net>
In-Reply-To: <20140319230813.GA30481@home.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20/2014 12:08 AM, Scott Wood wrote:
> On Tue, Feb 11, 2014 at 12:50:07PM +0100, Valentin Longchamp wrote:
>> +		reset_cpld@1,0 {
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			reg = <1 0 0x80>;
>> +			interrupt-parent = <&mpic>;
>> +			interrupts = <
>> +				4 1 0 0
>> +				5 1 0 0>;
>> +		};
>> +
>> +		chassis_mgmt@3,0 {
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			reg = <3 0 0x100>;
>> +			interrupt-parent = <&mpic>;
>> +			interrupts = <6 1 0 0>;
>> +		};
> 
> Dashes are preferred to underscores in device trees.

OK.

> 
> More importantly, these nodes need proper compatibles and bindings.  Once
> that's done, the name for the nodes should probably be
> "board_control@whatever" for both.
> 

The first one can be board-ctrl. The second however manages things that are
beyond this board and important for other boards in the chassis, so I think
chassis-mgmt is correct.

For the binding/compatbiles issues: in the first discussion I had omitted these
nodes because these are not available (and honestly for such FPGAs I doubt they
will ever be mainlined). We discussed it and concluded that the DTS should
describe the HW and not the drivers available in the kernel so I have now added
them. Do you want me to add the compatible strings we use in our tree even
though there are no bindings ? Leave them as is ? Or drop them ?

Valentin
