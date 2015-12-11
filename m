Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F1AD1A0809
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 11:51:44 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 19:51:41 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F04806E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 19:39:48 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB0pd8e28639312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 00:51:39 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB0pdtR006019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 19:51:39 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: =?utf-8?B?6JKy5paH?= <wen.pu@powercore.com.cn>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/opal: add warning for unimplemented OPAL message
 type
In-Reply-To: <tencent_1097DF836527EECD6BF4E6AA@qq.com>
References: <tencent_1097DF836527EECD6BF4E6AA@qq.com>
Date: Fri, 11 Dec 2015 11:51:23 +1100
Message-ID: <8737v9byes.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E8=92=B2=E6=96=87 <wen.pu@powercore.com.cn> writes:
> On Wednesday, December 09, 2015 11:17:12 AM Michael Ellerman wrote:
>> On Tue, 2015-12-08 at 15:30 +0800, wen.pu@powercore.com.cn wrote:
>> > I found that there are unimplemented OPAL message types "OPAL_MSG_EPOW"
>> > and
>> > "OPAL_MSG_DPO" in PowerNV Platform. If skiboot send such messages to
>> > kernel, nothing will happen(notifier_call_chain() will silently drop i=
t).
>> > So I add a warning to inform what has happened, is it necessary?
>>=20
>> What kernel version are you using?
> The kernel version is v4.2.1-openpower2, from the newest version at=20
> https://github.com/open-power/linux.
>
>>=20
>> Looking at mainline (4.4-rc4), I do see handlers registered for EPOW and
>> DPO:
>>=20
>>=20=20
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arc=
h/p
>> owerpc/platforms/powernv/opal-power.c?#n82
>>=20
>> That code was merged in 4.3.
> I do find that EPOW and DPO are registered in kernel 4.3. So maybe in the=
 near=20
> future it will be merged into open-power/linux.

Way back in 24366360035a9e0a9870ed7208aa2ba1948f844d where the opal_msg
code was introduced there was a warning added for opal messages that
were unknown... arguably this is actually a bad thing to have these
days... I'll submit a patch to print it *once*.

>> In general I don't think we want to warn for unhandled message types,
>> because we support old kernels running on new skiboot. In that case if we
>> warned on every unhandled message we'd potentially spam the console with
>> warnings.
>>=20
>> But perhaps we can come up with something smarter, that only warns once =
for
>> each unhandled message type, or something like that? Did you have a bug =
that
>> would have been easier to debug with a warning here?
> Yes, I think it is a good idea that only warns once, or warns every a few=
=20
> seconds.=20
> I found that EPOW and DPO only used in IBM FSP platform, not in Habanero=
=20
> platform that I had. So I modified the skiboot code and sent a EPOW/DPO m=
essage=20
> to kernel, and found that kernel warn nothing. I have no bug with a warni=
ng=20
> here, and just get a log message via dmesg.

Currently only FSP platform, yes. No real reason why a BMC based
platform couldn't emit those though.
