Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMwwd3bwtzDsTD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 00:45:53 +1000 (AEST)
Received: by mail-qt0-f193.google.com with SMTP id t37so4762394qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 07:45:53 -0700 (PDT)
Date: Wed, 2 Aug 2017 11:45:47 -0300
From: Breno Leitao <leitao@debian.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/xmon: Disable and enable tracing command
Message-ID: <20170802144546.pxmahau6tksw4u4e@gmail.com>
References: <1501521731-12123-1-git-send-email-leitao@debian.org>
 <1501521731-12123-2-git-send-email-leitao@debian.org>
 <20170801064024.colxo4i3z764m36k@naverao1-tp.localdomain>
 <20170801142145.ill2cpq5grybflwp@gmail.com>
 <20170802132124.4ik7govvogeud7pp@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802132124.4ik7govvogeud7pp@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2017 at 06:51:24PM +0530, Naveen N. Rao wrote:
> On 2017/08/01 11:21AM, Breno Leitao wrote:
> > Hi Naveen,
> > 
> > On Tue, Aug 01, 2017 at 12:10:24PM +0530, Naveen N. Rao wrote:
> > > On 2017/07/31 02:22PM, Breno Leitao wrote:
> > > > If tracing is enabled and you get into xmon, the tracing buffer
> > > > continues to be updated, causing possible loss of data due to buffer
> > > > overflow and unnecessary tracing information coming from xmon functions.
> > > > 
> > > > This patch adds a new option that allows the tracing to be disabled and
> > > > re-enabled from inside xmon.
> > > 
> > > How is this new option useful? In the next patch, you disable tracing by 
> > > default -- in what scenario do you expect to have to re-enable tracing 
> > > from within xmon?
> > 
> > I see it being useful on two different scenarios:
> > 
> > 1) You can reenable tracing if you want to call a function from xmon
> > (with 'p'), or even for code stepping (with 's').
> 
> Hmm... those are just debugging aids, so I don't see why enabling the 
> function tracer helps, unless you're debugging the tracer itself..
> 
> > 
> > 2) You may also want to reenable tracing once you resume from xmon with
> > 'zr'.
> 
> 'zr' is for reboot, so not sure what you meant there...

I meant 'x' in fact, which means 'exit monitor and recover'. This will
resume the kernel after getting into xmon.

> If tracing was enabled before we went into xmon, I think that we should 
> just restore it by default.

Makes sense. So, I will get ride of this 'v' feature and disable tracing
when entering the xmon, and reenabling it on recovering. That way, we
will avoid xmon functions showing up on the tracing buffer.

I will send a new patchset soon!

Thanks,
Breno
