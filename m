Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E045C1007D2
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 08:40:13 +1100 (EST)
Date: Tue, 1 Dec 2009 16:40:06 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: re-enable kexec to allow module loads with
	CONFIG_MODVERSIONS and CONFIG_RELOCATABLE turned on
Message-ID: <20091201214006.GA28171@hmsreliant.think-freely.org>
References: <20091119195216.GC11414@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091119195216.GC11414@hmsreliant.think-freely.org>
Cc: paulus@samba.org, nhorman@tuxdriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Paul, Ben, given that Rusty hasn't come back with any opinion on this patch,
>do you
>> feel comfortable merging it via the ppc tree?  Currently the earlyinit routine
>> is only compiled in and used for your arch, so I think its fairly benign.
>
>Sorry, I *did* track down the archives for linuxppc-dev, then find your post,
>then read your patch.  But I didn't actually reply.
>
>Other than minor issues, there's one significant one: you shouldn't be trying
>to change rodata.  It might work on PPC today, but it's poor form at least.
>
>How's this?  Untested on ppc.
>
I'll try grab a ppc64 system and test this soon.

>Other changes:
>1) I also changed reloc_start to an array; this is a good idea for any
>   linker-defined symbols so the compiler can't make assumptions about size.
Ok, I'll certainly trust your linker skill over mine :)

>2) local.h?  How about module.h?
Seems good to me
>3) I don't think the extra ". = 0" is necessary.
Its not, I was just trying to be clear about where reloc_start was to be placed.

>4) ARCH_USES_RELOC_ENTRIES isn't clear enough for me; I prefer
>   ARCH_RELOCATE_KCRCTAB.
Sounds good to me.


I'll test this as soon as I'm able
Thanks!
Neil
