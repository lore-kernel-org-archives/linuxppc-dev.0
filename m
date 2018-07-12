Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R7bY0HSKzF35P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:58:16 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id c41-v6so10341698plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 00:58:16 -0700 (PDT)
Date: Thu, 12 Jul 2018 17:58:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org,
 linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org, paulus@samba.org,
 Bjoern Noetel <bjoern@br3ak3r.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Replaced msleep(x) with
 msleep(OPAL_BUSY_DELAY_MS)
Message-ID: <20180712175805.263898e2@roar.ozlabs.ibm.com>
In-Reply-To: <87bmbd80rl.fsf@concordia.ellerman.id.au>
References: <878t6hami4.fsf@concordia.ellerman.id.au>
 <1531346584-9157-1-git-send-email-eleon@ele0n.de>
 <87bmbd80rl.fsf@concordia.ellerman.id.au>
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

On Thu, 12 Jul 2018 15:46:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Daniel Klamt <eleon@ele0n.de> writes:
> 
> > Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
> > to diocument these sleep is to wait for opal.
> >
> > Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> > Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>  
> 
> Thanks.
> 
> Your change log should be in the imperative mood, see:
> 
>   https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches?id=HEAD#n133
> 
> 
> In this case that just means saying "Replace" rather than "Replaced".
> 
> Also the prefix should be "powerpc/xive". You can guess that by doing:
> 
>   $ git log --oneline arch/powerpc/sysdev/xive/native.c
> 
> And notice that the majority of commits use that prefix.
> 
> 
> I've fixed both of those things up for you.

Sorry, just noticed this. I've got a patch which changes the xive stuff
to the "standard" format this will clash with.

               if (rc == OPAL_BUSY_EVENT) {
                       msleep(OPAL_BUSY_DELAY_MS);
                       opal_poll_events(NULL);
               } else if (rc == OPAL_BUSY) {
                       msleep(OPAL_BUSY_DELAY_MS);
               }

If it's already merged that's fine, I can rebase.

Thanks,
Nick
