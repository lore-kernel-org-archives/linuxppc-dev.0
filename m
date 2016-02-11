Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2A571A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 18:32:41 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A9ACE140B8C
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:32:41 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 11 Feb 2016 17:32:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 585662BB0045
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:32:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B7WPwE54263822
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:32:33 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B7W56u003029
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2016 18:32:05 +1100
Subject: Re: [PATCH V2 1/2] powerpc/powernv: new function to access OPAL msglog
To: Joel Stanley <joel@jms.id.au>
References: <1455002269-26543-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <CACPK8Xcfi+8XAR3WxvP6qJ7YjSBprZNcMzKrtiaABgoGw015gw@mail.gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56BC38DC.9090301@au1.ibm.com>
Date: Thu, 11 Feb 2016 18:31:40 +1100
MIME-Version: 1.0
In-Reply-To: <CACPK8Xcfi+8XAR3WxvP6qJ7YjSBprZNcMzKrtiaABgoGw015gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/02/16 18:14, Joel Stanley wrote:
> Looks like you didn't break it much. Congratulations on being the new
> memcons maintainer!

Argh, I forgot the golden rule of kernel development - if you touch it, 
you own it... :)

> There's one issue with your error handling.
>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 4e0da5a..0256d07 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -724,6 +724,9 @@ static int __init opal_init(void)
>>                  of_node_put(leds);
>>          }
>>
>> +       /* Initialise OPAL message log interface */
>> +       opal_msglog_init();
>
> If this fails due to eg. the magic number being wrong.
>
>> +
>>          /* Create "opal" kobject under /sys/firmware */
>>          rc = opal_sysfs_init();
>>          if (rc == 0) {
>> @@ -739,8 +742,8 @@ static int __init opal_init(void)
>>                  opal_platform_dump_init();
>>                  /* Setup system parameters interface */
>>                  opal_sys_param_init();
>> -               /* Setup message log interface. */
>> -               opal_msglog_init();
>> +               /* Setup message log sysfs interface. */
>> +               opal_msglog_sysfs_init();
>
> This will succeed, leaving you with a sysfs file attached to a broken driver.

V3 on its way...

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
