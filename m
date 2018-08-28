Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420P572GNjzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:46:50 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7SMi62Z000574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 18:46:48 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m5d93ck48-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 18:46:48 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 28 Aug 2018 18:46:47 -0400
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
To: Li Yang <leoyang.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-soc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, David Brown <david.brown@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Zhao Qiang <qiang.zhao@nxp.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
 <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
 <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 28 Aug 2018 15:46:40 -0700
MIME-Version: 1.0
In-Reply-To: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <9587f8a2-3130-033c-6394-9110b0d399da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/28/2018 03:29 PM, Li Yang wrote:
> On Tue, Aug 28, 2018 at 5:16 PM Tyrel Datwyler
> <tyreld@linux.vnet.ibm.com> wrote:
>>
>> On 08/28/2018 11:48 AM, Li Yang wrote:
>>> On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> In preparation to remove the node name pointer from struct device_node,
>>>> convert printf users to use the %pOFn format specifier.
>>>
>>> Please forgive my ignorance, but what is this format specifier do
>>> exactly?   I cannot find anything listed in the printf specification
>>> matching this.  Is this something newly introduced?
>>>
>>> Leo
>>>
>>
>> From Documentation/core-api/printk-formats.rst:
> 
> I was trying to find it in the standard c format specifier.  :(
> Thanks a lot for the pointer.
> 

No problem. Its worth a look through. The usual integer types are at the top, but that is followed by the pointer types which the kernel provides quite a few for a variety of things.

>>
>> kobjects
>> --------
>>
>> ::
>>
>>         %pOF[fnpPcCF]
>>
>>
>> For printing kobject based structs (device nodes). Default behaviour is
>> equivalent to %pOFf.
>>
>>         - f - device node full_name
>>         - n - device node name
>>         - p - device node phandle
>>         - P - device node path spec (name + @unit)
>>         - F - device node flags
>>         - c - major compatible string
>>         - C - full compatible string
>>
>>
>> -Tyrel
>>
> 
