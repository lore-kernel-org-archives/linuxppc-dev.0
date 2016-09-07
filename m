Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTWfx6lXbzDrpx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 15:07:21 +1000 (AEST)
Date: Wed, 7 Sep 2016 11:23:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
Message-ID: <20160907012356.GA21443@fergus.ozlabs.ibm.com>
References: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 11:01:02PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Paul!
> 
> I'm referring to your change [1]:
> 
> "powerpc/xmon: Fix SPR read/write commands and add command to dump SPRs"
> 
> which introduced assembly code in the new file arch/powerpc/xmon/spr_access.S.
> 
> Unfortunately, this code contains assembly instructions which are not available on
> all ppc targets. In particular, this change breaks the build on PPC e500v2 targets,
> see the corresponding Debian bug report [2].
> 
> Could you have a look and possibly add some guarding #ifdefs for the ppc targets
> where "ld" is not a supported instruction?

I blame Michael. :)  My original version of the patch didn't have the
ld instructions, and then Michael did a v2 that was different.  He
didn't update the patch description so I don't know exactly why he
changed that.  I'll discuss it with him.

Paul.
