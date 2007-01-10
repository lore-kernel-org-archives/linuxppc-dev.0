Return-Path: <ahuja@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61136DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:58:46 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0AKwgqp001086
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 15:58:42 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0AKwgRW519300
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 13:58:42 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0AKwgOp012489
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 13:58:42 -0700
Message-ID: <45A55380.9020402@austin.ibm.com>
Date: Wed, 10 Jan 2007 14:58:40 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<20070109150519.GD8122@localdomain>
In-Reply-To: <20070109150519.GD8122@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Paul Mackerras wrote:
>   
>> Manish Ahuja writes:
>>
>>     
>>> During power outages, the ups notifies the system for a shutdown. In the 
>>> current setup, it isn't possible to power on when power is restored. 
>>> This patch fixes the issue by calling the right ibm,power-off-ups token 
>>> during such events. It also adds a proc interface so that rc.powerfail 
>>> can parse the epow events and modify the power-off behavior accordingly 
>>> to enable the right token to be called.
>>>       
>> Creating new non-process-related files in /proc is frowned upon these
>> days, so we'll have to find somewhere in /sys for this.  Anybody got a
>> suggestion?
>>     
>
> Maybe a sysctl instead?
>   
Wouldn't sysctl be /proc/sys/something again.

I did look under /sys but couldn't come up with a location to create 
this new file.

Although creating new files under /proc is frowned upon, the subset of 
files in the directory
seemed similar in functionality and connected to the new file I was 
creating and hence this new file in
/proc/ppc64/rtas.

linux:/proc/ppc64/rtas # ls -x
.         ..          clock    error_log  frequency  poweron  poweron_auto
progress  rmo_buffer  sensors  volume

I don't mind creating a /sys entry if anyone has a good suggestion.
