Return-Path: <glikely@secretlab.ca>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 689231A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 13:58:25 +1000 (EST)
Received: by mail-ig0-f182.google.com with SMTP id c1so427402igq.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 20:58:22 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <53BEF099.5020705@linux.vnet.ibm.com>
References: <1405018257-35616-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <53BEF099.5020705@linux.vnet.ibm.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 15 Jul 2014 21:58:02 -0600
Message-ID: <CACxGe6uGf3NKsxK9HPYRxPyKfVbR4GYkp5-zkRHN3GRuoqu3Nw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/pseries: dynamically added OF nodes need to
 call of_node_init
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, stable <stable@vger.kernel.org>,
 mdroth@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2014 at 1:59 PM, Nathan Fontenot
<nfont@linux.vnet.ibm.com> wrote:
> On 07/10/2014 01:50 PM, Tyrel Datwyler wrote:
>> Commit 75b57ecf9 refactored device tree nodes to use kobjects such that they
>> can be exposed via /sysfs. A secondary commit 0829f6d1f furthered this rework
>> by moving the kobect initialization logic out of of_node_add into its own
>> of_node_init function. The inital commit removed the existing kref_init calls
>> in the pseries dlpar code with the assumption kobject initialization would
>> occur in of_node_add. The second commit had the side effect of triggering a
>> BUG_ON during DLPAR, migration and suspend/resume operations as a result of
>> dynamically added nodes being uninitialized.
>>
>> This patch fixes this by adding of_node_init calls in place of the previously
>> removed kref_init calls.
>>
>> Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>
> Acked-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Acked-by: Grant Likely <grant.likely@linaro.org>

Ben, are you going to take this or should I take it via my tree?

g.

>
>> ---
>> V2:
>>  - included stable kernel list on Cc per comment by mpe
>>
>>  arch/powerpc/platforms/pseries/dlpar.c    | 1 +
>>  arch/powerpc/platforms/pseries/reconfig.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index 022b38e..2d0b4d6 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -86,6 +86,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
>>       }
>>
>>       of_node_set_flag(dn, OF_DYNAMIC);
>> +     of_node_init(dn);
>>
>>       return dn;
>>  }
>> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
>> index 0435bb6..1c0a60d 100644
>> --- a/arch/powerpc/platforms/pseries/reconfig.c
>> +++ b/arch/powerpc/platforms/pseries/reconfig.c
>> @@ -69,6 +69,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
>>
>>       np->properties = proplist;
>>       of_node_set_flag(np, OF_DYNAMIC);
>> +     of_node_init(np);
>>
>>       np->parent = derive_parent(path);
>>       if (IS_ERR(np->parent)) {
>>
>
