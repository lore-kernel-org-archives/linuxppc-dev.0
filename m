Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 7DD99DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 14:50:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so245874and
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 19:50:45 -0800 (PST)
Message-ID: <fa686aa40711121950p1d18cc76sb5fdb93e4a6fbf8f@mail.gmail.com>
Date: Mon, 12 Nov 2007 20:50:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sri nava kala devi Valteti, TLS-Chennai" <srinavakalav@hcl.in>
Subject: Re: MPC5200B - Mapping Micrel Ethernet Controller Chip
In-Reply-To: <66E8AEE9980BB44CA5FCAD39EBA56AC602D55576@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <66E8AEE9980BB44CA5FCAD39EBA56AC602D55576@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
Cc: "Prakash Palanisamy, TLS-Chennai" <prakashp@hcl.in>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/12/07, Sri nava kala devi Valteti, TLS-Chennai
<srinavakalav@hcl.in> wrote:
>
> We are using MPC5200B based custom board. In that we have an external Micrel's ethernet controller mapped at 0xE0000000.
>
> We have taken Lite5200 code as a reference to port linux to our new board. We have integrated the ethernet driver given by the vendor (Micrel).
>
> Unfortunately, we are not able to access the chip mapped at 0xE0000000.

Are you *sure* it's mapped at physical address 0xe0000000? (ie. have
you verified that you can access the device registers via u-boot or a
debugger?)  The chip selects on the 5200 are programmable so you need
to make sure that the chip select wired to the Micrel device is
actually configured for base address 0xe0000000.

There are up to 8 CS pins on the MPC5200B; LP_CS0 through LP_CS7.  See
section 9.7.1 in the MPC5200B user manual for details on how to
configure them.

> We performed the following steps to access the chip:
>
> i) We mapped this address range of the Ethernet Controller Chip in function "mpc52xx_map_io" as
>
> "io_block_mapping(0xE0000000, 0xE0000000, 0x10000000, _PAGE_IO)"

You don't want to call this.  ioremap is the only function you should
need to call.  But *first*, you must make sure the CS pin is
configured correctly.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
