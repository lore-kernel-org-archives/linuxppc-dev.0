Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x22c.google.com (mail-pl0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gvrF5WzRzF2N5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 21:53:17 +1000 (AEST)
Received: by mail-pl0-x22c.google.com with SMTP id c19-v6so1352210pls.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 04:53:17 -0700 (PDT)
Date: Wed, 9 May 2018 21:53:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s/radix: reset mm_cpumask for single thread
 process when possible
Message-ID: <20180509215303.53bda3ef@roar.ozlabs.ibm.com>
In-Reply-To: <0c3d18301bc3eb86da197ecefb22aec5c6f70a57.camel@au1.ibm.com>
References: <20180509065613.14762-1-npiggin@gmail.com>
 <0c3d18301bc3eb86da197ecefb22aec5c6f70a57.camel@au1.ibm.com>
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

On Wed, 09 May 2018 18:31:55 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Wed, 2018-05-09 at 16:56 +1000, Nicholas Piggin wrote:
> > When a single-threaded process has a non-local mm_cpumask and requires
> > a full PID tlbie invalidation, use that as an opportunity to reset the
> > cpumask back to the current CPU we're running on.
> > 
> > No other thread can concurrently switch to this mm, because it must
> > have had a reference on mm_users before it could use_mm. mm_users can
> > be asynchronously incremented e.g., by mmget_not_zero, but those users
> > must not be doing use_mm.  
> 
> What do you mean ? I don't fully understand how this isn't racy with
> another thread being created, switching to that mm, and then having its
> bit cleared by us ?

We are the single thread, so nothing else can call clone on our mm.

> Also why not use_mm ? what prevents it ?

I'm not sure if it has an assertion (it probably should), but existing
convention. Such things would be broken there are already other
architectures doing similar things with TLB flushing for example, alpha,
ia64, mips, sh... sparc does something very similar resetting its cpumask
by the look.

I grepped mmget_not_zero callers too, couldn't see any obvious use_mm
cases.

Thanks,
Nick
