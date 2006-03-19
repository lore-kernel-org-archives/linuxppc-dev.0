Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 400A3679E0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Mar 2006 10:48:25 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k2JNmH7o004775
	for <linuxppc-embedded@ozlabs.org>; Mon, 20 Mar 2006 00:48:17 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <441DEDAE.4000204@246tNt.com>
Date: Mon, 20 Mar 2006 00:47:58 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
Subject: Re: Who calls my init_module when my driver is not a module?
References: <200603192141.52239.antonio.dibacco@aruba.it>
In-Reply-To: <200603192141.52239.antonio.dibacco@aruba.it>
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

Antonio Di Bacco wrote:
> I wrote an SPI driver, I decided to link it against the kernel but I'm 
> wondering where my init_module will be called.
>
> Anyone knows?
>
> Bye,
> Antonio

>From include/linux/init.h :

/**
 * module_init() - driver initialization entry point
 * @x: function to be run at kernel boot time or module insertion
 *
 * module_init() will either be called during do_initcalls (if
 * builtin) or at module insertion time (if a module).  There can only
 * be one per module.
 */
#define module_init(x)  __initcall(x);


    Sylvain
