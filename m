Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0422C1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 20:07:32 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Kconfig.cputype: Disallow TUNE_CELL on LE systems
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1442585820-18623-1-git-send-email-thuth@redhat.com>
 <1442819926.354.5.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, boqun.feng@gmail.com
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55FFD6DF.2080300@redhat.com>
Date: Mon, 21 Sep 2015 12:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <1442819926.354.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/09/15 09:18, Michael Ellerman wrote:
> On Fri, 2015-09-18 at 16:17 +0200, Thomas Huth wrote:
>> It looks somewhat weird that you can enable TUNE_CELL on little
>> endian systems, so let's disable this option with CPU_LITTLE_ENDIAN.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  I first thought that it might be better to make this option depend
>>  on PPC_CELL instead ... but I guess it's a bad idea to depend a
>>  CPU option on a platform option? Alternatively, would it make
>>  sense to make it depend on (GENERIC_CPU || CELL_CPU) instead?
> 
> Hmm, it's a little backward, but I think it would be fine, and less confusing
> for users. Both PS3 and Cell select PPC_CELL, so it would work in both those
> cases.

It's just that when you step through the kernel config (e.g. with "make
menuconfig"), you normally step through the "Processor support" first,
and then later do the "Platform support". I think most users won't look
back into "Processor support" again once they already reached the
"Platform support" section, so this TUNE_CELL option then might appear
unnoticed when you enable a Cell platform under "Platform support".

That's why thought that CPU_LITTLE_ENDIAN or (GENERIC_CPU || CELL_CPU)
might be the better option here... but if you think PPC_CELL is the
better way to go, I'm also fine to change my patch to use this instead
(in the end, TUNE_CELL is likely hardly used anymore nowadays, so it
should not be that bad if it does not appear "immediately" to the user).

 Thomas
