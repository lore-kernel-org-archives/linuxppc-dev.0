Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 044E067B9F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 10:08:31 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1397698ugc
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 15:08:29 -0800 (PST)
Message-ID: <528646bc0610311508v6d65d4b3t46135123c8e8a1bf@mail.gmail.com>
Date: Tue, 31 Oct 2006 16:08:28 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
In-Reply-To: <1162332664.25682.362.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
	<4547086D.2050808@bplan-gmbh.de>
	<1162284176.25682.320.camel@localhost.localdomain>
	<454712A4.3000501@bplan-gmbh.de> <4547AC30.3090208@bplan-gmbh.de>
	<1162331943.25682.358.camel@localhost.localdomain>
	<528646bc0610311408i3a7a9a7ep11ad54c1779aa4bc@mail.gmail.com>
	<1162332664.25682.362.camel@localhost.localdomain>
Cc: Rigby John-R61273 <jrigby@freescale.com>, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/31/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > This definitely needs to be removed.  It's used to figure out which
> > driver should drive a PSC (based on function).  We've got a device
> > tree to provide this information now.
>
> Which means we should define how that is presented in the devie-tree and
> Nicolas should then update his tree accordingly...

How about this:

<function> := one of [serial, spi, i2s, ac97]

<function>@<psc_offset> {
        port-number = <logical port number>;   // so /dev/ttyPSC#
connects to something sane
        compatible = "mpc5200b-psb\0mpc52xx-psc";
        ... other stuff ...
};

Function is encoded in the node name, and the compatible property
tells linux that it is an mpc52xx-psc in <function> mode.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
