Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D28261A071E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 15:32:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 27 Jan 2015 14:32:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C9B2357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 15:32:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0R4W3hK48300230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 15:32:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0R4W1eq030772
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 15:32:01 +1100
Message-ID: <1422333116.4949.100.camel@au1.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 27 Jan 2015 05:31:56 +0100
In-Reply-To: <54C6CF73.7000403@linux.vnet.ibm.com>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1421746096.4949.40.camel@kernel.crashing.org>
 <20150120225607.GA12174@shangw> <20150120235338.GA5280@shangw>
 <20150123035029.GA19657@shangw>
 <1422093450.4949.89.camel@kernel.crashing.org>
 <54C6CF73.7000403@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: wenxiong@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-26 at 17:36 -0600, Brian King wrote:
> To set some context, this function is only used by ipr for some old
> broken adapters. These are adapters that are not supported on p8,
> so will never show up under OPAL, only PowerVM. I'm fine with looking
> at alternatives for the future, but I can't say I'm too excited about
> changing the calling requirements for an API that has been around
> for many years. Particularly given that this code is only needed for
> these old adapters. If its difficult to implement this for OPAL without
> noticeable delays, could we just return -EINVAL for this function on OPAL?,
> since its not needed there today anyway.

Because it's needed for other things nowadays afaik, though IPR is the only one
that needs this to be done at interrupt time...

In fact, even with IPR and the existing call, how do you wait for the link to come
back for a PERST ? That can take a while...

Ben.
