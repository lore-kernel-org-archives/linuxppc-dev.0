Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQT3H4VTLzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 10:58:51 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQT3H0XC7z9t0t
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2016 10:58:51 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id x3so94321662pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 16:58:50 -0700 (PDT)
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
To: Jiri Kosina <jikos@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <3qNsms00H7z9snl@ozlabs.org>
 <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56E9F332.1070206@gmail.com>
Date: Thu, 17 Mar 2016 10:58:42 +1100
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/03/16 12:27, Jiri Kosina wrote:
> On Mon, 14 Mar 2016, Michael Ellerman wrote:
>
>>> Move the logic to work out the kernel toc pointer into a header. This is
>>> a good cleanup, and also means we can use it elsewhere in future.
>>>
>>> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
>>> Reviewed-by: Torsten Duwe <duwe@suse.de>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
>> Series applied to powerpc next.
>>
>> https://git.kernel.org/powerpc/c/a5cab83cd3d2d75d3893276cb5
> Thanks Michael; this is an excellent basis for ppc live patching, but FYI 
> I am not merging that one to my tree just yet.
>
> The solution (*) for functions with non-trivial argument list is not there 
> yet, and it's my requirement for this to be taken care of in a way that's 
> not prone to easily-done human errors on the patch-producer side.
>
> (*) both "making it work" or "making it so broken that it's guaranteed 
>     that noone would ever produce a patch that brings the kernel down" is 
>     okay, but I really don't feel that just documenting the limitation is
>     sufficient and safe in this case; kudos to Torsten here for
>     idenfitfying the problem before it actually became The Problem
To be honest I think my v6 works well, but I don't have complete confidence due to the lack of proper testing. livepatch samples plus some others I wrote and I one Petr wrote all work (calling patched from within patched), but we need more confidence with good tests or an alternative approach that is easier to review and be satisfied with
>
> Thanks,
>
