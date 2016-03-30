Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZbng06VPzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 16:30:15 +1100 (AEDT)
Subject: Re: mailman From rewriting [was perf jit: genelf makes assumptions
 about endian]
To: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20160329175944.33a211cc@kryten> <56FA435A.5010804@ozlabs.org>
 <20160329210639.12136fd5@canb.auug.org.au>
From: Jeremy Kerr <jk@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <56FB6464.4010609@ozlabs.org>
Date: Wed, 30 Mar 2016 13:30:12 +0800
MIME-Version: 1.0
In-Reply-To: <20160329210639.12136fd5@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

>> Do you know why mailman would be re-writing From: there? It's confusing
>> patchwork, as multiple mails are now coming from that address.
> 
> Yep, Anton posts from samba.org.  They publish a DMARC policy that
> breaks mailing lists.

(╯°□°)╯︵ ┻━━┻

This also breaks git-am:

  [jk@pudge linux]$ git am incoming.eml
  Applying: perf jit: genelf makes assumptions about endian
  [jk@pudge linux]$ git log --format='format:%an <%ae>' -1
  Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

> The best thing we can do is to do the above rewrite of the From header.

OK, it looks like we're stuck either way with DMARC. Could we make this
a little more tolerable by stashing the original From: value in a new
header? I know it's already in Reply-To, but that could also be set by
arbitrary other (non-mailman-DMARC-rewrite) sources.

Alternatively, if there's some other way to tell that this a mail has
been rewritten, we can know to use Reply-To in preference to From.

Otherwise, I guess we could require that *all patch submitters* put
their From: line in the content of their mails, as git send-email does
when user != author. But that's a little less-than-optimal.

Cheers,


Jeremy
