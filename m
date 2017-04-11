Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2R0v48QMzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 22:18:38 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 79so29716806pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 05:18:38 -0700 (PDT)
Date: Tue, 11 Apr 2017 22:18:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on
 POWER9 guests
Message-ID: <20170411221818.5a177da0@roar.ozlabs.ibm.com>
In-Reply-To: <87vaqbuueu.fsf@concordia.ellerman.id.au>
References: <20170407125602.31146-1-npiggin@gmail.com>
 <20170407125602.31146-2-npiggin@gmail.com>
 <87vaqbuueu.fsf@concordia.ellerman.id.au>
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

cc'ing Paul

On Tue, 11 Apr 2017 20:10:17 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > POWER9 hypervisors will not necessarily run guest threads together on
> > the same core at the same time, so msgsndp should not be used.  
> 
> I'm worried this is encoding the behaviour of a particular hypervisor in
> the guest kernel.

Yeah, it's not ideal.

> If we *can't* use msgsndp then the hypervisor better do something to
> stop us from using it.

POWER9 hypervisor has an hfscr and should clear that if it does not gang
threads like POWER8. The guest still needs to know not to use it though...

> If it would be preferable for us not to use msgsndp, then the hypervisor
> can tell us that somehow, eg. in the device tree.

I don't know that we have a really good way to do that other than guests
to clear the doorbell feature for POWER9.

Does the hypervisor set any relevant DT we can use today that says virtual
sibling != physical sibling? If not, then we'll just have to clear it from
all POWER9 guests until we get a DT proprety from phyp.

Thanks,
Nick
