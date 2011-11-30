Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33F8FB6F75
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 00:10:37 +1100 (EST)
In-Reply-To: <1322630640-13708-6-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-6-git-send-email-tony@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F91E9007-5DA5-4E3A-993E-EA680DE08D79@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/boot: Add mfdcrx
Date: Wed, 30 Nov 2011 14:09:20 +0100
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#define mfdcrx(rn) \
> +	({	\
> +		unsigned long rval; \
> +		asm volatile("mfdcrx %0,%1" : "=r"(rval) : "g"(rn)); \
> +		rval; \
> +	})

"g" is never correct on PowerPC, you want "r" here.  You can write
this as a static inline btw, you only need the #define stuff when
there is an "i" constraint involved.


Segher
