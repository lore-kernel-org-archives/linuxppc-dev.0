Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDLyH16k2zDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 04:49:58 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7GImsaB096964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 14:49:54 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24t032gmhf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 14:49:53 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 16 Aug 2016 15:49:51 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A42551DC0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 14:49:39 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7GInmaX26083614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 15:49:48 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7GInlwS003201
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 15:49:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
Date: Tue, 16 Aug 2016 15:49:46 -0300
In-Reply-To: <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1906561.y8blzB2uZ8@hactar> <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2089791.XEmIvA1k4K@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 16 August 2016, 16:15:55 schrieb Balbir Singh:
> On 16/08/16 00:49, Thiago Jung Bauermann wrote:
> > Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
> >> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
> >>> Adapt all callers to the new function prototype.
> >> 
> >> Could you please expand on this?
> > 
> > Is the following better?
> > 
> > Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
> 
> Yes and the reason for doing so? Consolidation/clarity of implementation?

Indeed. What about this commit message?

Subject: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take  
 kexec_buf as argument.

This is done to simplify the kexec_add_buffer argument list.
Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.

In addition, change the type of kexec_buf.buffer from char * to void *.
There is no particular reason for it to be a char *, and the change
allows us to get rid of 3 existing casts to char * in the code.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
