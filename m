Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cCK0lrGzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:34:04 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LDXxFU102469
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:33:59 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29y02edt8q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:33:57 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 23:33:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3LDWvq48323482
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:33:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3LDWWDs026243
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:32:32 +1000
Date: Fri, 21 Apr 2017 13:32:10 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1492778567.git.christophe.leroy@c-s.fr>
 <97d45054364142af48b8767f9f9e115504d7568b.1492778567.git.christophe.leroy@c-s.fr>
In-Reply-To: <97d45054364142af48b8767f9f9e115504d7568b.1492778567.git.christophe.leroy@c-s
 .fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492781365.w4t118903f.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Christophe Leroy's message of April 21, 2017 18:32:
> This patch implements CONFIG_DEBUG_RODATA on PPC32.
>=20
> As for CONFIG_DEBUG_PAGEALLOC, it deactivates BAT and LTLB mappings
> in order to allow page protection setup at the level of each page.
>=20
> As BAT/LTLB mappings are deactivated, their might be performance
> impact. For this reason, we keep it OFF by default.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

[snip]

> diff --git a/arch/powerpc/kernel/ftrace.c=20
> b/arch/powerpc/kernel/ftrace.c
> index 32509de6ce4c..06d2ac53f471 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -46,6 +46,7 @@ static int
>  ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
>  {
>  	unsigned int replaced;
> +	int err;
>=20
>  	/*
>  	 * Note:
> @@ -67,10 +68,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old=
, unsigned int new)
>  	}
>=20
>  	/* replace the text with the new text */
> -	if (patch_instruction((unsigned int *)ip, new))
> -		return -EPERM;
> +	set_kernel_text_rw(ip);
> +	err =3D patch_instruction((unsigned int *)ip, new);
> +	set_kernel_text_ro(ip);

Is there a reason to not put those inside patch_instruction()?

- Naveen

=
