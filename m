Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMJRN4KjDzDqgY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 00:21:52 +1000 (AEST)
Received: by mail-qk0-f196.google.com with SMTP id m84so1649231qki.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 07:21:52 -0700 (PDT)
Date: Tue, 1 Aug 2017 11:21:46 -0300
From: Breno Leitao <leitao@debian.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/xmon: Disable and enable tracing command
Message-ID: <20170801142145.ill2cpq5grybflwp@gmail.com>
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
 <1501521731-12123-2-git-send-email-leitao@debian.org>
 <20170801064024.colxo4i3z764m36k@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170801064024.colxo4i3z764m36k@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

On Tue, Aug 01, 2017 at 12:10:24PM +0530, Naveen N. Rao wrote:
> On 2017/07/31 02:22PM, Breno Leitao wrote:
> > If tracing is enabled and you get into xmon, the tracing buffer
> > continues to be updated, causing possible loss of data due to buffer
> > overflow and unnecessary tracing information coming from xmon functions.
> > 
> > This patch adds a new option that allows the tracing to be disabled and
> > re-enabled from inside xmon.
> 
> How is this new option useful? In the next patch, you disable tracing by 
> default -- in what scenario do you expect to have to re-enable tracing 
> from within xmon?

I see it being useful on two different scenarios:

1) You can reenable tracing if you want to call a function from xmon
(with 'p'), or even for code stepping (with 's').

2) You may also want to reenable tracing once you resume from xmon with
'zr'.

> > +		case 'v':
> > +			if (tracing_is_on()) {
> > +				printk("Disabling tracing\n");
> > +				tracing_enabled = 0;
> > +				tracing_off();
> 
> This only disables trace buffer updates - ftrace (and all its callbacks, 
> et al) remains active, which isn't desirable.

Why isn't it desirable? In fact, I thought it would be *the* desirable
function to call, since it does not do a lot of stuff, as disabling
tracing, in xmon mode, but, just disable the tracing buffer to be updated.

Since we are in xmon, we are in a very bad state, and something went
very wrong. Disabling the whole tracing might not be what we want to do
in this scenario, since it can hit the broken subsystem causing xmon to
fail.

For bad state scenario, I understand that it is desirable to be less
instrusive as possible, and tracing_off() does exactly it.

> Can you see if this works for you:
> https://patchwork.ozlabs.org/patch/769611/

Well, I understand that this patch solves a different issue, this does
not reduce the tracing caused by function tracer after you got into into
xmon.

As for example, with your patch applied, I can see a lot of xmon
functions polluting the tracing buffer as:

	1:mon> dt
	[  359.196593] Dumping ftrace buffer:
	[  359.196689] ---------------------------------
	[  359.196904]   1)               |          xmon_printf() {
	<110+ lines snipped>
	[  359.197727]   1) + 22.930 us   |          }
	[  359.199405]   1)               |          skipbl() {
	<50+ lines snipped>
	[  359.225069]   1) + 23.750 us   |          }


Since tracing continues to be enabled during xmon, these messages
continue to show up. That is exactly what I am trying to avoid with this
current patchset. Avoiding all xmon-related tracing is my main goal.

Thanks for your review,
Breno
