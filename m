Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D55B1A0479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 00:51:43 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 09:51:39 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C48AAC90042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 09:39:47 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RDpaHC50659330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 13:51:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RDpaGo031798
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 09:51:36 -0400
Subject: Re: [PATCH] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <562E7FF1.1040806@linux.vnet.ibm.com>
 <1445933855.6332.13.camel@linux.intel.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <562F8167.4000302@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 08:51:35 -0500
MIME-Version: 1.0
In-Reply-To: <1445933855.6332.13.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/2015 03:17 AM, Andy Shevchenko wrote:
> On Mon, 2015-10-26 at 14:33 -0500, Nathan Fontenot wrote:
>> Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed made a change to use
>> kstrndup() instead of kmalloc() + strlcpy() in
>> pseries_of_derive_parent()
>> which introduces a subtle change in the parent path name generated.
>> The kstrndup() routine will copy n characters followed by a
>> terminating null,
>> whereas strlcpy() will copy n-1 characters and add a terminating
>> null.
> 
> Nice catch!
> One comment below.
> 
>>
>> This slight difference results in having a parent path that includes
>> the
>> trailing '/' character, i.e. "/cpus/" vs. "/cpus". This then causes
>> the
>> subsequent call to of_find_node_by_path() to fail, and in the case of
>> DLPAR add operations, the DLPAR request fails.
>>
>> This patch reduces the total length of the string to copy in kstrndup
>> by 1
>> so we no longer copy the trailing '/'.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/of_helpers.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c
>> b/arch/powerpc/platforms/pseries/of_helpers.c
>> index 4417afe..6d90378 100644
>> --- a/arch/powerpc/platforms/pseries/of_helpers.c
>> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
>> @@ -24,7 +24,7 @@ struct device_node *pseries_of_derive_parent(const
>> char *path)
>>  		return ERR_PTR(-EINVAL);
>>  
>>  	if (tail > path + 1) {
>> -		parent_path = kstrndup(path, tail - path,
>> GFP_KERNEL);
>> +		parent_path = kstrndup(path, (tail - 1) - path,
>> GFP_KERNEL);
> 
> Since  previous line has (tail > path + 1) which is equivalent to (tail
> - 1 > path), can we amend both?
> 
> For example (might be better, but first comes to my mind)
> 
> const char *tail = kbasename(path) - 1;

Agreed. I'll send out a v2 of the patch with this update and add a comment
to indicate we do not want to include the trailing '\' character.

-Nathan

> 
> ...
> 
> if (tail > path) {
> 
> 
>>  		if (!parent_path)
>>  			return ERR_PTR(-ENOMEM);
>>  	}
>>
> 
