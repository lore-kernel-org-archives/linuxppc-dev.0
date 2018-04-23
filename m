Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VJtD0Rt3zDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 07:06:43 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3NL2pm2145957
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 17:06:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hhjh6451b-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 17:06:40 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 15:06:40 -0600
Subject: Re: [PATCH v1 1/1] misc: IBM Virtual Management Channel Driver
To: Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, arnd@arndb.de,
 corbet@lwn.net, seroyer@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 davem@davemloft.net, linus.walleij@linaro.org,
 akpm@linux-foundation.org, mikey@neuling.org, pombredanne@nexb.com,
 tlfalcon@linux.vnet.ibm.com, msuchanek@suse.de,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1524494812-60150-1-git-send-email-bryantly@linux.vnet.ibm.com>
 <1524494812-60150-2-git-send-email-bryantly@linux.vnet.ibm.com>
 <c07b14b7-8f34-2ba5-536f-85896ff21661@infradead.org>
 <20180423195310.GA10693@kroah.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 16:06:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180423195310.GA10693@kroah.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <07085611-6f6f-f3ac-41aa-272519304859@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/23/18 2:53 PM, Greg KH wrote:

> On Mon, Apr 23, 2018 at 11:38:18AM -0700, Randy Dunlap wrote:
>> On 04/23/18 07:46, Bryant G. Ly wrote:
>>> This driver is a logical device which provides an
>>> interface between the hypervisor and a management
>>> partition.
>>>
>>> This driver is to be used for the POWER Virtual
>>> Management Channel Virtual Adapter on the PowerVM
>>> platform. It provides both request/response and
>>> async message support through the /dev/ibmvmc node.
>>>
>>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>>> Reviewed-by: Steven Royer <seroyer@linux.vnet.ibm.com>
>>> Reviewed-by: Adam Reznechek <adreznec@linux.vnet.ibm.com>
>>> Tested-by: Taylor Jakobson <tjakobs@us.ibm.com>
>>> Tested-by: Brad Warrum <bwarrum@us.ibm.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>  Documentation/ioctl/ioctl-number.txt  |    1 +
>>>  Documentation/misc-devices/ibmvmc.txt |  161 +++
>>>  MAINTAINERS                           |    6 +
>>>  arch/powerpc/include/asm/hvcall.h     |    1 +
>>>  drivers/misc/Kconfig                  |   14 +
>>>  drivers/misc/Makefile                 |    1 +
>>>  drivers/misc/ibmvmc.c                 | 2415 +++++++++++++++++++++++++++++++++
>>>  drivers/misc/ibmvmc.h                 |  209 +++
>>>  8 files changed, 2808 insertions(+)
>>>  create mode 100644 Documentation/misc-devices/ibmvmc.txt
>>>  create mode 100644 drivers/misc/ibmvmc.c
>>>  create mode 100644 drivers/misc/ibmvmc.h
>>> diff --git a/Documentation/misc-devices/ibmvmc.txt b/Documentation/misc-devices/ibmvmc.txt
>>> new file mode 100644
>>> index 0000000..bae1064
>>> --- /dev/null
>>> +++ b/Documentation/misc-devices/ibmvmc.txt
> Aren't we doing new documentation in .rst format instead of .txt?
>
> thanks,
>
> greg k-h
>
I will convert to .rst and fix the comments from Randy in the next version.

Thanks, 

Bryant
