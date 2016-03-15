Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPH652DqzzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 12:27:09 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qPH6462ptz9ssP
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2016 12:27:08 +1100 (AEDT)
Date: Tue, 15 Mar 2016 02:27:02 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
In-Reply-To: <3qNsms00H7z9snl@ozlabs.org>
Message-ID: <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
References: <3qNsms00H7z9snl@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Mar 2016, Michael Ellerman wrote:

> > Move the logic to work out the kernel toc pointer into a header. This is
> > a good cleanup, and also means we can use it elsewhere in future.
> > 
> > Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > Reviewed-by: Torsten Duwe <duwe@suse.de>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> 
> Series applied to powerpc next.
> 
> https://git.kernel.org/powerpc/c/a5cab83cd3d2d75d3893276cb5

Thanks Michael; this is an excellent basis for ppc live patching, but FYI 
I am not merging that one to my tree just yet.

The solution (*) for functions with non-trivial argument list is not there 
yet, and it's my requirement for this to be taken care of in a way that's 
not prone to easily-done human errors on the patch-producer side.

(*) both "making it work" or "making it so broken that it's guaranteed 
    that noone would ever produce a patch that brings the kernel down" is 
    okay, but I really don't feel that just documenting the limitation is
    sufficient and safe in this case; kudos to Torsten here for
    idenfitfying the problem before it actually became The Problem

Thanks,

-- 
Jiri Kosina
SUSE Labs
