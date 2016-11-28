Return-Path: <nickc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5q21fhxzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:39:42 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/boot: request no dynamic linker for boot wrapper
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20161128014226.7656-1-npiggin@gmail.com>
 <87shqbrhfo.fsf@concordia.ellerman.id.au>
 <20161128230724.375227b4@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Alan Modra <amodra@gmail.com>
From: Nick Clifton <nickc@redhat.com>
Message-ID: <a3674ff0-2c57-b04e-6cdf-3ac43296f854@redhat.com>
Date: Mon, 28 Nov 2016 12:39:38 +0000
MIME-Version: 1.0
In-Reply-To: <20161128230724.375227b4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

>>> The boot wrapper performs its own relocations and does not require
>>> PT_INTERP segment.
>>>
>>> Without this option, binutils 2.28 and newer tries to create a program
>>> header segment due to PT_INTERP, and the link fails because there is no
>>> space for it.  
>>
>> 2.28 is not released yet though is it?
>>
>> So can we just declare versions with that behaviour broken?
> 
> No it's not released yet, but I don't know if it's due entirely to binutils
> bug. Let's see what Nick thinks.

Well the patch that caused this problem was an attempt to fix the linker so 
that it would enforce the ELF standard.  Prior to the patch the linker would 
silently create binaries that violated the standard and which, at least for
the people reporting the problem in binutils PR 20815, failed to execute.

It now appears however that some programs, including the boot wrapper and the
Linux kernel, may actually rely upon non-standard ELF binaries being created.
Before I revert the patch however, I would like to ask...

>>> +# Do not include PT_INTERP segment when linking pie. Non-pie linking
>>> +# just ignores this option.
>>> +LD_VERSION=$(${CROSS}ld --version | $srctree/scripts/ld-version.sh)
>>> +LD_NO_DL_MIN_VERSION=$(echo 2.26 | $srctree/scripts/ld-version.sh)
>>> +if [ "$LD_VERSION" -ge "$LD_NO_DL_MIN_VERSION" ] ; then
>>> +	nodl="--no-dynamic-linker"
>>> +fi  

... this actually seems like a better fix to me.  If you do not want the 
PT_INTERP segment, then telling this linker this is a good idea.  So wouldn't
a patch like this be a better solution to the problem ?

Cheers
  Nick
