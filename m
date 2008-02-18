Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id F229CDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:30:08 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1817694anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 10:30:07 -0800 (PST)
Message-ID: <fa686aa40802181030u4f411172wf7123b14d4a6042@mail.gmail.com>
Date: Mon, 18 Feb 2008 11:30:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: How to describe FPGA-based devices in the device tree ?
In-Reply-To: <20080218174701.GA3835@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200802181343.54989.laurentp@cse-semaphore.com>
	<20080218174701.GA3835@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 18, 2008 10:47 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Feb 18, 2008 at 01:43:52PM +0100, Laurent Pinchart wrote:
> > Should I put IP core nodes as children of the FPGA node ?
>
> You could do that as well.

I'd recommend doing that, then your subnodes are isolated from changes
to the bus attachment (chipselect).  (really an insignificant point,
but I think it is a more logical layout).

So, something like this:
fpga@4,0 {
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0 4 0 00100000>;
        /* breakdown of 'ranges' fields: */
        /* "0": start address of internal range */
        /* "4 0": start address of external range (chip select 4, address 0) */
        /* "00100000: size of range */

        iocore@0 {
                compatible = "foo,bar";
                reg = <0 00010000>;
        };

        iocore@10000 {
                compatible = "foo,bar";
                reg = <10000 00010000>;
        };

        iocore@20000 {
                compatible = "foo,bar";
                reg = <20000 00010000>;
        };
};

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
