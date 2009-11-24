Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FC911007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 11:01:37 +1100 (EST)
In-Reply-To: <1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Date: Tue, 24 Nov 2009 01:08:14 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Albert,

> +asm ("\n\


A file scope asm?!  Please don't.

> + * We enter with the cache enabled, the MMU enabled and some known  
> legacy
> + * memory mappings active. xBAT3 is unused

It would be good if you could depend as little as possible on these  
things;
that makes writing another bootloader a lot easier.

> +	/* IBAT3,DBAT3 for first 16Mbytes */\n\
> +	li	8, 0x01ff	/* 16MB */\n\
> +	li      9, 0x0002	/* rw */\n\
> +	mtspr   0x216, 8	/* IBAT3U */\n\
> +	mtspr   0x217, 9	/* IBAT3L */\n\
> +	mtspr   0x21e, 8	/* DBAT3U */\n\
> +	mtspr   0x21f, 9	/* DBAT3L */\n\

WIMG=0000, are you sure?  Not M=1?

> +	bcl-    20,4*cr7+so,1f\n\

Just write  bcl 20,31,1f .


Segher
