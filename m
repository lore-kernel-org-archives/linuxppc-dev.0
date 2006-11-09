Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F09F67CDA
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 09:48:31 +1100 (EST)
Subject: Re: APUS and IOs question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <45533C79.70404@hogyros.de>
References: <1162767333.28571.254.camel@localhost.localdomain>
	<454F5259.3020107@hogyros.de>  <454F5E44.4040301@genesi-usa.com>
	<1162844529.28571.327.camel@localhost.localdomain>
	<455081AC.3010301@hogyros.de>
	<1162931605.28571.491.camel@localhost.localdomain>
	<45533C79.70404@hogyros.de>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 09:48:39 +1100
Message-Id: <1163112519.4982.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> My plan for moving APUS to arch/powerpc involves writing a new
> bootloader (I'm currently hacking binutils to support AmigaOS binaries)
> that builds a proper flattened device tree and calls the kernel, but I'm
> not sure where the kernel virtual mapping that allows the kernel to run
> from a fixed address should be set up -- if in the bootloader, the
> kernel needs to be aware that changing the MMU settings will yield
> interesting results, and if in the kernel, we need some platform
> specific init code to handle that.

Well, the problem is that you basially have to hack the linear mapping,
thus hitting anything that relies on __pa/__va or operating in real mode
indeed.

How do you do for exception vectors ? Since those have to be either at 0
or at ff* ? You stick branches at 0 to jump to where the kernel
resides ?

Ben.
