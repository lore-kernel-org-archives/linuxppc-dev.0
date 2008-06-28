Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id 456E4DDEFE
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 06:33:59 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so4216849agc.0
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 13:33:58 -0700 (PDT)
Message-ID: <fa686aa40806281333i5ae1833fg561622640b5d3a4e@mail.gmail.com>
Date: Sat, 28 Jun 2008 14:33:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
In-Reply-To: <20080606161932.0650C1500054@mail96-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
	<fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com>
	<20080606161932.0650C1500054@mail96-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 6, 2008 at 10:16 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> legacy_serial identifies a valid ns16550 on a simple-bus, but the
> legacy_serial driver doesn't understand the shift and offset flags
> necessary to get it to work, which results in no console.
>
> I think the easiest solution is to change the Kconfig so that
> PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done this
> in my tree, but I've been swamped with other things at the moment, so I
> haven't verified it.

This is an easy solution, but it is not a good one.  Doing so would
break UDBG on other 405 boards when building multiplatform kernels.
It would be better to teach legacy serial about the shift and offset.
Alternately, add code to add_legacy_soc_port() to skip it if the
shift/offset properties are present.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
