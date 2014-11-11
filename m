Return-Path: <tcminyard@gmail.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 696C21A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:07:29 +1100 (AEDT)
Received: by mail-oi0-f48.google.com with SMTP id x69so7619718oia.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 13:07:27 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Message-ID: <54627A8C.20400@acm.org>
Date: Tue, 11 Nov 2014 15:07:24 -0600
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Jeremy Kerr <jk@ozlabs.org>,
 openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
References: <1415245107.292153.444216242273.0.gpush@pablo>
 <545B826F.7050501@acm.org> <5460307C.9060502@ozlabs.org>
In-Reply-To: <5460307C.9060502@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/09/2014 09:26 PM, Jeremy Kerr wrote:
> Hi Corey,
>
> Thanks for the review.
>
>>> IPMI folks: the IPMI driver could do with a little review, as it's
>>> not a conventional BT/KCS/SMI SI, in that the low-level send/recv
>>> interface will handle the entire message at once.
>> Handling the entire message at once should be fine, as that's what
>> this driver level is designed to do for the message handler.  That
>> part all looks correct.  The code itself looks good, but I have a
>> couple of high-level comments.
>>
>> The driver at this level can receive more than one message to handle
>> at a time, so it needs some sort of queue.  This is to allow multiple
>> users and to allow the message handler to send its own commands while
>> other commands are going on.  You might argue that the queuing should
>> be done in ipmi_msghandler, and you would probably be right.
> Ah, that's what I'd been assuming was being done - I missed the
> xmit_list in the si_intf code. It'd be great if this could be in the
> generic msghandler code, otherwise I'd just be duplicating the si_intf
> logic.
>
>> I'll look at doing that.  If that is the case, then your NULL check
>> for current message should probably be a BUG_ON().
> OK, I'll update this when the msghandler bit is implemented.

I've finally finished that, you can get it at:

git://git.code.sf.net/p/openipmi/linux-ipmi

using the for-next branch.  This is what goes into linux-next.

>> Do you need to handle any BMC flags?  Particularly incoming events?
> Not at this stage - we may in future though.

Ok.  That will complicate things a bit when they are added, but not very
much.

Thanks,

-corey
