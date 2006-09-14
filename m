Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 9FB5767B69
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 00:34:25 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id i2so1973079nfe
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 07:34:23 -0700 (PDT)
Message-ID: <528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
Date: Thu, 14 Sep 2006 08:34:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Michael Galassi" <mgalassi@c-cor.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <200609141353.k8EDrkPN065101@penguin.ncube.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
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

On 9/14/06, Michael Galassi <mgalassi@c-cor.com> wrote:
> It is also worth noting that as released in MVL pro 4.0.1 it only
> supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
> tagged as deprecated in the current version (8.2.01i) of Xilinx's
> EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
> lengths to break compatibility with older versions.  This will
> presumably be fixed next month when it is rumored that wonderful new
> things will come from Xilinx.  In the mean-time it is possible, though
> neither simple, nor fun, to create Virtex4 designs with the older IP.

So what direction do we (as the community) want to go for supporting
Xilinx IP in the Linux kernel?

IIRC, Xilinx intends to get drivers submitted into mainline.  (Based
on their cross-platform driver support code).  It is unknown which and
how many drivers for different IP versions will be submitted.

However, the xilinx driver code is verbose and does not match well
with the rest of the Linux code base.  (due to the cross platform
support)  Plus, the Xilinx tool work flow is geared towards the EDK
tool overwriting the driver code in the kernel tree with code for the
generated design.  In which case, does it even make sense to accept
Xilinx drivers into the Linux tree when they are just going to get
overwritten by the toolchain anyway?  Unfortunately, regenerating
drivers has it's own problems considering that the license on the
generated code is not GPL compatible at the moment.

If we reject the Xilinx driver code, then we either have to do without
Xilinx support in mainline, or we need to write new drivers that
address the above issues (support multiple IP versions, etc).  The
Xilinx support in mainline right now does not use any Xilinx code.
(Xilinx PIC and UART).

Thoughts?

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
