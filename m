Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDkYb17gvzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:34:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/xive: Fix/improve verbose debug output
In-Reply-To: <1493356805.25766.296.camel@kernel.crashing.org>
References: <1493301446.25766.276.camel@kernel.crashing.org>
 <87zif1p6vw.fsf@concordia.ellerman.id.au>
 <1493356805.25766.296.camel@kernel.crashing.org>
Date: Fri, 28 Apr 2017 16:34:10 +1000
Message-ID: <874lx99h25.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2017-04-28 at 13:07 +1000, Michael Ellerman wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> 
>> > The existing verbose debug code doesn't build when enabled.
>> 
>> So why don't we convert all the DBG_VERBOSE() to pr_devel()? 
>
> pr_devel provides a bunch of debug at init/setup/mask/unmask etc... but
> the system is still usable

OK so those could be converted to pr_debug().

> DBG_VERBOSE starts spewing stuff on every interrupt and eoi, the system
> is no longer usable.

And those could stay at pr_devel(), requiring a #define DEBUG and
recompile to enable.

>> If there's non-verbose debug that we think would be useful to
>> differentiate from verbose then those could be pr_debug() - which means
>> they'll be jump labelled off in most production kernels, but still able
>> to be enabled.
>
> Maybe... I don't like the giant "debug" switch accross the whole
> kernel, though.

Not sure what you mean. You can enable pr_debug()s individually, by
function, by module, by file, or for the whole kernel.

To enable everything in xive you'd do:

# echo 'file *xive* +p' > /sys/kernel/debug/dynamic_debug/control

Or boot with: loglevel=8 dyndbg="file *xive* +p"

cheers
