Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A82F467B79
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 01:41:32 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7IFfRBd093752
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:41:27 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IFhLHD131946
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:43:21 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IFfRtC018272
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:41:27 +0100
Message-ID: <44E5DFA6.7040707@de.ibm.com>
Date: Fri, 18 Aug 2006 17:41:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com>
	<20060818140506.GC5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818140506.GC5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Alexey,

first of all thanks a lot for the extensive review.


Alexey Dobriyan wrote:
>> +	u64 hret = H_HARDWARE;
> 
> Useless assignment here and everywhere.
> 

Initializing returncodes to errorstate is a cheap way to prevent
accidentally returning (uninitalized) success returncodes which
can lead to catastrophic misbehaviour.

>> +static void netdev_get_drvinfo(struct net_device *dev,
>> +			       struct ethtool_drvinfo *info)
>> +{
>> +	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
>> +	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
> 
> Use strlcpy() to not forget -1 accidently.

I agree.

Kind regards
Thomas
