Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F16A1A023A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 18:42:29 +1000 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 24 Jun 2014 09:42:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 203392190042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 09:42:10 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5O8gLoo33816660
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 08:42:22 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5O8gLxm003272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 02:42:21 -0600
Message-ID: <53A939EC.7060206@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2014 10:42:20 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: module: fix TOC symbol CRC
References: <20140617155658.30560.578.stgit@nimbus>
 <20140619094404.18e7047b@kryten> <1403582770.4587.150.camel@pasglop>
In-Reply-To: <1403582770.4587.150.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: rusty@rustcorp.com.au, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24/06/2014 06:06, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-19 at 09:44 +1000, Anton Blanchard wrote:
>> Hi Laurent,
>>
>>> The commit 71ec7c55ed91 introduced the magic symbol ".TOC." for ELFv2
>>> ABI. This symbol is built manually and has no CRC value computed. A
>>> zero value is put in the CRC section to avoid modpost complaining
>>> about a missing CRC. Unfortunately, this breaks the kernel module
>>> loading when the kernel is relocated (kdump case for instance)
>>> because of the relocation applied to the kcrctab values.
>>>
>>> This patch compute a CRC value for the TOC symbol which will match
>>> the one compute by the kernel when it is relocated - aka '0 -
>>> relocate_start' done in maybe_relocated called by check_version
>>> (module.c).
>>
>> Adding Rusty since he maintains the module loader code.
> 
> This patch gives me:
> 
> arch/powerpc/kernel/module_64.c: In function 'dedotify_versions':
> arch/powerpc/kernel/module_64.c:325:33: error: 'reloc_start' undeclared (first use in this function)
> arch/powerpc/kernel/module_64.c:325:33: note: each undeclared identifier is reported only once for each function it appears in

Hi Ben,

My mistake, I forgot to check building the kernel when module version
checking is disabled. I'll send a v2 asap.

Cheers,
Laurent.


> Cheers,
> Ben.
> 
> 
