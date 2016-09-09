Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVvDn4SPpzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 20:52:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
In-Reply-To: <871t1dr716.fsf@possimpible.ozlabs.ibm.com>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
 <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
 <20160824073826.GA16442@simonLocalRHEL7.x64>
 <871t1dr716.fsf@possimpible.ozlabs.ibm.com>
Date: Fri, 09 Sep 2016 20:52:52 +1000
Message-ID: <871t0tl4zf.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> [ Unknown signature status ]
> Simon Guo <wei.guo.simon@gmail.com> writes:
>
>> I think keeping tm_active argument for "ifndef CONFIG_PPC_TRANSACTIONAL_MEM" 
>> case (with __maybe_unused prefix) will be somehow strange -- Whatever
>> value is provided in the caller function for tm_active, programmer might be 
>> puzzled and cost sometime to think about it.  I don't like to use 
>> "__maybe_unused" to bypass this warning.
>
> Fair enough. I don't have strong feelings either way - we'll see if the
> maintainers have any thoughts.

I do - Sorry Simon but your patch just adds too many #ifdefs.

Any time you have to do something like:

	+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
		}
	+#endif

It should be a sign that something has gone wrong :)

Does Cyril's series to rework the TM structures help at all with this
warning?

cheers
