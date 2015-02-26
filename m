Return-Path: <jiri@resnulli.us>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
 [74.125.82.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85FDA1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 02:55:19 +1100 (AEDT)
Received: by wevk48 with SMTP id k48so12128275wev.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 07:55:16 -0800 (PST)
Date: Thu, 26 Feb 2015 16:55:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibmveth: Add function to enable live MAC address changes
Message-ID: <20150226155512.GG1973@nanopsycho.lan>
References: <1424910864-32266-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <54EF1AB6.5010004@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54EF1AB6.5010004@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thu, Feb 26, 2015 at 02:08:06PM CET, brking@linux.vnet.ibm.com wrote:
>On 02/25/2015 06:34 PM, Thomas Falcon wrote:
>> @@ -1327,6 +1327,24 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>>  	return ret;
>>  }
>> 
>> +static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>> +{
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	struct sockaddr *addr = p;
>> +	u64 mac_address;
>> +	int rc;
>> +
>> +	if (!is_valid_ether_addr(addr->sa_data))
>> +		return -EADDRNOTAVAIL;
>> +
>> +	ether_addr_copy(dev->dev_addr, addr->sa_data);
>> +
>> +	mac_address = ibmveth_encode_mac_addr(dev->dev_addr);
>> +	rc = h_change_logical_lan_mac(adapter->vdev->unit_address, mac_address);
>> +
>> +	return rc;
>
>Do you still want to be changing dev->dev_addr if h_change_logical_lan_mac
>returns a failure?

That should not be done. dev_addr should be in sync with real hw addr.
