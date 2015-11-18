Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2FFD1A0736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 10:01:25 +1100 (AEDT)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 241A5141466
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2015 10:01:25 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so58868361pac.3
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 15:01:23 -0800 (PST)
Date: Thu, 19 Nov 2015 10:01:13 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "mikey@neuling.org" <mikey@neuling.org>, "anton@samba.org"
 <anton@samba.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/8] FP/VEC/VSX switching optimisations
Message-ID: <20151119100113.79254289@camb691>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBD5633@AcuExch.aculab.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBD5633@AcuExch.aculab.com>
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

On Wed, 18 Nov 2015 14:51:25 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Cyril Bur
> > Sent: 18 November 2015 03:27  
> ...
> > The goal of these patches is to rework how the 'math' registers (FP, VEC
> > and VSX) are context switched. Currently the kernel adopts a lazy approach,
> > always switching userspace tasks with all three facilities disabled and
> > loads in each set of registers upon receiving each unavailable exception.
> > The kernel does try to avoid disabling the features in the syscall quick
> > path but it during testing it appears that even what should be a simple
> > syscall still causes the kernel to use some facilities (vectorised memcpy
> > for example) for its self and therefore disable it for the user task.  
> 

Hi David,

> Perhaps the kernel should be avoiding using these registers?
> I wonder if the gain from using vectorised memcpy is typically
> enough to warrant the cost of the save and restore?
> 

Yeah, on smaller copies that might be the way to go.

> There may even be scope for kernel code doing a save/restore
> of a small number of registers onto an in-stack save area.

This has been thrown up in the air, there's also the volatile/non-volatiles to
consider and the caveat that glibc doesn't quite respect the ABI here.

As it turns out (and no one is more surprised than me), despite the other
attempts at optimising, this series really has boiled down to removing the need
for processes to take the facility unavailable interrupts.

I do plan to carry on with optimising in this area and will have a look to see
what I can do.

Cyril

> It would need to be linked to the data of the thread
> that owns the fpu registers so that a save request could
> be honoured.
> Pre-emption would probably need to be disabled, but nested
> use, and use from ISR should be ok.
> 
> 	David
> 
