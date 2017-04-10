Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1j2T5wY7zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 17:47:29 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3A7iE0j088423
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 03:47:27 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29r4vt2xtt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 03:47:26 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 10 Apr 2017 17:47:24 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3A7lEgG52953102
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 17:47:22 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3A7koe0021666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 17:46:50 +1000
Subject: Re: [PATCH v2] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170410071336.C2A702803A@b01ledav001.gho.pok.ibm.com>
Cc: aik@ozlabs.ru
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 10 Apr 2017 17:46:25 +1000
MIME-Version: 1.0
In-Reply-To: <20170410071336.C2A702803A@b01ledav001.gho.pok.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <32f9de05-a15f-de7e-d6ab-d77f71d76635@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/17 17:11, Russell Currey wrote:
> eeh_handle_special_event() is called when an EEH event is detected but
> can't be narrowed down to a specific PE.  This function looks through
> every PE to find one in an erroneous state, then calls the regular event
> handler eeh_handle_normal_event() once it knows which PE has an error.
>
> However, if eeh_handle_normal_event() found that the PE cannot possibly
> be recovered, it will free it, rendering the passed PE stale.
> This leads to a use after free in eeh_handle_special_event() as it attempts to
> clear the "recovering" state on the PE after eeh_handle_normal_event() returns.
>
> Thus, make sure the PE is valid when attempting to clear state in
> eeh_handle_special_event().
>
> Cc: <stable@vger.kernel.org> #3.10+
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
