Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk06Z1bjyzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:11:33 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2FI94ET044846
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:11:27 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296nfxan7j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 14:11:27 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 15 Mar 2017 14:11:26 -0400
Date: Wed, 15 Mar 2017 13:11:20 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Harshal Patil <harshal.patil@in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Sudipto Ghosh <sudiptoghosh@in.ibm.com>,
 Christy L Norman Perez <clnperez@us.ibm.com>,
 Pradipta Kumar <bpradipt@in.ibm.com>
Subject: Re: ioctl structs differ from x86_64?
References: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
Message-Id: <20170315181119.xeuyjv4pfvr33upf@arbab-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 14, 2017 at 10:37:44AM +0000, Harshal Patil wrote:
>Our guess is the ioctls in ppc64le differ than x86_64, and thats why 
>the code which is clearing onclr bit 
>([4]https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR164)
>is failing on ppc64le but works fine on x86_64. 
> 
>Any pointers on the possible solution would be really helpful. 

This looks like a bug in Go.

The syscall.TCGETS and syscall.TCSETS constants have the wrong values. 
They were generated using the glibc termios struct instead of the kernel 
termios struct. It's the issue described here:

https://groups.google.com/forum/#!topic/golang-nuts/K5NoG8slez0

Things work if you replace syscall.TCGETS with 0x402c7413 and 
syscall.TCSETS with 0x802c7414, the correct values on ppc64le.

-- 
Reza Arbab
