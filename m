Return-Path: <amodra@gmail.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 7A733B6ED0
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 11:23:02 +1000 (EST)
Received: by ywh34 with SMTP id 34so7841322ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 18:23:00 -0700 (PDT)
Date: Thu, 29 Apr 2010 10:52:52 +0930
From: Alan Modra <amodra@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerPC ftrace function trace optimisation
Message-ID: <20100429012252.GC3510@bubble.grove.modra.org>
References: <20100429005117.GA4622@kryten> <1272502967.24542.137.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272502967.24542.137.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Anton Blanchard <anton@samba.org>, rostedt@goodmis.org, imunsie@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 29, 2010 at 11:02:47AM +1000, Benjamin Herrenschmidt wrote:
> From a quick test it appears that this only works with -m64, not -m32.
> Alan is that correct ?

Yes.

> Any chance you can fix that in future gcc versions ?

No need really.  32-bit _mcount calls happen before the prologue
anyway.

> > In fact if we are careful when switching to the new mcount ABI and don't
> > rely on the store of r0, we could probably optimise this even further in a
> > future gcc and remove the store completely. mcount would be 2 instructions:
> > 
> >    mflr    r0              
> >    bl      8 <.foo+0x8>

Yeah.  Also, I should have used a different name for this mcount from
the standard 64-bit mcount.

-- 
Alan Modra
Australia Development Lab, IBM
