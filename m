Return-Path: <ulrich.weigand@de.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B28A14008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 00:20:12 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ulrich.weigand@de.ibm.com>;
 Tue, 25 Mar 2014 13:20:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id EEC322190041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 13:19:58 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PDJqbC66256964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 13:19:52 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PDK3pL002906
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 09:20:03 -0400
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Subject: Re: [PATCH 00/33] Build ppc64le kernel using ABIv2
To: Anton Blanchard <anton@samba.org>
Message-ID: <OF5605E77F.F2B0528E-ONC1257CA6.00487EE5-C1257CA6.00491690@de.ibm.com>
From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Date: Tue, 25 Mar 2014 14:18:19 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, amodra@gmail.com, rusty@rustcorp.com.au,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote on 25.03.2014 12:44:06:

> There are two known outstanding issues:
>
> - If a kernel module calls into an exported assembly function
>   which in turns calls out to C, r2 is going to be wrong. One example
>   is __copy_tofrom_user_power7.
>
>   The reason is _GLOBAL() doesn't have a global entry point setup
>   with the associated addis/addi used to create r2. I tried adding
>   it and quickly realised that _GLOBAL is used places that will not
>   tolerate the addi/addis (eg __start()).

You probably should have two different macros _GLOBAL_TOC vs. _GLOBAL
(or _GLOBAL vs. _GLOBAL_NOTOC), and use the variant that provides a
global entry point setting up the TOC only with those functions that
actually require a TOC.

> - arch/powerpc/platforms/pseries/hvCall.S assumes we always have a
>   parameter save area, which is incorrect for ABIv2. I tried to be
>   intelligent and use the toc save area to store some information
>   but that failed as soon as we started using modules. It would be
>   nice to avoid a stack frame in the common (tracepoints disabled)
>   case, but we may end up having to allocate one.

When I looked at this last time, I remarked:

>./platforms/pseries/hvCall.S:
>./platforms/cell/beat_hvCall.S:
>Looks safe since all functions are called via varargs prototypes
>(or > 8 integer arguments).

Checking again, this still seems true.  These are the prototypes
for all the functions in hvCall.S:

long plpar_hcall_norets(unsigned long opcode, ...);
long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);

Functions like that *will* always have a save area allocated by
the caller, even in the ELFv2 ABI.

Am I missing something here?

Bye,
Ulrich
