Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSHpl5yy1zDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 12:10:39 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id s62so23472668pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:10:39 -0700 (PDT)
Message-ID: <1494987032.30802.6.camel@gmail.com>
Subject: Re: [RFC 0/2] Consolidate patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 May 2017 12:10:32 +1000
In-Reply-To: <20170516222015.Horde.fwWhnIwI59SuB64Du97wdg2@messagerie.c-s.fr>
References: <20170516222015.Horde.fwWhnIwI59SuB64Du97wdg2@messagerie.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 22:20 +0200, LEROY Christophe wrote:
> Balbir Singh <bsingharora@gmail.com> a écrit :
> 
> > patch_instruction is enhanced in this RFC to support
> > patching via a different virtual address (text_poke_area).
> > The mapping of text_poke_area->addr is RW and not RWX.
> > This way the mapping allows write for patching and then we tear
> > down the mapping. The downside is that we introduce a spinlock
> > which serializes our patching to one patch at a time.
> 
> Very nice patch, would fit great with my patch for impmementing  
> CONFIG_DEBUG_RODATA (https://patchwork.ozlabs.org/patch/754289 ).
> Would avoid having to set the text area back to RW for patching
> 

Awesome! It seems like you have some of the work for CONFIG_STRICT_KERNEL_RWX
any reason why this is under CONFIG_DEBUG_RODATA? But I think there is
reuse capability across the future patches and the current set.

Cheers,
Balbir  Singh.
