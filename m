Return-Path: <amodra@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CF192C00A9
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 17:12:44 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id lf1so4459478pab.10
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 00:12:41 -0700 (PDT)
Date: Tue, 27 Aug 2013 16:42:35 +0930
From: Alan Modra <amodra@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Work around gcc miscompilation of __pa() on
 64-bit
Message-ID: <20130827071235.GQ3430@bubble.grove.modra.org>
References: <20130827060749.GA16462@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130827060749.GA16462@drongo>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 27, 2013 at 04:07:49PM +1000, Paul Mackerras wrote:
> On 64-bit, __pa(&static_var) gets miscompiled by recent versions of
> gcc as something like:
> 
>         addis 3,2,.LANCHOR1+4611686018427387904@toc@ha
>         addi 3,3,.LANCHOR1+4611686018427387904@toc@l

I might argue that this isn't a miscompilation, since -mcmodel=medium
assumes everything can be accessed within +/-2G of the toc pointer,
but it's definitely a problem since gas and/or ld don't give an
overflow error.  They would except for the fact that our ABI has a
hole in it.

We have relocs that error on 16-bit overflow, eg.
  addi 3,2,x@toc
will give an error if x is more than +/-32k from the toc pointer, but
@ha and _HA/_HI relocs don't error on 32-bit overflow.  (They can't,
because they were really designed to be used in HIHGESTA, HIGHERA, HA,
LO sequences to build up 64-bit values.)

The proper fix is to define a whole slew of new relocations and reloc
specifiers, and modify everything to use them, but that seems like too
much bother.  I had ideas once upon a time to implement gas and ld
options that makes @ha and _HA report overflows, but haven't found one
of those round tuits.

-- 
Alan Modra
Australia Development Lab, IBM
