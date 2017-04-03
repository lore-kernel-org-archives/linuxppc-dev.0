Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxmHh1snwzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 08:00:15 +1000 (AEST)
Date: Tue, 4 Apr 2017 08:00:01 +1000
From: Anton Blanchard <anton@samba.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Avoid taking a data miss on every userspace
 instruction miss
Message-ID: <20170404080001.2c03b043@kryten>
In-Reply-To: <20170403205548.Horde.yvekJnoFaOaIi2_bvtIsLA2@messagerie.c-s.fr>
References: <20170403064102.23245-1-anton@ozlabs.org>
 <20170403205548.Horde.yvekJnoFaOaIi2_bvtIsLA2@messagerie.c-s.fr>
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

Hi Christophe,

> > -	if (user_mode(regs))
> > +	if (!is_exec && user_mode(regs))  
> 
> Shouldn't it also check 'is_write' ?
> If it is a store, is_write should be set, shouldn't it ?

Thanks, Ben had the same suggestion. I'll add that further optimisation
in a subsequent patch.

Anton
