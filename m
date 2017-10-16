Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFg765SBgzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 12:03:30 +1100 (AEDT)
Received: by mail-pg0-x236.google.com with SMTP id v78so5477692pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 18:03:30 -0700 (PDT)
Date: Mon, 16 Oct 2017 12:03:20 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/strict_rwx: fixup region splitting
Message-ID: <20171016120320.0527c15a@firefly.ozlabs.ibm.com>
In-Reply-To: <87o9pnp3li.fsf@concordia.ellerman.id.au>
References: <20170927095111.10626-1-bsingharora@gmail.com>
 <20170927095111.10626-2-bsingharora@gmail.com>
 <87o9pnp3li.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 04 Oct 2017 22:14:17 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > We were aggressive with splitting regions and missed the case
> > when _stext and __init_begin completely overlap addr and addr+mapping.
> >
> > This patch fixes that case and allows us to keep the largest possible
> > mapping through the overlap. The patch also simplies the check
> > into a function  
> 
> Please do the fix in one patch, which we can backport if necessary, and
> then move it into a function in a separate patch.
> 

I've tried for a while now, although this looks like its touching more
code, this is more elegant. Anything else involves changing the two
if conditions almost identically.

Balbir Singh.
