Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfwKy39k2zDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:09:58 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TL3q0Z063102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:09:55 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23uw5qj95h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:09:55 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 18:09:53 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 7ACF31DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:09:44 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5TL9paA4784160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:09:51 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5TL9p2M017110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:09:51 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Wed, 29 Jun 2016 18:09:46 -0300
In-Reply-To: <20160629194518.GA5488@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1495163.EskJqap5EJ@hactar>
 <20160629194518.GA5488@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1736656.LVyt5NrzWE@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 29 Juni 2016, 15:45:18 schrieb Dave Young:
> On 06/28/16 at 07:18pm, Thiago Jung Bauermann wrote:
> > Am Dienstag, 28 Juni 2016, 15:20:55 schrieb Dave Young:
> > > On 06/27/16 at 04:21pm, Dave Young wrote:
> > > Using one argument for both sounds more reasonable than using a
> > > separate
> > > argument for memory walk..
> > 
> > I agree. This patch doesn't use a separate top_down argument, it's the
> > same patch I sent earlier except that the comments to struct kexec_buf
> > are in patch 2/9. What do you think?
> 
> It looks good except one nitpick inline..
> 
>
> > +/**
> > + * kexec_locate_mem_hole - find free memory to load segment or use in
> > purgatory
 
> It is not necessary to use only for purgatory load..

Ok, what about this?

/**
 * kexec_locate_mem_hole - find free memory in a given kimage.


[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
