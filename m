Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC6282C00F5
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2013 05:05:26 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 19 Mar 2013 14:05:24 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3CB5FC9005C
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:05:22 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2JI5BlH22085784
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:05:12 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2JI5AHS018992
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:05:11 -0400
Message-ID: <5148A8D5.4010608@linux.vnet.ibm.com>
Date: Tue, 19 Mar 2013 13:05:09 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com>
 <20130314085905.GE9841@iris.ozlabs.ibm.com>
In-Reply-To: <20130314085905.GE9841@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2013 03:59 AM, Paul Mackerras wrote:
> On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
>> This patch adds a platform_has_feature() function to check features selected
>> by firmware and reported via the device tree 'ibm,architecture-vec5'
>> property. As part of this the #defines used for the architecture vector are
>> moved to prom.h and re-defined such that the vector 5 options have the vector
>> index and the feature bits encoded into them. This allows for callers of
>> platform_has_feature() to pass in a single pre-defined value.
> 
> One other comment...
> 
>> +#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>> +bool platform_has_feature(unsigned int feature)
>> +{
>> +	struct device_node *chosen;
>> +	const char *vec5;
>> +	bool has_option;
>> +
>> +	chosen = of_find_node_by_path("/chosen");
>> +	if (!chosen)
>> +		return false;
>> +
>> +	vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
>> +	has_option = vec5 && (vec5[OV5_INDX(feature)] & OV5_FEAT(feature));
> 
> You access vec5[index] without checking that the vector is at least
> index+1 bytes long, according to either the length byte at the
> beginning of the vector, or the total length of the property.
> Checking both would be a good idea.
> 

Yep. Thanks for letting me know.

-- 
-Nathan
