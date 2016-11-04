Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t99SL23ZHzDvPG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 16:31:46 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA45So05009048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 01:31:44 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gexf52we-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 01:31:43 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 23:31:43 -0600
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten> <581ACDF2.1010409@linux.vnet.ibm.com>
 <8737j8opwb.fsf@concordia.ellerman.id.au>
 <581B110F.9050805@linux.vnet.ibm.com>
 <e993dc5c-7a90-e43b-b761-a70a79b3d1d9@au1.ibm.com>
Cc: chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, oss@buserror.net,
 paul.gortmaker@windriver.com, duwe@lst.de, Anton Blanchard
 <anton@samba.org>, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, oohall@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, viro@zeniv.linux.org.uk,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 4 Nov 2016 11:01:30 +0530
MIME-Version: 1.0
In-Reply-To: <e993dc5c-7a90-e43b-b761-a70a79b3d1d9@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <581C1D32.50108@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 04 November 2016 07:37 AM, Andrew Donnellan wrote:
> On 03/11/16 21:27, Ravi Bangoria wrote:
>> Yes, kernel-space hw-breakpoint feature is broken on LE without this.
>
> Is there any actual user-visible feature that depends on this, or is this solely for debugging and development purposes?
>
> It would of course be *nice* to have it in stable trees (particularly so we pick it up in distros) but I'm not convinced that enabling HW breakpoints on a platform where it has *never* worked qualifies as an "actual bug".
>
> (BTW many thanks for fixing this - I had a shot at it late last year but never quite got there!)

Thanks Andrew,

kprobe, uprobe, hw-breakpoint and xmon are the only user of emulate_step.

Kprobe / uprobe single-steps instruction if they can't emulate it, so there
is no problem with them. As I mention, hw-breakpoint is broken. However
I'm not sure about xmon, I need to check that.

So yes, there is no user-visible feature that depends on this.

-Ravi
