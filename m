Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t94wc4YXkzDvXr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 13:07:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA423mEe049948
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 22:07:26 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gamppu44-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 22:07:25 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 4 Nov 2016 12:07:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 40CDD2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 13:07:19 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA427IAN15794256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 13:07:18 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA427HmW030847
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 13:07:18 +1100
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten> <581ACDF2.1010409@linux.vnet.ibm.com>
 <8737j8opwb.fsf@concordia.ellerman.id.au>
 <581B110F.9050805@linux.vnet.ibm.com>
Cc: chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, oss@buserror.net,
 paul.gortmaker@windriver.com, duwe@lst.de, Anton Blanchard
 <anton@samba.org>, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, oohall@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, viro@zeniv.linux.org.uk
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 4 Nov 2016 13:07:15 +1100
MIME-Version: 1.0
In-Reply-To: <581B110F.9050805@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e993dc5c-7a90-e43b-b761-a70a79b3d1d9@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/16 21:27, Ravi Bangoria wrote:
> Yes, kernel-space hw-breakpoint feature is broken on LE without this.

Is there any actual user-visible feature that depends on this, or is 
this solely for debugging and development purposes?

It would of course be *nice* to have it in stable trees (particularly so 
we pick it up in distros) but I'm not convinced that enabling HW 
breakpoints on a platform where it has *never* worked qualifies as an 
"actual bug".

(BTW many thanks for fixing this - I had a shot at it late last year but 
never quite got there!)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
