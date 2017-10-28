Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yPcBK2sTVzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Oct 2017 10:18:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9SNDXgU028884
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Oct 2017 19:18:45 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dvp3crp8t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Oct 2017 19:18:45 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 28 Oct 2017 17:18:44 -0600
Date: Sat, 28 Oct 2017 16:18:35 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, mhocko@kernel.org,
 paulus@samba.org, ebiederm@xmission.com, bauerman@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH 09/25] powerpc: ability to create execute-disabled pkeys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-18-git-send-email-linuxram@us.ibm.com>
 <87h8up88n1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h8up88n1.fsf@linux.vnet.ibm.com>
Message-Id: <20171028231835.GB5587@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2017 at 10:06:18AM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > powerpc has hardware support to disable execute on a pkey.
> > This patch enables the ability to create execute-disabled
> > keys.
> 
> Can you summarize here how this works?  Access to IAMR is
> privileged so how will keys framework work with IAMR? 
> 
> -aneesh

right. IAMR will have to programmed through a system call.
I have introduced a sys_pkey_modify()  which takes a key value
and the permission that it wants to enable/disable on that key.
This syscall is powerpc specific only for now, since no other
arch's need it.

The patch is at http://patchwork.ozlabs.org/patch/817961/

-- 
Ram Pai
