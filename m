Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgfs14BxDzF0s6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 22:07:48 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DB4du1036729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 06:07:45 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g3xf493xq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 06:07:44 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 11:07:41 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 2/3] cxl: Introduce module parameter 'enable_psltrace'
In-Reply-To: <51364d03-d7a5-471b-2531-cf4c17af8c8d@linux.vnet.ibm.com>
References: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
 <20180209042535.16845-3-vaibhav@linux.vnet.ibm.com>
 <a3880a5d-6ccb-9a90-14e5-d48376e4c8e0@linux.vnet.ibm.com>
 <87a7wf4flx.fsf@vajain21.in.ibm.com>
 <51364d03-d7a5-471b-2531-cf4c17af8c8d@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 16:37:35 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87zi4d2lmw.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 11/02/2018 =C3=A0 18:10, Vaibhav Jain a =C3=A9crit=C2=A0:
>> Thanks for reviewing the patch Christophe,
>>=20
>> christophe lombard <clombard@linux.vnet.ibm.com> writes:
>>>> +bool cxl_enable_psltrace =3D true;
>>>> +module_param_named(enable_psltrace, cxl_enable_psltrace, bool, 0600);
>>>> +MODULE_PARM_DESC(enable_psltrace, "Set PSL traces on probe. default: =
on");
>>>> +
>>> I am not too agree to add a new parameter. This can cause doubts.
>>> PSL team has confirmed that enabling traces has no impact.
>>> Do you see any reason to disable the traces ?
>>=20
>> Traces on PSL follow a 'set and fetch' model. So once the trace buffer f=
or
>> a specific array is full it will stop and switch to 'FIN' state and at
>> that point we need to fetch the trace-data and reinit the array to
>> re-arm it.
>
> If the PSL trace arrays don't wrap, is there anything to gain by=20
> enabling tracing by default instead of letting the developer handle it=20
> through sysfs? I was under the (now wrong) impression that the PSL would=
=20
> wrap.
Enabling the traces quickly enough should let AFU developers debug init
issues. Specifically AFU's that rely on cxl kernel-apis.

> I'm not a big fan of the module parameter. It seems we're giving a=20
> second way of activating traces on top of sysfs, more cumbersome and=20
> limited.
Yes, this indeed is providing a second way of activating traces on top
of sysfs. The way I see this that there are two ways PSL traces are
managed:

1. Let userspace handle state machine of the traces entirely via sysfs.
2. PSL trace machine is handled via cxl. It starts it when a card is
probed and stops it when the card is reset.

--=20
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
