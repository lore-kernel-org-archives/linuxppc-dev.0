Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8674FDDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:35:45 +1000 (EST)
Subject: Re: [patch 1/7] ps3: Preallocate bootmem memory for the PS3 FLASH
	ROM storage driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert.Uytterhoeven@sonycom.com
In-Reply-To: <20070525083632.177254000@sonycom.com>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.177254000@sonycom.com>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:35:39 +1000
Message-Id: <1180132539.19517.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 10:36 +0200, Geert.Uytterhoeven@sonycom.com wrote:
> -#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE)
> +#if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
> +    defined(CONFIG_PS3_FLASH_MODULE) ||
> defined(CONFIG_PS3_FLASH_MODULE)

As I said multiple times, imho, #ifdef CONFIG_xxx_MODULE in the kernel
is always a bug.

You should always be able to build the module out of tree afteward and
use it on a kernel that didn't have the CONFIG_xxx_MODULE set imho.

Ben.
