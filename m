Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHbp08M4zDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:46:14 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v14so462039pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 22:46:13 -0700 (PDT)
Message-ID: <1496814365.18257.3.camel@gmail.com>
Subject: Re: [PATCH v3 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr,  paulus@samba.org
Date: Wed, 07 Jun 2017 15:46:05 +1000
In-Reply-To: <20170606191249.GG19390@naverao1-tp.localdomain>
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-4-bsingharora@gmail.com>
 <20170606191249.GG19390@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-07 at 00:42 +0530, Naveen N. Rao wrote:
> On 2017/06/06 02:29PM, Balbir Singh wrote:
> > With text moving to read-only migrate optprobes to using
> > the patch_instruction infrastructure. Without this optprobes
> > will fail and complain.
> > 
<snip>
> > +	/* We can optimize this via patch_instruction_window later */
> 
> This probably needs a TODO just so it's clear. I do think this would be 
> good to add since we copy many instructions while setting up the 
> optprobe, so this is quite slow as it exists today.

I made it read like a TODO, with a TOOD:

> 
> > +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);
> 
> That's just TMPL_END_IDX.
>

The entire kprobe_opcode_t and int types thing is a bit messy. The size
calculation assumes nothing for now in terms of sizes, but I guess the
patch_instruction does. Another TODO?

Thanks for the review
Balbir Singh.
