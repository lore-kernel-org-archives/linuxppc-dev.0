Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgQLy6M4LzDrGH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 02:42:34 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UGdANg097232
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:42:31 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23v0995bme-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:42:31 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 13:42:29 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id F3DBA352007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 12:42:10 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UGgRGn066022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:42:28 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UGgRUj014837
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 13:42:27 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Thu, 30 Jun 2016 13:42:25 -0300
In-Reply-To: <1866019.1p7Z0CLUZh@hactar>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
 <1866019.1p7Z0CLUZh@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1902156.s2yTykCR7c@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> Am Donnerstag, 30 Juni 2016, 11:07:00 schrieb Dave Young:
> > On 06/29/16 at 06:18pm, Thiago Jung Bauermann wrote:
> > > I'm not following. The IMA buffer patchset doesn't use
> > > kexec_locate_mem_hole nor struct kexec_buf.
> > 
> > It does not use kexec_locate_mem_hole, but the buffer being passed is
> > very similar to a kexec_buf struct, no?
> 
> If what you're saying is that the arguments passed to
> kexec_add_handover_buffer in the IMA buffer patchset are very similar to
> the arguments passed to kexec_add_buffer then yes, it's true.
> 
> > So you may refactor kexec_add_buffer and your new function to pass only
> > kimage and a kbuf, it will be better than passing all those arguments
> > separately.
> 
> To be honest I think struct kexec_buf is an implementation detail inside
> kexec_locate_mem_hole, made necessary because the callback functions it
> uses need to access its arguments. Callers of kexec_locate_mem_hole,
> kexec_add_handover_buffer and kexec_add_buffer shouldn't need to know it
> exists.

Elaborating a bit more: the argument list for these three functions are 
equal or similar because kexec_add_handover_buffer uses kexec_add_buffer, 
which uses kexec_locate_mem_hole.

It could be beneficial to have a struct to collect the arguments to these 
functions if someone using one of them would be likely to use another one 
with the same arguments. In that case, you set up kexec_buf once and then 
just pass it whenever you need to call one of those functions.

But that is unlikely to happen. A user of the kexec API will need to use 
only one of these functions with a given set of arguments, so they don't 
gain anything by setting up a struct.

Syntactically, I also don't think it's clearer to set struct members instead 
of simply passing arguments to a function, even if the argument list is 
long.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
