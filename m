Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlLFq2tHGzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 20:51:26 +1000 (AEST)
Date: Wed, 13 Apr 2016 20:51:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, michael.neuling@au1.ibm.com,
 michaele@au1.ibm.com
Subject: Re: [PATCH 1/3] powerpc: Complete FSCR context switch
Message-ID: <20160413205112.425444de@kryten>
In-Reply-To: <1460401065-10540-2-git-send-email-jack@codezen.org>
References: <1460401065-10540-1-git-send-email-jack@codezen.org>
 <1460401065-10540-2-git-send-email-jack@codezen.org>
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

Hi Jack,

> Previously we just saved the FSCR, but only restored it in some
> settings, and never copied it thread to thread. This patch always
> restores the FSCR and formalizes new threads inheriting its setting so
> that later we can manipulate FSCR bits in start_thread.

Will this break the existing FSCR_DSCR bit handling?

         if (cpu_has_feature(CPU_FTR_DSCR)) {
                u64 dscr = get_paca()->dscr_default;
                u64 fscr = old_thread->fscr & ~FSCR_DSCR;

                if (new_thread->dscr_inherit) {
                        dscr = new_thread->dscr;
                        fscr |= FSCR_DSCR;
                }

                if (old_thread->dscr != dscr)
                        mtspr(SPRN_DSCR, dscr);

                if (old_thread->fscr != fscr)
                        mtspr(SPRN_FSCR, fscr);
        }

If not, we should modify the above so we don't write the FSCR twice.

Anton
