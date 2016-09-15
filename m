Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZLxb1DrfzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 11:51:47 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F1ldYA111020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:51:45 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25exb91n4f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:51:45 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 22:51:42 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1C1BF352005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:51:17 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F1pef116318674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 22:51:40 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F1pdAn018349
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 22:51:40 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: kexec@lists.infradead.org, linux-ima-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the
 kexec image checksum.
Date: Wed, 14 Sep 2016 22:51:36 -0300
In-Reply-To: <20160915114308.19195f71@canb.auug.org.au>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160915114308.19195f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4542776.bqQjVnlNjh@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Stephen,

Am Donnerstag, 15 September 2016, 11:43:08 schrieb Stephen Rothwell:
> Hi Thiago,
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 2a1f0ce7c59a..dcd1679f3005 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1792,6 +1792,11 @@ config SECCOMP
> > 
> >  source kernel/Kconfig.hz
> > 
> > +# x86 needs to relocate the purgatory after the checksum is calculated,
> > +# therefore the purgatory cannot be part of the kexec image checksum.
> > +config ARCH_MODIFIES_KEXEC_PURGATORY
> > +	bool
> > +
> 
> The above should probably be in arch/Kconfig (with an appropriately
> changed comment) since it is used in generic code.

Thanks for your quick response! I'll make that change tomorrow and send an 
updated version of just this patch.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
