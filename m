Return-Path: <pc@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A54A1A017A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 04:00:02 +1100 (AEDT)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 666DE1400D2
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 04:00:00 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Thu, 13 Nov 2014 09:59:58 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6523619D8026
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 09:48:36 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sADGxs4w45088986
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 17:59:55 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sADGxqXm025564
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 09:59:53 -0700
Message-ID: <5464E388.6060507@us.ibm.com>
Date: Thu, 13 Nov 2014 10:59:52 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Support OPAL requested heartbeat
References: <1415772194.5124.37.camel@kernel.crashing.org>
In-Reply-To: <1415772194.5124.37.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/12/2014 12:03 AM, Benjamin Herrenschmidt wrote:
> If OPAL requests it, call it back via opal_poll_events() at a
> regular interval. Some versions of OPAL on some machines require
> this to operate some internal timeouts properly.

I don't see any reason why not, but wanted to ask to make sure: this 
daemon can be bound to a core, correct?  At least manually by taskset or 
similar?

It sounds a lot like the RTAS thread, which I was happy to see go away 
when running directly on OPAL, and don't want something else to take its 
place.  It was not bindable, but ran periodically on EVERY core, err 
hardware thread.

(Just looking to avoid latency blips.)

PC
