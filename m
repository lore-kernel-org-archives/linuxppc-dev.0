Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402HLg3SW3zF1KC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 05:34:35 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2FIYWMF041163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 14:34:33 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqv6f62xj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 14:34:32 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 15 Mar 2018 14:34:12 -0400
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
 <87fu52jqtc.fsf@morokweng.localdomain>
 <20180315115753.rjejlkrp3fhdxbyk@mwanda>
 <1521126196.22221.10.camel@perches.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Josh Sklar <sklar@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
In-reply-to: <1521126196.22221.10.camel@perches.com>
Date: Thu, 15 Mar 2018 15:34:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87605xp4rq.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Joe Perches <joe@perches.com> writes:

> On Thu, 2018-03-15 at 14:57 +0300, Dan Carpenter wrote:
>> On Wed, Mar 14, 2018 at 06:22:07PM -0300, Thiago Jung Bauermann wrote:
>> > 
>> > SF Markus Elfring <elfring@users.sourceforge.net> writes:
>> > 
>> > > From: Markus Elfring <elfring@users.sourceforge.net>
>> > > Date: Sun, 11 Mar 2018 09:03:42 +0100
>> > > 
>> > > Add a jump target so that a bit of exception handling can be better reused
>> > > at the end of this function.
>> > > 
>> > > This issue was detected by using the Coccinelle software.
>> > > 
>> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> > > ---
>> > >  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
>> > >  1 file changed, 12 insertions(+), 16 deletions(-)
>> > 
>> > I liked it. Thanks!
>> > 
>> > Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> > 
>> 
>> You know that compilers already re-use string constants so this doesn't
>> actually save memory?
>
> And modern compilers create their own jump labels
> so this doesn't change object code either?

IMHO it's an improvement to the source code itself. I wasn't thinking
about the object file.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
