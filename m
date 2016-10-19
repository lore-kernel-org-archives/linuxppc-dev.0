Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szYV16pqVzDt4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 00:59:53 +1100 (AEDT)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3szYV12MYTz9t0w
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2016 00:59:53 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 128so2593612pfz.1
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2016 06:59:53 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] powerpc/pseries: Define & use a type for the
 plpar_hcall() retvals
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
 <1476780032-21643-2-git-send-email-mpe@ellerman.id.au>
 <b922cd6c-a44d-6950-93d7-6645fd1f7fac@gmail.com>
 <87lgxk4l2p.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <360be313-c3ad-495c-82e1-13a8364dc76d@gmail.com>
Date: Thu, 20 Oct 2016 00:59:56 +1100
MIME-Version: 1.0
In-Reply-To: <87lgxk4l2p.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/10/16 22:47, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On 18/10/16 19:40, Michael Ellerman wrote:
>>> We have now had two nasty stack corruption bugs caused by incorrect
>>> sizing of the return buffer for plpar_hcall()/plpar_hcall9().
>>>
>>> To avoid any more such bugs, define a type which encodes the size of the
>>> return buffer, and change the argument of plpar_hcall() to be of that
>>> type, meaning the compiler will check for us that we passed the right
>>> size buffer.
>>>
>>> There isn't an easy way to do this incrementally, without introducing a
>>> new function name, eg. plpar_hcall_with_struct(), which is ugly as hell.
>>> So just do it in one tree-wide change.
>>>
>> Conceptually looks god, but I think we need to abstract the return values
>> as well. I'll test and see if I can send you something on top of this
> 
> Not sure I know what you mean.

Here is an example

-	*slot = retbuf[0];
+	*slot = retvals.v[0];

Could we hide retvals.v[0] under a macro like 

*slot = hcalls_ret_val(retvals, 0);

Since we could end up with similar issues if
someone dereferenced retvals.v[4]

Since we are abstracting under retvals, I was wondering
if we want to further abstract the return values
as well and make retvals opaque to the user


Balbir Singh.
