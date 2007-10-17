Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0BD21DDF03
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 06:23:11 +1000 (EST)
Message-ID: <47166F3B.2080904@ru.mvista.com>
Date: Thu, 18 Oct 2007 00:23:23 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: loading NOR flash from DT
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>	<20071017144759.320209bd@weaponx.rchland.ibm.com>
	<20071017195542.GA5501@Chamillionaire.breakpoint.cc>
In-Reply-To: <20071017195542.GA5501@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sebastian Siewior wrote:

>>>I have here a MPC8544 DS board with NOR flash on it and Kumar's git
>>>tree. I'm trying to detect this flash with the physmap_of module. I
>>>added a nor_flash block (I used sequoia.dts as an example) into my
>>>device tree on the same level as soc8544 or memory (or between them).
>>>After modprobing physmap_of nothing happend. Then I tried to make a tree
>>>with plb -> opb -> ebc and finally nor_flash but still nothing changed.
>>>
>>>Is there a user space dependency or did I just edit my device tree the
>>>wrong way? Any hints are welcome :)
>>
>>Post your device tree please.  I don't recall MPC8544 even having PLB,
>>OPB, or EBC busses, so they likely aren't getting probed.

[...]
> 	flash@fc000000 {
> 			compatible = "amd,s29gl512n", "cfi-flash";
> 			reg = <fc000000 4000000>;
> 			bank-width = <2>;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			fs@0 {
> 					label = "fs";
> 					reg = <0 f80000>;
> 			};
> 			firmware@f80000 {
> 					label ="firmware";
> 					reg = <f80000 80000>;
> 					read-only;
> 			};

    This looks good, so the problem is it doesn't get registered by the 
platform code as I've said.

WBR, Sergei
