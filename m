Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfwXG3ccczDr5K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:18:54 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TLIZJa048232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:18:52 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3wvhsa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:18:51 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 18:18:49 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 489EF3520072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:18:29 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TLIjgn61014186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:18:45 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TLIi6D022276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:18:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Wed, 29 Jun 2016 18:18:43 -0300
In-Reply-To: <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2060648.f0n9OPAato@hactar>
 <20160629194751.GB5488@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1994502.0E8c14rYFh@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 29 Juni 2016, 15:47:51 schrieb Dave Young:
> On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index e8acb2b43dd9..e16d845d587f 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -146,7 +146,30 @@ struct kexec_file_ops {
> > 
> >       kexec_verify_sig_t *verify_sig;
> >  
> >  #endif
> >  };
> > 
> > -#endif
> > +
> > +/**
> > + * struct kexec_buf - parameters for finding a place for a buffer in
> > memory + * @image:   kexec image in which memory to search.
> > + * @mem:     On return will have address of the buffer in memory.
> > + * @memsz:   Size for the buffer in memory.
> > + * @buf_align:       Minimum alignment needed.
> > + * @buf_min: The buffer can't be placed below this address.
> > + * @buf_max: The buffer can't be placed above this address.
> > + * @top_down:        Allocate from top of memory.
> > + */
> > +struct kexec_buf {
> > +     struct kimage *image;
> > +     unsigned long mem;
> > +     unsigned long memsz;
> > +     unsigned long buf_align;
> > +     unsigned long buf_min;
> > +     unsigned long buf_max;
> > +     bool top_down;
> > +};
> 
> Rethink about the first patch, you dropped the user buffer in kexec_buf
> But later your passing IMA digests buffer patchset may need use it.
> 
> So keep it in kexec_buf should be better.

I'm not following. The IMA buffer patchset doesn't use kexec_locate_mem_hole 
nor struct kexec_buf.

> For the IMA buffer patchset I'm still reading and learning the
> background, will reply them later.

Thank you!

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
