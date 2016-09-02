Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQfvT0Km9zDrpD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 23:23:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u82DMa2o004249
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 09:23:13 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2576nt508y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 09:23:12 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 2 Sep 2016 23:23:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BA7512BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 23:23:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u82DN6qd60096634
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 23:23:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u82DN5uL006362
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 23:23:06 +1000
Subject: Re: [PATHC v2 5/9] ima: on soft reboot, save the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, Thiago
 Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>
Date: Fri, 02 Sep 2016 09:22:59 -0400
In-Reply-To: <20160901015712.GA3425@dhcp-128-65.nay.redhat.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com>
 <20160901015712.GA3425@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1472822579.3669.13.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

On Thu, 2016-09-01 at 09:57 +0800, Dave Young wrote:
> On 08/30/16 at 06:40pm, Mimi Zohar wrote:

> > + * Called during kexec_file_load so that IMA can add a segment to the kexec
> > + * image for the measurement list for the next kernel.
> > + */
> > +void ima_add_kexec_buffer(struct kimage *image)
> > +{
> > +	static int registered = 0;
> > +	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
> > +				  .buf_min = 0, .buf_max = ULONG_MAX,
> > +				  .top_down = true, .skip_checksum = true };
> > +	int ret;
> > +
> > +	if (!kexec_can_hand_over_buffer())
> > +		return;
> > +
> > +	kexec_segment_size = ALIGN(ima_get_binary_runtime_size() + PAGE_SIZE,
> > +				   PAGE_SIZE);
> > +
> > +	if (kexec_segment_size >= (ULONG_MAX - sizeof(long))) {
> > +		pr_err("Binary measurement list too large.\n");
> > +		return;
> > +	}
> 
> Now we added a limitation that total segment size can not be larger than
> half of totalram. see kernel/kexec_core.c sanity_check_segment_list()
> 
> So can it fail early here if kexec_segment_size is over half of total
> ram?

Sure, I'll include this change in the next post.

Mimi
