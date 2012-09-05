Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1B322C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 18:57:08 +1000 (EST)
Date: Wed, 5 Sep 2012 10:56:53 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: fix personality handling in
 ppc64_personality()
In-Reply-To: <1346813643.2257.24.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1209051056060.11079@pobox.suse.cz>
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
 <m27gtitfv4.fsf@igel.home>
 <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
 <1346813643.2257.24.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2012, Benjamin Herrenschmidt wrote:

> > Directly comparing current->personality against PER_LINUX32 doesn't work
> > in cases when any of the personality flags stored in the top three bytes
> > are used.
> > 
> > Directly forcefully setting personality to PER_LINUX32 or PER_LINUX
> > discards any flags stored in the top three bytes
> > 
> > Use personality() macro to compare only PER_MASK bytes and make sure that
> > we are setting only the bits that should be set, instead of
> > overwriting the whole value.
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> > 
> > changed since v1: fix the bit ops to reflect the fact that PER_LINUX is 
> > actually 0
> 
> Had already merged v1 (oops.. didn't spot the issue with PER_LINUX being
> 0). Can you send an incremental fixup ?

Hi Benjamin,

actually commit 7256a5d2da56 seems to contain the correct PER_LINUX 
handling, so seems like you picked the right one :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
