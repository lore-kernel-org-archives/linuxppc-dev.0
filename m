Return-Path: <brking@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C92031A05EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 09:58:16 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Tue, 27 Jan 2015 17:58:13 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3F41538C8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:58:11 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0RMwBhH23986348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 22:58:11 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0RMwAKl023074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:58:10 -0500
Message-ID: <54C81800.6070407@linux.vnet.ibm.com>
Date: Tue, 27 Jan 2015 16:58:08 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
 <1422093450.4949.89.camel@kernel.crashing.org>
 <54C6CF73.7000403@linux.vnet.ibm.com> <1422333116.4949.100.camel@au1.ibm.com>
In-Reply-To: <1422333116.4949.100.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, wenxiong@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2015 10:31 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2015-01-26 at 17:36 -0600, Brian King wrote:
>> To set some context, this function is only used by ipr for some old
>> broken adapters. These are adapters that are not supported on p8,
>> so will never show up under OPAL, only PowerVM. I'm fine with looking
>> at alternatives for the future, but I can't say I'm too excited about
>> changing the calling requirements for an API that has been around
>> for many years. Particularly given that this code is only needed for
>> these old adapters. If its difficult to implement this for OPAL without
>> noticeable delays, could we just return -EINVAL for this function on OPAL?,
>> since its not needed there today anyway.
> 
> Because it's needed for other things nowadays afaik, though IPR is the only one
> that needs this to be done at interrupt time...

I'd argue we are our own worst enemy here really. The new user is EEH code.
I don't see a huge reason that code would need to use this exact same API.

> In fact, even with IPR and the existing call, how do you wait for the link to come
> back for a PERST ? That can take a while...

Basically, I assert reset, delay for 1/2 second via a timer interrupt, deassert reset,
delay for 2 seconds via another timer interrupt, then proceed with adapter initialization.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
