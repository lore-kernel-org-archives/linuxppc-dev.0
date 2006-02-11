Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0257467A04
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 02:27:56 +1100 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k1BFRbKE018209
	for <linuxppc-embedded@ozlabs.org>; Sat, 11 Feb 2006 16:27:42 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43EE029A.5040504@246tNt.com>
Date: Sat, 11 Feb 2006 16:28:26 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Asier Llano Palacios <a.llano@ziv.es>
Subject: Re: Stability of MPC5200 FEC
References: <1139592010.14894.22.camel@localhost.localdomain>
In-Reply-To: <1139592010.14894.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Cc: John Rigby <jrigby@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Asier Llano Palacios wrote:
> We are working with MPC5200 cpu. 
> We've been using it since early 2.6 kernel versions.
> We're currently quite stabilished with the version of the kernel Sylvain
> had before the Platform Device rework. But the problem is that we are
> experiencing that the FEC stops working after a long uptime.

Did you ever observe that behavior on a lite5200 ?
What is 'long uptime' and do you have sustained transfer during that
period ? (To try reproduice the problem).

Also, what are the 'symptoms' ? (anything in dmesg ?)

> So, do you think that the current git version is more stable than the
> one we are using? Do you think that there is anything that could stop us
> upgrading to the latest version?

Doubtfull, I haven't touched the FEC code much except to remove the
aligment code (newer bestcomm microcode doesn't require alignement of
the skb). It should be reworked to use the generic phy code and remove
some "bugs" (like the fact when we down the interface, we stop the task
but not deactivate the MAC IIRC, which cause warning in dmesg).

You can send me the driver/net/fec_mpc52xx and arch/ppc/syslib/bestcomm
you're using, I'll tell you if there was major changes.

> The problem is that we have a custom board, with some custom devices, so
> it is not so easy to upgrade. We need to know that a new version, is
> more stable than the previous one, before we upgrade. As soon as we
> upgrade, we can help if we find any problem.



Sylvain
