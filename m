Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz3wK4svwzDqRl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 13:47:13 +1000 (AEST)
Date: Tue, 26 Jul 2016 13:47:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Rename hpte_init_lpar() and move the
 fallback to a header
Message-ID: <20160726134712.6a513843@canb.auug.org.au>
In-Reply-To: <1469504318-9461-2-git-send-email-mpe@ellerman.id.au>
References: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
 <1469504318-9461-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, 26 Jul 2016 13:38:38 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> hpte_init_lpar() is part of the pseries platform, so name it as such.
> 
> Move the fallback implementation for when PSERIES=n into the header,
> dropping the weak implementation. The panic() is now handled by the
> calling code.

Of course, this could have been handled the same way as the native one.

>  	else if (firmware_has_feature(FW_FEATURE_LPAR))
        else if (IS_ENABLED(CONFIG_PPC_PSERIES) && firmware_has_feature(FW_FEATURE_LPAR))
> -		hpte_init_lpar();
> +		hpte_init_pseries();

and no need to modify the header file.
-- 
Cheers,
Stephen Rothwell
