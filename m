Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A25921A022F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 16:41:05 +1000 (AEST)
Received: by wicja10 with SMTP id ja10so7656533wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 23:41:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 21 Aug 2015 08:40:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150821064059.GA2934@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
 <20150821062826.GA566@gmail.com>
 <20150821063458.GC12451@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150821063458.GC12451@pek-khao-d1.corp.ad.wrs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kevin Hao <haokexin@gmail.com> wrote:

> On Fri, Aug 21, 2015 at 08:28:26AM +0200, Ingo Molnar wrote:
> > 
> > * Kevin Hao <haokexin@gmail.com> wrote:
> > 
> > > These are used to define a static_key_{true,false} array.
> > > 
> > > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > > ---
> > >  include/linux/jump_label.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> > > index 7f653e8f6690..5c1d6a49dd6b 100644
> > > --- a/include/linux/jump_label.h
> > > +++ b/include/linux/jump_label.h
> > > @@ -267,6 +267,12 @@ struct static_key_false {
> > >  #define DEFINE_STATIC_KEY_FALSE(name)	\
> > >  	struct static_key_false name = STATIC_KEY_FALSE_INIT
> > >  
> > > +#define DEFINE_STATIC_KEY_TRUE_ARRAY(name, n)	\
> > > +	struct static_key_true name[n] = { [0 ... n - 1] = STATIC_KEY_TRUE_INIT }
> > > +
> > > +#define DEFINE_STATIC_KEY_FALSE_ARRAY(name, n)	\
> > > +	struct static_key_false name[n] = { [0 ... n - 1] = STATIC_KEY_FALSE_INIT }
> > 
> > I think the define makes the code more obfuscated and less clear, the open-coded 
> > initialization is pretty dense and easy to read to begin with.
> 
> OK, I will drop this patch and move the initialization of the array to the 
> corresponding patch.

Please also Cc: peterz and me to the next submission of the series - static key 
(and jump label) changes go through the locking tree normally, and there's a 
number of changes pending already for v4.3:

20f9ed1568c0 locking/static_keys: Make verify_keys() static
412758cb2670 jump label, locking/static_keys: Update docs
2bf9e0ab08c6 locking/static_keys: Provide a selftest
ed79e946732e s390/uaccess, locking/static_keys: employ static_branch_likely()
3bbfafb77a06 x86, tsc, locking/static_keys: Employ static_branch_likely()
1987c947d905 locking/static_keys: Add selftest
11276d5306b8 locking/static_keys: Add a new static_key interface
706249c222f6 locking/static_keys: Rework update logic
e33886b38cc8 locking/static_keys: Add static_key_{en,dis}able() helpers
7dcfd915bae5 jump_label: Add jump_entry_key() helper
a1efb01feca5 jump_label, locking/static_keys: Rename JUMP_LABEL_TYPE_* and related helpers to the static_key* pattern

Thanks,

	Ingo
