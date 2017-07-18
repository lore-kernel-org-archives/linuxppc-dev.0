Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBSfz5s1XzDrFb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 15:01:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6I4wsVr116731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 01:01:13 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bsa8s39mw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 01:01:12 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 18 Jul 2017 01:01:12 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>, dwmw2@infradead.org,
 computersforpeace@gmail.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: powernv_flash: Lock around concurrent access to
 OPAL
In-Reply-To: <20170607054355.10590-2-cyrilbur@gmail.com>
References: <20170607054355.10590-1-cyrilbur@gmail.com>
 <20170607054355.10590-2-cyrilbur@gmail.com>
Date: Tue, 18 Jul 2017 15:01:03 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r2xecp9s.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyril Bur <cyrilbur@gmail.com> writes:
> OPAL can only manage one flash access at a time and will return an
> OPAL_BUSY error for each concurrent access to the flash. The simplest
> way to prevent this from happening is with a mutex.
>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> This is to address https://github.com/open-power/skiboot/issues/80

part of me wants to say "let's only take the lock if we ever get back
OPAL_BUSY" or something like that (have a DT property to say the flash
supports concurrent ops?)

Although the other part of me says "you're overthinking this, get back
to the work you're meant to be doing" :)

-- 
Stewart Smith
OPAL Architect, IBM.
