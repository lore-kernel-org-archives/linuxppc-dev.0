Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x22f.google.com (mail-pl0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g4tH2bLdzF1mS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 13:37:10 +1000 (AEST)
Received: by mail-pl0-x22f.google.com with SMTP id u6-v6so1365720pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 20:37:10 -0700 (PDT)
Date: Tue, 8 May 2018 13:36:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
Message-ID: <20180508133656.5ad92847@roar.ozlabs.ibm.com>
In-Reply-To: <87zi1bbvnl.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-9-npiggin@gmail.com>
 <1525168138.2325.100.camel@kernel.crashing.org>
 <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
 <87zi1bbvnl.fsf@concordia.ellerman.id.au>
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

On Mon, 07 May 2018 20:35:42 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Tue, 01 May 2018 19:48:58 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >  
> >> On Tue, 2018-05-01 at 00:55 +1000, Nicholas Piggin wrote:  
> >> > The RAW console does not need writes to be atomic, so relax
> >> > opal_put_chars to be able to do partial writes, and implement an
> >> > _atomic variant which does not take a spinlock. This API is used
> >> > in xmon, so the less locking that is used, the better chance there
> >> > is that a crash can be debugged.    
> >> 
> >> Same comment I already had :-) "atomic" in Linux tends to mean
> >> something else (ie, atomic context), so I'd rather have something
> >> like opal_put_chars_sync() or such...  
> >
> > Oh yeah, I didn't ignore you, just... I thought atomic was okay.
> > atomic *also* tends to mean happens atomically. I think the in
> > atomic context meaning actually tends to be inatomic.
> >
> > Sync I actually thought could be more easily confused with
> > synchronous vs asynchronous here.  
> 
> I think we probably want opal_put_chars() to stay as it is.
> 
> And then add a variant for the call (just xmon?) that want lock free
> behaviour.

No it's not the lock which is important here, it is whether the
message goes to the console atomically versus other writes. The
raw console does not require this, only one which sends some
control characters, which is the hvterm-protocol compatible variant
of the vio console, and I think FSP console.

BMC consoles for example always use raw.

> opal_put_chars_unlocked() or something?

I prefer the _atomic as the special case. Ordinarily we don't have
a special requirement, but with the control characters then we do.

Thanks,
Nick
