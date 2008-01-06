Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5532ADDE23
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 07:40:48 +1100 (EST)
Message-ID: <47813C94.10505@am.sony.com>
Date: Sun, 06 Jan 2008 12:39:48 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 2/3] PS3: Add logical performance monitor device support
References: <20080105003019.595703814@am.sony.com>
	<477EF5AC.7090105@am.sony.com> <200801051229.33099.arnd@arndb.de>
In-Reply-To: <200801051229.33099.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01/05/2008 03:29 AM, Arnd Bergmann wrote:
> On Saturday 05 January 2008, Geoff Levand wrote:
>> +       struct layout {
>> +               struct ps3_system_bus_device dev;
>> +       } *p;
> 
> What's the point of this data structure? You don't use the
> struct anywhere, and it only has one member, so you could
> just declare that directly.

Yes, this code was just cut and pasted from a device that
had more members.

>> +       if (tmp1 != tmp2) {
>> +               pr_debug("%s:%d: wrong lpar\n",
>> +                       __func__, __LINE__);
>> +               result = -1;
>> +               goto fail_rights;
>> +       }
>> +
>> +       if (!(p->dev.lpm.rights & PS3_LPM_RIGHTS_USE_LPM)) {
>> +               pr_debug("%s:%d: don't have rights to use lpm\n",
>> +                       __func__, __LINE__);
>> +               result = -1;
>> +               goto fail_rights;
>> +       }
>> +
> 
> I think __init functions should return error codes like -EPERM or
> -EINVAL, not numeric -1.

I'll fix it in the next post.

-Geoff
