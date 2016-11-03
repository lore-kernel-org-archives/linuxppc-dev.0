Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8XjB2ynrzDvHY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 15:55:42 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id n85so24536064pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 21:55:42 -0700 (PDT)
Date: Thu, 3 Nov 2016 15:55:31 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
Message-ID: <20161103155531.4e86d906@roar.ozlabs.ibm.com>
In-Reply-To: <CAOJe8K3eA38JfBDSsT0MHqm9az0awp_veU4=+_KKkPww=wtutg@mail.gmail.com>
References: <CAOJe8K3eA38JfBDSsT0MHqm9az0awp_veU4=+_KKkPww=wtutg@mail.gmail.com>
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

On Wed, 2 Nov 2016 13:49:39 +0300
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> Hi guys,
> 
> compiling ppc head with bunch of asm errors on power8 box (gcc version 4.8.3 )
> checked commit log but found nothing special. Looks like it's asm issue?
> Has anybody seen that?
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:421: Error: operand out of range
> (0xffffffffffff8680 is not between 0x0000000000000000 and
> 0x000000000000ffff)

Hey, thanks for the report. It's likely due to the exception vectors rewrite,
and yes it's an assembler issue (what's your binutils version?). Your errors
look like they're coming from LOAD_HANDLER(). For some reason it seems to be
interpreting the immediate as signed, or the actual calculation ends up being
negative, neither of which should happen.

It might take a bit of trial and error, and the assembler doesn't give a lot
of good options to debug it, so if I can reproduce it here with your bintuils
version it will be helpful.

Thanks,
Nick
