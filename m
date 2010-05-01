Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C7D1B7D2F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 19:54:17 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o419oIB1021022
	for <linuxppc-dev@ozlabs.org>; Sat, 1 May 2010 19:50:18 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o419lRPu1646798
	for <linuxppc-dev@ozlabs.org>; Sat, 1 May 2010 19:47:28 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o419sF5K027311
	for <linuxppc-dev@ozlabs.org>; Sat, 1 May 2010 19:54:16 +1000
Message-ID: <4BDBFA44.5080203@in.ibm.com>
Date: Sat, 01 May 2010 15:24:12 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: -next Apr 30: OOPS during eHEA driver initialization
References: <4BDAF376.4030005@in.ibm.com> <4BDB12FB.5060806@in.ibm.com>
	<n2kfa686aa41004301035p7e15c017u7a1b98389cc1e466@mail.gmail.com>
	<g2mfa686aa41004301043i138ffb2dmac5b641fa3d512c4@mail.gmail.com>
In-Reply-To: <g2mfa686aa41004301043i138ffb2dmac5b641fa3d512c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Apr 30, 2010 at 11:35 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>   
>> On Fri, Apr 30, 2010 at 11:27 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
>>     
>>> Sachin Sant wrote:
>>>       
>>>> With today's next eHEA drivers fails to initialize.
>>>>         
>>> If i revert the following patch eHEA network interface is initialized
>>> properly.
>>>
>>> commit cebfe0b6709abdab997c1a00499d67efa32ee1f0
>>> drivercore: Add of_match_table to the common device drivers
>>>       
>> That is an easy one to fix.  I'll get it updated today and send you the result.
>>     
>
> Let me know if this patch fixes it:
>   
Works for me. Thanks Grant. 

Tested-by : Sachin Sant <sachinp@in.ibm.com>

Regards
-Sachin


> Cheers,
> g.
>
> diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
> index ce957a4..693b0e6 100644
> --- a/arch/powerpc/kernel/ibmebus.c
> +++ b/arch/powerpc/kernel/ibmebus.c
> @@ -201,6 +201,9 @@ static int ibmebus_create_devices(const struct
> of_device_id *matches)
>
>  int ibmebus_register_driver(struct of_platform_driver *drv)
>  {
> +	if (!drv->driver.of_match_table)
> +		drv->driver.of_match_table = drv->match_table;
> +
>  	/* If the driver uses devices that ibmebus doesn't know, add them */
>  	ibmebus_create_devices(drv->driver.of_match_table);
>
>
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
