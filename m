Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7mxv4HwVzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:05:07 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v96B4x3O034961
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 07:05:04 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2de6q45s2y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 07:05:03 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 05:04:58 -0600
Subject: Re: Possible LMB hot unplug bug in 4.13+ kernels
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <94618f16-b47f-b714-9cb5-4bbbf7fdccdf@linux.vnet.ibm.com>
 <a3846937-53e4-e2be-fe82-3a5765647fa4@linux.vnet.ibm.com>
 <8760bszxww.fsf@concordia.ellerman.id.au>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 6 Oct 2017 08:04:52 -0300
MIME-Version: 1.0
In-Reply-To: <8760bszxww.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3bdf3e9d-a2f4-4820-6ecd-a9b14b3c45c4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Unless you (Daniel) think there's some reason lmb_is_removable() is
> incorrectly returning false. But most likely it's correct and there's
> just an unmovable allocation in that range.

I am not educated enough to say that the current behavior is wrong. What I
can say is that in 4.11 and older kernels that supports LMB hot 
plug/unplug I
didn't see this kernel "refusal" to remove a LMB that was just hotplugged.

Assuming that the kernel is behaving as intended, a QEMU guest started with
4Gb of RAM that receives an extra 1Gb of RAM will not unplug this same 1Gb.
It seems off from the user perspective that a recently added memory is being
considered not removable, thus QEMU will need to keep this limitation in 
mind when
dealing with future LMB bugs in 4.13+ kernels.


Thanks,


Daniel
