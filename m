Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9z1T64Z0zDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 07:44:29 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7CLdYkS018018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 17:44:27 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24s2up7y1f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 17:44:27 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 12 Aug 2016 18:44:25 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2B6141DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 17:44:14 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7CLiN3G4722854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 18:44:23 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7CLiL6b004785
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 18:44:23 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: bsingharora@gmail.com
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 David Laight <David.Laight@aculab.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: extend kexec_file_load system call
Date: Fri, 12 Aug 2016 18:44:16 -0300
In-Reply-To: <20160812081739.GB22218@350D>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160812081739.GB22218@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1606244.4vNzhVNUBR@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Balbir,

Thank you for the review!

Am Freitag, 12 August 2016, 18:17:39 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:03:58PM -0300, Thiago Jung Bauermann wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3523bf62f328..847d9c31f428 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2656,6 +2656,7 @@ extern int do_pipe_flags(int *, int);
> > 
> >  	id(MODULE, kernel-module)		\
> >  	id(KEXEC_IMAGE, kexec-image)		\
> >  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> > 
> > +	id(KEXEC_PARTIAL_DTB, kexec-partial-dtb)		\
> 
> The backspace is over-indented?

Indeed, I'll fix that. But to keep it aligned with the other backslashes, 
there would be no spaces between it and the final closing parenthesis. 
Either that, or reindent the other backslashes one more level. I think I 
prefer the former.
 
> > @@ -160,6 +180,55 @@ kimage_file_prepare_segments(struct kimage *image,
> > int kernel_fd, int initrd_fd,> 
> >  		image->initrd_buf_len = size;
> >  	
> >  	}
> > 
> > +	if (flags & KEXEC_FILE_EXTRA_FDS) {
> > +		int nr_fds, i;
> > +		size_t fdset_size;
> > +		char fdset_buf[MAX_FDSET_SIZE];
> 
> Do we really want this on the stack?  I presume the size is not large

It has 132 bytes. Would it be better to use kmalloc instead?

> > +		struct kexec_fdset *fdset = (struct kexec_fdset *) 
fdset_buf;
> > +
> > +		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
> > +		if (ret) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +
> > +		if (nr_fds > KEXEC_SEGMENT_MAX) {
> 
> We need an nr_fds < 0 check as well

Indeed, I forgot to do that. I will add the check.

> > +			ret = -E2BIG;
> > +			goto out;
> > +		}
> > +
> > +		fdset_size = sizeof(struct kexec_fdset)
> > +				+ nr_fds * sizeof(struct kexec_file_fd);
> > +
> > +		ret = copy_from_user(fdset, ufdset, fdset_size);
> 
> Can the user change nr_fds between the two copy_from_users, ideally not,
> but we should validate it.

Good catch. I'll check if nr_fds == fdset->nr_fds and return with an error 
if they're different.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
