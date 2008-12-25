Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 73224DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 15:53:31 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-71.bayarea.dialup.o1.com [66.81.71.71])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mBP4pn2U067781
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 20:53:19 -0800 (PST)
Message-ID: <49531092.6060209@hypersurf.com>
Date: Wed, 24 Dec 2008 20:48:18 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: schizophrenic G5 ...
References: <494EDB3F.4090604@hypersurf.com>
In-Reply-To: <494EDB3F.4090604@hypersurf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs wrote:
> Hi,
> 
>     I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has YDL 6.0 
> on it. Using the stock YDL 2.6.23 kernel this machine "appears" to work 
> fine.
> 
>     After finally getting it to boot under 2.6.27, it will shut itself 
> off if put under any significant load. And it is doing it very quickly. 
> Like within a few seconds of becoming busy. I just discovered it is 
> spitting out messages about "temperature way above maximum" (from 
> therm_pm72.c).
> 
>     This one has the Panasonic cooling system. I have checked behind the 
> cover and see no evidence of leaks.
> 
>     When put under load under the stock YDL kernel, the cpu fans will 
> speed up for about 2 minutes. Then over the next minute or so they will 
> slow down almost to idle. Thereafter a whirring sound can be heard every 
> 15 to 30 seconds lasting about 5 seconds. Which I am guessing is the 
> pump? The exhaust air barely gets warm?
> 
> 

If I run:

while true; do
	echo -n "cpu0\:  "; cat cpu0_temperature;
	echo -ne "\t"; cat cpu0_current; echo "";
	echo -n "cpu1\:  "; cat cpu1_temperature;
	echo -ne "\t"; cat cpu1_current;
	echo ""; sleep 1;
done

in one window and:

time /home/kevdig//r-970 -b4 -s1|nice -19 bzip2 -9v|dd bs=4b
count=400000 of=/dev/null

in two others I see different results between 2.6.23 and 2.6.27. Under 
the stock YDL 6.0 2.6.23 kernel, the temperatures level off at 50 and 
70. Peak temps are about 56 and 76. Idle temps are about 46 and 54.

Under 2.6.27, if I run ONE I see cpu1 temps range from 74 -> 89 -> 105
-> 111 -> 86. All one second apart. This happened pretty fast. Once I 
saw the 111 I ^c'ed the process. Can the temp really change that fast?

kevin
