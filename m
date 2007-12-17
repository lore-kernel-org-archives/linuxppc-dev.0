Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 148CBDDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 02:27:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so610694anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 07:27:20 -0800 (PST)
Message-ID: <fa686aa40712170727p187ba958kf339fabf01d19d24@mail.gmail.com>
Date: Mon, 17 Dec 2007 08:27:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
In-Reply-To: <87d4t5a5zj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<20071217041455.GA3477@localhost.localdomain>
	<fa686aa40712162030q6f0e6d87j5e6e5379cbd0d54e@mail.gmail.com>
	<87d4t5a5zj.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/17/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  >> > 3) Uartlite requires a port-number property for the console to work.
>  >>
>  >> Why?  In general we try to avoid magical sequence numbers - cell-index
>  >> should *only* be used when it's needed to index or program some shared
>  >> register.
>
>  Grant> Aliases is probably the correct construct for this.
>  Grant> port-number was a bad idea and I never should have gone that
>  Grant> direction.
>
> Perhaps it would make more sense to add a _find_match_or_unused(port)
> like 8250.c and make the initialization order define the index instead
> of explicitly setting it?

aliases I think is the better approach as it is an already established
convention.

enumeration based on init order is fragile and there is no guarantee
that order will not change in the future.

>
> Now we're at it - Why isn't the uartlite of glue handled by of_serial.c?

The of_serial.c glue is IMHO too complex for the uartlite case.  I saw
no advantage provided by the added complexity.  (ulite_of_probe() is
all of 12 lines of code).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
