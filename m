Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJTmZ60DVzDvnB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:11:10 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG38Xf9117310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 22:11:07 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rbr1ewj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 22:11:07 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 16 Nov 2016 13:11:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 049F52CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:11:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG3B06O32440494
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:11:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG3B0G1018325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:11:00 +1100
Subject: Re: [PATCH] powerpc/powernv: Don't warn on PE init if unfreeze is
 unsupported
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20161116011226.24589-1-ruscur@russell.cc>
Cc: alistair@popple.id.au, gwshan@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 16 Nov 2016 14:10:59 +1100
MIME-Version: 1.0
In-Reply-To: <20161116011226.24589-1-ruscur@russell.cc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f4d65ab2-d7bd-a22a-88a1-3c7730165571@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/11/16 12:12, Russell Currey wrote:
> Whenever a PE is initialised in powernv, opal_pci_eeh_freeze_clear() is
> called.  This is to remove any existing freeze, and has no negative side
> effects if the PE is already in an unfrozen state.  On PHB backends that
> don't support this operation and return OPAL_UNSUPPORTED, this creates a
> scary and misleading warning message.
>
> Skip the warning message on init if OPAL_UNSUPPORTED is returned.
>
> As far as I'm aware, this currently only affects NPUs.
>
> Fixes: 313483d ("powerpc/powernv: Unfreeze PE on allocation")
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
