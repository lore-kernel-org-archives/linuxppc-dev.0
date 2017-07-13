Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7MNQ4fjFzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:52:54 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6D3qKj1020368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 23:52:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3q5ek0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 23:52:51 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 13 Jul 2017 13:52:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6D3pV7026738920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:51:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6D3pMR7016290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 13:51:22 +1000
Subject: Re: [PATCH 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
Cc: anton@samba.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 13 Jul 2017 13:51:30 +1000
MIME-Version: 1.0
In-Reply-To: <20170713032548.451-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5baaa1d2-b57d-3330-b496-b011cd209815@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/07/17 13:25, Matt Brown wrote:
> @@ -1049,6 +1066,13 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			do_cmp_unsigned(regs, val, val2, rd >> 2);
>  			goto instr_done;
>
> +		case 19173952: /* cmpb */

This looks wrong and should never trigger, given that the switch 
statement is comparing against ((instr >> 1) & 0x3ff).

How did you get this value?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
