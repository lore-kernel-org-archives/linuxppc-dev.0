Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 702DCDE1E2
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 21:42:14 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so846203rnf.16
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jul 2008 04:42:12 -0700 (PDT)
Subject: Re: libfdt: Increase namespace-pollution paranoia
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080709041024.GB29648@yookeroo.seuss>
References: <20080709041024.GB29648@yookeroo.seuss>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 07:42:03 -0400
Message-Id: <1215603723.13186.0.camel@weaponx>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 14:10 +1000, David Gibson wrote:
> libfdt is supposed to easy to embed in projects all and sundry.
> Often, it won't be practical to separate the embedded libfdt's
> namespace from that of the surrounding project.  Which means there can
> be namespace conflicts between even libfdt's internal/static functions
> and functions or macros coming from the surrounding project's headers
> via libfdt_env.h.
> 
> This patch, therefore, renames a bunch of libfdt internal functions
> and macros and makes a few other chances to reduce the chances of
> namespace collisions with embedding projects.  Specifically:
> 	- Internal functions (even static ones) are now named _fdt_*()
> 
> 	- The type and (static) global for the error table in
>           fdt_strerror() gain an fdt_ prefix
> 
> 	- The unused macro PALIGN is removed
> 
> 	- The memeq and streq macros are removed and open-coded in the
>           users (they were only used once each)
> 
> 	- Other macros gain an FDT_ prefix
> 
> 	- To save some of the bulk from the previous change, an
>           FDT_TAGALIGN() macro is introduced, where FDT_TAGALIGN(x) ==
>           FDT_ALIGN(x, FDT_TAGSIZE)
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

On a slightly unrelated note, are you planning to sync the in-kernel
dtc/libfdt version with the upstream version anytime soon?

josh
