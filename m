Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7x1C6wRFzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:07:11 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u79E4XgS087986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 10:07:10 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24ncdd2s5y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 10:07:09 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 00:07:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B924F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:07:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u79E73Th9896170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:07:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u79E735U026749
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:07:03 +1000
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Date: Tue, 09 Aug 2016 10:06:58 -0400
In-Reply-To: <1470750957.2881.131.camel@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <87wpjqtdg8.fsf@concordia.ellerman.id.au>
 <1470747673.2881.118.camel@linux.vnet.ibm.com> <3544655.o5QPxko4Ba@hactar>
 <1470750957.2881.131.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470751618.2881.140.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-09 at 09:55 -0400, Mimi Zohar wrote:
> On Tue, 2016-08-09 at 10:19 -0300, Thiago Jung Bauermann wrote:
> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> > > On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> > > > Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> > > > > diff --git a/security/integrity/ima/ima.h
> > > > > b/security/integrity/ima/ima.h
> > > > > index b5728da..84e8d36 100644
> > > > > --- a/security/integrity/ima/ima.h
> > > > > +++ b/security/integrity/ima/ima.h
> > > > > @@ -102,6 +102,13 @@ struct ima_queue_entry {
> > > > > 
> > > > >  };
> > > > >  extern struct list_head ima_measurements;	/* list of all 
> > measurements
> > > > >  */
> > > > > 
> > > > > +/* Some details preceding the binary serialized measurement list */
> > > > > +struct ima_kexec_hdr {
> > > > > +	unsigned short version;
> > > > > +	unsigned long buffer_size;
> > > > > +	unsigned long count;
> > > > > +} __packed;
> > > > > +
> > > > 
> > > > Am I understanding it correctly that this structure is passed between
> > > > kernels?
> > > Yes, the header prefixes the measurement list, which is being passed on
> > > the same computer to the next kernel.  Could the architecture (eg.
> > > LE/BE) change between soft re-boots?
> > 
> > Yes. I am able to boot a BE kernel from an LE kernel with my patches. 
> > Whether we want to support that or not is another question...
> 
> The <securityfs/ima/binary_runtime_measurements is system architecture
> dependent.  It looks like the khdr->version check in
> ima_restore_measurement_list() would fail if the architecture changes.
> 
> If/when we update the binary measurement list format to support multiple
> TPM PCRs, we should address the endianness as well.

That should have been "TPM PCR banks".  TPM 2.0 allows for multiple TPM
PCR banks.

Mimi
