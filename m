Return-Path: <fweisbec@gmail.com>
Received: from mail-lb0-x232.google.com (mail-lb0-x232.google.com
 [IPv6:2a00:1450:4010:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E4E72C00BD
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 21:02:08 +1100 (EST)
Received: by mail-lb0-f178.google.com with SMTP id o14so2707557lbi.9
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Oct 2013 03:02:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131025173749.GG19466@laptop.lan>
References: <12083.1382486094@ale.ozlabs.ibm.com>
 <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
Date: Mon, 28 Oct 2013 11:02:01 +0100
Message-ID: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 LKML <linux-kernel@vger.kernel.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Victor Kaplansky <VICTORK@il.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/10/25 Peter Zijlstra <peterz@infradead.org>:
> On Wed, Oct 23, 2013 at 03:19:51PM +0100, Frederic Weisbecker wrote:
> I would argue for:
>
>   READ ->data_tail                      READ ->data_head
>   smp_rmb()     (A)                     smp_rmb()       (C)
>   WRITE $data                           READ $data
>   smp_wmb()     (B)                     smp_mb()        (D)
>   STORE ->data_head                     WRITE ->data_tail
>
> Where A pairs with D, and B pairs with C.
>
> I don't think A needs to be a full barrier because we won't in fact
> write data until we see the store from userspace. So we simply don't
> issue the data WRITE until we observe it.
>
> OTOH, D needs to be a full barrier since it separates the data READ from
> the tail WRITE.
>
> For B a WMB is sufficient since it separates two WRITEs, and for C an
> RMB is sufficient since it separates two READs.

Hmm, I need to defer on you for that, I'm not yet comfortable with
picking specific barrier flavours when both write and read are
involved in a same side :)
