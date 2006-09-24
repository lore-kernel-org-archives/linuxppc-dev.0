Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id D3D1F67B52
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 00:35:24 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so384790ugc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 07:35:23 -0700 (PDT)
Message-ID: <528646bc0609240735y5b2b0a1aqbb664bec72e2c04f@mail.gmail.com>
Date: Sun, 24 Sep 2006 08:35:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <45161ADB.4020106@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<87hcz4z47p.fsf@sleipner.barco.com>
	<528646bc0609190717u1c7cd349m7e08e5bafd341c38@mail.gmail.com>
	<528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com>
	<451055D2.5080308@dlasys.net>
	<528646bc0609191427o11146c54q650738bcb10f8d98@mail.gmail.com>
	<45161ADB.4020106@dlasys.net>
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

On 9/23/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> > I've been half heartedly looking at what needs to be done to generate
> > a device tree based on either system.mhs or xparameters.h.  I'm
> > probably going to write a tiny C program that is compiled against
> > xparameters.h and spits out a valid dts file.  The dts file can then
> > be run through the device tree compiler to produce the flattened
> > device tree structure.
>     That sounds somewhat interesting.
>
>     But as was somewhat raised elsewhere - what about partial
> reprogramming the FPGA on the fly ?

Then you'll need to register/unregister devices from the platform bus
on the fly (assuming the FPGA is reprogrammed after control is passed
to Linux).  The device tree is primarily for passing information from
the boot loader to linux.  Once linux is booted and the fdt is used to
populate the platform buss, you can safely ignore it.

> > Device trees don't have to be static.  They can be generated/modified
> > on the fly if the bootloader supports it.  Or you can pass a different
> > tree depending on what IP you have on the board.
>     Can you populate the tree dynamically inside the Linux setup code ?

Yes; there is a common library that is being developed to
generate/modify the device tree from anywhere; boot loader, inside the
kernel (like for kexec), etc.  Search the mailing list.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
