Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A28C32C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 16:41:29 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 4 Dec 2012 11:11:13 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B25ACE004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 11:10:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB45fHiM33161264
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2012 11:11:18 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB45fHqi023318
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2012 16:41:17 +1100
Message-ID: <1354599673.2649.20.camel@ThinkPad-T5421.cn.ibm.com>
Subject: Re: [PATCH powerpc] Fix MAX_STACK_TRACE_ENTRIES too low warning for
 ppc32
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Date: Tue, 04 Dec 2012 13:41:13 +0800
In-Reply-To: <CAHj3AVmF_NV4YoG9TOgWjJ34gCz=+9qtvAKA3o00gxnsRJQdFg@mail.gmail.com>
References: <1354515562.3243.27.camel@ThinkPad-T5421.cn.ibm.com>
 <CAHj3AVmF_NV4YoG9TOgWjJ34gCz=+9qtvAKA3o00gxnsRJQdFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-12-03 at 11:03 +0300, Denis Kirjanov wrote:
> Could you please provide a more verbose patch description

Sorry about the missing background. You may check

[0] http://lkml.indiana.edu/hypermail/linux/kernel/1211.0/03025.html
http://patchwork.ozlabs.org/patch/193414/
http://patchwork.ozlabs.org/patch/202385/

And as it is very similar to that of commit 12660b17, so I think it's
not needed to repeat that in the change log. 

Thanks, Zhong

> 
> Thanks.
> 
> On 12/3/12, Li Zhong <zhong@linux.vnet.ibm.com> wrote:
> > This patch fixes MAX_STACK_TRACE_ENTRIES too low warning for ppc32,
> > which is similar to commit 12660b17.
> >
> > Reported-by: Christian Kujau <lists@nerdbynature.de>
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > Tested-by: Christian Kujau <lists@nerdbynature.de>
> > ---
> >  arch/powerpc/kernel/entry_32.S |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/entry_32.S
> > b/arch/powerpc/kernel/entry_32.S
> > index d22e73e..e514de5 100644
> > --- a/arch/powerpc/kernel/entry_32.S
> > +++ b/arch/powerpc/kernel/entry_32.S
> > @@ -439,6 +439,8 @@ ret_from_fork:
> >  ret_from_kernel_thread:
> >  	REST_NVGPRS(r1)
> >  	bl	schedule_tail
> > +	li	r3,0
> > +	stw	r3,0(r1)
> >  	mtlr	r14
> >  	mr	r3,r15
> >  	PPC440EP_ERR42
> > --
> > 1.7.9.5
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> 
> 
