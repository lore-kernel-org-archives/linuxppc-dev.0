Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7dzQ57d3zDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:50:26 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JNmcbg145962
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 19:50:23 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x77dmypy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 19:50:23 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 09:50:20 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JNo9bK61341746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:50:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JNnfb8020742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:49:41 +1000
Date: Thu, 20 Apr 2017 09:49:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru
Subject: Re: [PATCH v3 1/2] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170419073927.29224-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419073927.29224-1-ruscur@russell.cc>
Message-Id: <20170419234921.GB7528@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 05:39:26PM +1000, Russell Currey wrote:
>eeh_handle_special_event() is called when an EEH event is detected but
>can't be narrowed down to a specific PE.  This function looks through
>every PE to find one in an erroneous state, then calls the regular event
>handler eeh_handle_normal_event() once it knows which PE has an error.
>
>However, if eeh_handle_normal_event() found that the PE cannot possibly
>be recovered, it will free it, rendering the passed PE stale.
>This leads to a use after free in eeh_handle_special_event() as it attempts to
>clear the "recovering" state on the PE after eeh_handle_normal_event() returns.
>
>Thus, make sure the PE is valid when attempting to clear state in
>eeh_handle_special_event().
>
>Cc: <stable@vger.kernel.org> #3.10+
>Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
