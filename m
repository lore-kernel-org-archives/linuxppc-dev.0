Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8WbQ070RzDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 06:05:53 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0QIwdmn127813
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 14:05:52 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2870k51np9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 14:05:51 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Thu, 26 Jan 2017 12:05:50 -0700
Subject: Re: [PATCH net 1/5] ibmvnic: harden interrupt handler
To: Stephen Hemminger <stephen@networkplumber.org>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20170126102802.4f920418@xeon-e3>
Cc: netdev@vger.kernel.org, wvoigt@us.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Thu, 26 Jan 2017 13:05:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170126102802.4f920418@xeon-e3>
Content-Type: text/plain; charset=windows-1252
Message-Id: <b6646479-b370-b19b-48e2-27e20f67a31a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2017 12:28 PM, Stephen Hemminger wrote:
> On Wed, 25 Jan 2017 15:02:19 -0600
> Thomas Falcon <tlfalcon@linux.vnet.ibm.com> wrote:
>
>>  static irqreturn_t ibmvnic_interrupt(int irq, void *instance)
>>  {
>>  	struct ibmvnic_adapter *adapter = instance;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&adapter->crq.lock, flags);
>> +	vio_disable_interrupts(adapter->vdev);
>> +	tasklet_schedule(&adapter->tasklet);
>> +	spin_unlock_irqrestore(&adapter->crq.lock, flags);
>> +	return IRQ_HANDLED;
>> +}
>> +
> Why not use NAPI? rather than a tasklet
>
This interrupt function doesn't process packets, but message passing between firmware and driver for determining device capabilities and available resources, such as the number TX and RX queues. 
