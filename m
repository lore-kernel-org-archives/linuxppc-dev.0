Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BFACF2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 08:19:40 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] powerpc: fix personality handling in ppc64_personality()
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
Date: Thu, 02 Aug 2012 00:19:27 +0200
In-Reply-To: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz> (Jiri
 Kosina's message of "Wed, 1 Aug 2012 22:03:42 +0200 (CEST)")
Message-ID: <m27gtitfv4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Kosina <jkosina@suse.cz> writes:

>  	if (personality(current->personality) == PER_LINUX32
> -	    && personality == PER_LINUX)
> -		personality = PER_LINUX32;
> +	    && personality(personality) == PER_LINUX)
> +		personality &= ~PER_LINUX | PER_LINUX32;

That doesn't work.  ~PER_LINUX is -1, so this is a no-op.

>  	ret = sys_personality(personality);
> -	if (ret == PER_LINUX32)
> -		ret = PER_LINUX;
> +	if (personality(ret) == PER_LINUX32)
> +		ret &= ~PER_LINUX32 | PER_LINUX;

That only "works" because PER_LINUX is 0.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
