Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7wn45PXpzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 23:56:40 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79DsZip029630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 09:56:38 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qa6r2b2m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 09:56:37 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Aug 2016 19:26:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7FACFE0062
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 19:30:44 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79DuHgv61931730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 19:26:17 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79DuDXg013437
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 19:26:17 +0530
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Date: Tue, 09 Aug 2016 09:55:57 -0400
In-Reply-To: <3544655.o5QPxko4Ba@hactar>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470750957.2881.131.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-09 at 10:19 -0300, Thiago Jung Bauermann wrote:
> Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> > On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> > > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > > > diff --git a/security/integrity/ima/ima.h
> > > > b/security/integrity/ima/ima.h
> > > > index b5728da..84e8d36 100644
> > > > --- a/security/integrity/ima/ima.h
> > > > +++ b/security/integrity/ima/ima.h
> > > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> > > > 
> > > >  };
> > > >  extern struct list_head ima_measurements;	/* list of all 
> measurements
> > > >  */
> > > > 
> > > > +/* Some details preceding the binary serialized measurement list */
> > > > +struct ima_kexec_hdr {
> > > > +	unsigned short version;
> > > > +	unsigned long buffer_size;
> > > > +	unsigned long count;
> > > > +} __packed;
> > > > +
> > > 
> > > Am I understanding it correctly that this structure is passed between
> > > kernels?
> > Yes, the header prefixes the measurement list, which is being passed on
> > the same computer to the next kernel.  Could the architecture (eg.
> > LE/BE) change between soft re-boots?
> 
> Yes. I am able to boot a BE kernel from an LE kernel with my patches. 
> Whether we want to support that or not is another question...

The <securityfs/ima/binary_runtime_measurements is system architecture
dependent.  It looks like the khdr->version check in
ima_restore_measurement_list() would fail if the architecture changes.

If/when we update the binary measurement list format to support multiple
TPM PCRs, we should address the endianness as well.

Mimi
