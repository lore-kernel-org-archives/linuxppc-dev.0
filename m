Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3wMK5Jd6zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 08:24:45 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DMOEir085993
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:24:34 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t75vp6fb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:24:33 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 18:24:33 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v4] cxl: Force context lock during EEH flow
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <a175a714-fa02-2fbd-e1c7-aa9e1305aac1@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 17:24:18 -0500
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 stable@vger.kernel.org, Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
References: <20170405113553.7354-1-vaibhav@linux.vnet.ibm.com>
 <272babe1-780f-c1da-c358-c70238a8ada7@linux.vnet.ibm.com>
 <87mvbnut12.fsf@concordia.ellerman.id.au>
 <a175a714-fa02-2fbd-e1c7-aa9e1305aac1@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-Id: <1082D8B3-29EE-46C4-8A46-BD426EA1B7E3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Apr 11, 2017, at 6:13 AM, Frederic Barrat =
<fbarrat@linux.vnet.ibm.com> wrote:
> Le 11/04/2017 =C3=A0 12:40, Michael Ellerman a =C3=A9crit :
>> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>>=20
>>> Le 05/04/2017 =C3=A0 13:35, Vaibhav Jain a =C3=A9crit :
>>>> During an eeh event when the cxl card is fenced and card sysfs attr
>>>> perst_reloads_same_image is set following warning message is seen =
in the
>>>> kernel logs:
>>>>=20
>>>> [   60.622727] Adapter context unlocked with 0 active contexts
>>>> [   60.622762] ------------[ cut here ]------------
>>>> [   60.622771] WARNING: CPU: 12 PID: 627 at
>>>> ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 =
[cxl]
>>>>=20
>>>> Even though this warning is harmless, it clutters the kernel log
>>>> during an eeh event. This warning is triggered as the EEH callback
>>>> cxl_pci_error_detected doesn't obtain a context-lock before =
forcibly
>>>> detaching all active context and when context-lock is released =
during
>>>> call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
>>>> cxl_adapter_context_unlock is triggered.
>>>>=20
>>>> To fix this warning, we acquire the adapter context-lock via
>>>> cxl_adapter_context_lock() in the eeh callback
>>>> cxl_pci_error_detected() once all the virtual AFU PHBs are notified
>>>> and their contexts detached. The context-lock is released in
>>>> cxl_pci_slot_reset() after the adapter is successfully reconfigured
>>>> and before we call slot_reset callback on slice attached =
device-drivers.
>>>>=20
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active =
context exists")
>>>> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>>> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>>>> ---
>>>=20
>>> Pending test result from cxl-flash:
>>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>>=20
>> Still pending ... ?
>=20
> Yes, still waiting. It was mentioned in a call with the cxlflash team =
yesterday.

I have it queued up for us to do on Monday.

-matt
