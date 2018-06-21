Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B7c92Wn0zF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 14:13:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 fweimer@redhat.com, luto@kernel.org, msuchanek@suse.de
Subject: Re: [PATCH v2 2/6] powerpc/pkeys: Save the pkey registers before fork
In-Reply-To: <20180619142811.GD5294@ram.oc3035372033.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-3-git-send-email-linuxram@us.ibm.com>
 <877emvx84j.fsf@concordia.ellerman.id.au>
 <20180619142811.GD5294@ram.oc3035372033.ibm.com>
Date: Thu, 21 Jun 2018 14:13:40 +1000
Message-ID: <87a7rowzd7.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> On Tue, Jun 19, 2018 at 10:39:56PM +1000, Michael Ellerman wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> 
>> > When a thread forks the contents of AMR, IAMR, UAMOR registers in the
>> > newly forked thread are not inherited.
>> >
>> > Save the registers before forking, for content of those
>> > registers to be automatically copied into the new thread.
>> >
>> > CC: Michael Ellerman <mpe@ellerman.id.au>
>> > CC: Florian Weimer <fweimer@redhat.com>
>> > CC: Andy Lutomirski <luto@kernel.org>
>> > CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> 
>> Again this is an ABI change but we'll call it a bug fix I guess.
>
> yes. the same defense here too. its a behaviorial change for the better.
> Single threaded applications will not see any behaviorial change.
> Multithreaded apps, which were unable to consume, the behavior will now be
> able to do so.

Well threads is one thing, but this also affects processes.

And actually without this fix it's possible that a child process could
fault on a region protected in the parent, if the value in the AMR in
the thread struct happens to block access at the time of fork(). The
value in the thread struct would be whatever was in the AMR the last
time the parent was scheduled in. I think?

cheers
