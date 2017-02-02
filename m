Return-Path: <honclo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDS4w4LxlzDqGw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:41:36 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v124ccdw134100
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 23:41:34 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bburgpex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 23:41:34 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <honclo@linux.vnet.ibm.com>;
 Thu, 2 Feb 2017 14:41:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EA8F12CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:41:29 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v124fLW926411196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:41:29 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v124euZu005761
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:40:57 +1100
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: ibmvtpm byteswapping inconsistency
From: Vicky <honclo@linux.vnet.ibm.com>
In-Reply-To: <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
Date: Wed, 1 Feb 2017 23:40:33 -0500
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Michal Such??nek <msuchanek@suse.de>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
 <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
To: Ashley Lai <ashleydlai@gmail.com>
Message-Id: <F14AC3E9-E04F-4EF0-9C7E-999D481EA577@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Jan 26, 2017, at 5:58 PM, Ashley Lai <ashleydlai@gmail.com> wrote:
>=20
> Adding Vicky from IBM.
>=20
>=20
> On 01/26/2017 04:05 PM, Jason Gunthorpe wrote:
>> On Thu, Jan 26, 2017 at 09:22:48PM +0100, Michal Such??nek wrote:
>>=20
>>> This is repeated a few times in the driver so I added memset to =
quiet
>>> gcc and make behavior deterministic in case the unused fields get =
some
>>> meaning in the future.
>> Yep, reserved certainly needs to be zeroed.. Can you send a patch?
>> memset is overkill...
>>=20
>>> However, in tpm_ibmvtpm_send the structure is initialized as
>>>=20
>>> 	struct ibmvtpm_crq crq;
>>>         __be64 *word =3D (__be64 *)&crq;
>>> ...
>>>         crq.valid =3D (u8)IBMVTPM_VALID_CMD;
>>>         crq.msg =3D (u8)VTPM_TPM_COMMAND;
>>>         crq.len =3D cpu_to_be16(count);
>>>         crq.data =3D cpu_to_be32(ibmvtpm->rtce_dma_handle);
>>>=20
>>> and submitted with
>>>=20
>>> 	rc =3D ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>>>                               be64_to_cpu(word[1]));
>>> meaning it is swapped twice.
>> No idea, Nayna may know.
>>=20
>> My guess is that '__be64 *word' should be 'u64 *word'...
>>=20
>> Jason
>=20

I don=92t think we want =91word' to be changed back to be of type =91u64=92=
.   Please see commit 62dfd912ab3b5405b6fe72d0135c37e9648071f1


Vicky=
