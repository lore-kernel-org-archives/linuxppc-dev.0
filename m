Return-Path: <glikely@secretlab.ca>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FFBAB6FC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 17:08:16 +1100 (EST)
Received: by obbup6 with SMTP id up6so2401055obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 22:08:11 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20120224163042.4cc2633945c9799b997ff4e7@canb.auug.org.au>
References: <20120224162504.49480de981431c3fd95601a2@canb.auug.org.au>
 <20120224163042.4cc2633945c9799b997ff4e7@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 23 Feb 2012 23:07:51 -0700
Message-ID: <CACxGe6tgrAj+sHJ211=pRcqYBSM0xq2f1ycctK4RXLT7rSNhww@mail.gmail.com>
Subject: Re: linux-next: manual merge of the irqdomain tree with the powerpc
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2012 at 10:30 PM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> [Just adding the PPC guys]
>
> On Fri, 24 Feb 2012 16:25:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>>
>> Hi Grant,
>>
>> Today's linux-next merge of the irqdomain tree got a conflict in
>> arch/powerpc/sysdev/mpic.c between commits 3a7a7176e840 ("powerpc/mpic:
>> Fix use of "flags" variable in mpic_alloc()") and c1b8d45db4db
>> ("powerpc/mpic: Add "last-interrupt-source" property to override
>> hardware") from the powerpc tree and commit a8db8cf0d894 ("irq_domain:
>> Replace irq_alloc_host() with revmap-specific initializers") from the
>> irqdomain tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary.

Thanks Stephen.

g.

>> --
>> Cheers,
>> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.or=
g.au
>>
>> diff --cc arch/powerpc/sysdev/mpic.c
>> index b9b989d,c83a512..0000000
>> --- a/arch/powerpc/sysdev/mpic.c
>> +++ b/arch/powerpc/sysdev/mpic.c
>> @@@ -1351,9 -1345,9 +1351,8 @@@ struct mpic * __init mpic_alloc(struct
>> =A0 =A0 =A0 mpic->isu_shift =3D 1 + __ilog2(mpic->isu_size - 1);
>> =A0 =A0 =A0 mpic->isu_mask =3D (1 << mpic->isu_shift) - 1;
>>
>> - =A0 =A0 mpic->irqhost =3D irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINE=
AR,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0mpic->isu_size, &mpic_host_ops,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0intvec_top + 1);
>> + =A0 =A0 mpic->irqhost =3D irq_domain_add_linear(mpic->node,
>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 isu_size ? isu_size : mpic->num_sources,
>> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 &mpic_host_ops, mpic);
>> ++ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m=
pic->isu_size, &mpic_host_ops, mpic);
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* FIXME: The code leaks the MPIC object and mappings here=
; this



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
