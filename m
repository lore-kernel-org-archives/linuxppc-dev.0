Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3710DDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 05:09:39 +1000 (EST)
Message-ID: <461BE0EC.8090204@freescale.com>
Date: Tue, 10 Apr 2007 14:09:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
References: <11757244213581-git-send-email-timur@freescale.com>	<461AAF2F.2020608@freescale.com>
	<DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
	<461BDB69.4050405@freescale.com>
	<EB6E9F47-C92F-48E0-BC98-13AA3B9C0027@kernel.crashing.org>
In-Reply-To: <EB6E9F47-C92F-48E0-BC98-13AA3B9C0027@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> What's the specific problem you are fixing?  Its not obvious that this 
> patch is addressing a bug.

problem != bug

The problem is that a pointer implies something you can dereference.  But the return value 
from rh_alloc() is only a pointer in a specific circumstance which is not actually used in 
any current code.  So *all* of the callers of rh_alloc() cast the return value to an 
integer type anyway.

In other words, it's wrong to use a pointer.  The value is a generic number, and so the 
type needs to match that.  The code is just better using ulongs.  Also, two redundant 
macros (IS_MURAM_ERR, etc) have been removed and replaced with their generic counterpart 
(IS_ERR_VALUE).

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
