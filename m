Return-Path: <srs0=symx=ew=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSxSZ2n8RzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 11:27:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zSxSZ1DcMz8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 11:27:58 +1100 (AEDT)
Date: Sat, 27 Jan 2018 10:27:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] powerpc/powernv: Provide a way to force a core into
 SMT4 mode
Message-ID: <20180127102735.5075a560@roar.ozlabs.ibm.com>
In-Reply-To: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
References: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
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

On Thu, 25 Jan 2018 16:05:12 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> POWER9 processors up to and including "Nimbus" v2.2 have hardware
> bugs relating to transactional memory and thread reconfiguration.
> One of these bugs has a workaround which is to get the core into
> SMT4 state temporarily.  This workaround is only needed when
> running bare-metal.

How often will this be triggered, in practice? If it's infrequent,
then would it be better to just do a smp_call_function on siblings
and get them all spinning there? I'm looking sadly at the added
sync...

Thanks,
Nick
