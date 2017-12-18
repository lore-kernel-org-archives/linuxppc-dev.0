Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0qjM1pT1zDrW7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 05:45:26 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIIicBn092552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 13:45:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exk7d819n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 13:45:23 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 11:45:23 -0700
Subject: Re: [PATCH v1 2/7] powerpc/kernel: Add uevents in EEH error/resume
To: Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
 <79cea2a4-510d-37b5-0892-c87ffd0221b4@ozlabs.ru>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 12:45:15 -0600
MIME-Version: 1.0
In-Reply-To: <79cea2a4-510d-37b5-0892-c87ffd0221b4@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <f316a133-6548-4ad2-1560-98c9d7b8f7f9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12/17/17 9:54 PM, Alexey Kardashevskiy wrote:

> On 14/12/17 02:32, Bryant G. Ly wrote:
>> Devices can go offline when EEH is reported. This patch adds
>> a change to the kernel object and lets udev know of error.
>> When device resumes a change is also set reporting device as
>> online. Therefore, EEH events are better propagated to user
>> space for devices in powerpc arch.
>>
>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index 3c0fa99c5533..c61bf770282b 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -204,6 +204,7 @@ static void *eeh_report_error(void *data, void *userdata)
>>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>>  	enum pci_ers_result rc, *res = userdata;
>>  	struct pci_driver *driver;
>> +	char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};
> scripts/checkpatch.pl:
>
> WARNING: char * array declaration might be better as static const
> #27: FILE: arch/powerpc/kernel/eeh_driver.c:207:
> +       char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};
>
>
>
>>  
>>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>>  		return NULL;
>> @@ -228,6 +229,7 @@ static void *eeh_report_error(void *data, void *userdata)
>>  
>>  	edev->in_error = true;
>>  	eeh_pcid_put(dev);
>> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>>  	return NULL;
>>  }
>>  
>> @@ -358,6 +360,7 @@ static void *eeh_report_resume(void *data, void *userdata)
>>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>>  	bool was_in_error;
>>  	struct pci_driver *driver;
>> +	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
>
> WARNING: char * array declaration might be better as static const
> #43: FILE: arch/powerpc/kernel/eeh_driver.c:363:
> +       char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
>
>
>
Checkpatch is wrong it doesn't check the function that uses it, which only takes a char *

-Bryant
