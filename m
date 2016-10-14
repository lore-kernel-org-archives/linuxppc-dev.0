Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swPXj4KRTzDt3b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 21:51:17 +1100 (AEDT)
Received: by mail-pf0-x233.google.com with SMTP id e6so48366767pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 03:51:17 -0700 (PDT)
Subject: Re: [PATCH][RFC] powerpc/64s: Use emergency stack for 0x100 system
 reset interrupt
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161013065106.5389-1-npiggin@gmail.com>
Cc: Anton Blanchard <anton@samba.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <6e4b347e-2c59-ed0a-6012-c8e849f3ff29@gmail.com>
Date: Fri, 14 Oct 2016 21:51:16 +1100
MIME-Version: 1.0
In-Reply-To: <20161013065106.5389-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 17:51, Nicholas Piggin wrote:
> Also use EX_NMI save space. This should give cleaner debug data in
> case kernel stacks have become corrupted.
> 
> MSR_RI is kept clear for the 0x100 handler, because we can't mask it,
> and can't tolerate a reentrant NMI. Technically the 0x100 is not really
> recoverable yet, because it could trample on another emergency stack
> user. This will require a bit more work to safely implement, but for
> now we don't need to recover after a 0x100.
> 
> A little bit of the emergency stack / MSR_RI handling differences seem
> like they can be consolidated with some other handlers. I'll split those
> into a couple more patches before submitting.
> 
> I moved the MC save area in the paca out from between the general and
> slb save areas, and put it with the nmi area because it shouldn't be used
> much.

I think we should document the limitations as discussed

One of them is that sequential system resets have unpredictable behaviour
when done in quick successions. I also don't like some of the naming like
NORI, I would rather prefer NOT_RI, but thats just nit picking

Balbir Singh.
