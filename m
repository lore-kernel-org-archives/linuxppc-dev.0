Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2ECF3DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 09:11:02 +1100 (EST)
Message-ID: <47990D51.9080803@scram.de>
Date: Thu, 24 Jan 2008 23:12:33 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Failed to mount rootfs
References: <F795765B112E7344AF36AA911279641502D1A9F4@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A9F4@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Bizhan,

> device-tree: Duplicate name in /, renamed to "chosen#1"

> And here is the device tree:
>     chosen {
>         linux,stdout-path = "/soc8541@e0000000/serial@4600";
>     };
>     chosen {
>         name = "chosen";
>         bootargs = "root=/dev/ram rw console=ttyS1,115200";
>         linux,platform = <600>;
>         linux,initrd-start = <1ef33000>;
>         linux,initrd-end = <1fe190aa>;
>         linux,stdout-path = "/soc8541@e0000000/serial@4600";
>     };

you can't have two chosen nodes. Linux renames the second one to chosen#1 and thus can't find the kernel arguments.

Thanks,
Jochen
