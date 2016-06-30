Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgPbb4V1dzDrGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 02:08:26 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UG4SvZ048311
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:08:24 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23w62wsqsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:08:23 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 13:08:21 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 112B73520070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:08:02 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UG8Jia5570894
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:08:19 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UG8IgP032029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:08:19 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Thu, 30 Jun 2016 13:08:16 -0300
In-Reply-To: <20160630154119.GB3058@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1736656.LVyt5NrzWE@hactar>
 <20160630154119.GB3058@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1786832.5GOvNa6ecY@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 30 Juni 2016, 11:41:19 schrieb Dave Young:
> On 06/29/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > Am Mittwoch, 29 Juni 2016, 15:45:18 schrieb Dave Young:
> > > On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > > > Am Dienstag, 28 Juni 2016, 15:20:55 schrieb Dave Young:
> > > > > On 06/27/16 at 04:21pm, Dave Young wrote:
> > > It looks good except one nitpick inline..
> > > 
> > > > +/**
> > > > + * kexec_locate_mem_hole - find free memory to load segment or use
> > > > in
> > > > purgatory
> > > 
> > > It is not necessary to use only for purgatory load..
> > 
> > Ok, what about this?
> > 
> > /**
> > 
> >  * kexec_locate_mem_hole - find free memory in a given kimage.
> 
> Hmm, a given kimage sounds not correct, I can not get a better way to
> describe it. How about below with a little change to your previous one:
> 
> kexec_locate_mem_hole - find a free chunk of memory to load kexec segment.
> In powerpc the memory chunk can also be used for the purgatory stack.

That describes what the memory currently is used for. If powerpc or any 
other architecture starts to use the memory for something else, this comment 
would need to be updated. :-)

What the function really does is find free memory in the physical address 
space after the currently running kernel hands over control to whatever runs 
next. What that memory is used for is decided by the caller of the function.

Since (at least for now), the only things that run next are the purgatory 
and the next kernel, what about this?

kexec_locate_mem_hole - find free memory for the purgatory or the next 
kernel

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
