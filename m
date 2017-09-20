Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy65V3fswzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 03:23:09 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8KHJqr4034856
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:23:06 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3s8mxedx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:23:06 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 11:23:05 -0600
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
 abdul <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
 <87bmm5lhuu.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 10:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <87bmm5lhuu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <3c15ac5c-c966-be45-1a6c-ba3fa1b9e439@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/20/2017 04:39 AM, Michael Ellerman wrote:
> Rob Herring <robh@kernel.org> writes:
> 
>> On Fri, Sep 15, 2017 at 6:04 AM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
>>> Hi,
>>>
>>> Mainline kernel panics during DLPAR CPU add/remove operation.
>>>
>>> Machine Type: Power8 PowerVM LPAR
>>> kernel 4.13.0
>>
>> Did 4.12 work or when was it last working? I'm not seeing anything
>> recent in the DT code that looks suspicious.
> 
> I'm pretty sure it's:
> 
> int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
> {
> 	int rc;
> 
> 	dn->parent = parent;
> 
> 	rc = of_attach_node(dn);
> 	if (rc) {
> 		printk(KERN_ERR "Failed to add device node %pOF\n", dn);
> 		return rc;
> 	}
> 
> 	of_node_put(dn->parent);
> HERE    ^^^^^^^^^^
> 
> 	return 0;
> }
> 
> 
> Prior to 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node
> dependency on full path"), we re-looked up the parent, and got another
> reference on it. That meant the put before the return there was correct.
> But now it's not because the caller has a reference to parent but it's
> not ours to drop.
> 
> Testing a fix, will report back.

So, that patch slipped past me. Not only is the parent reference not ours to drop, but
when I went and looked at dlpar_cpu_add() I also noticed that of_node_put() was done on
the parent prior to the call to dlpar_attach_node(). With the addition of "parent" to the
dlpar_attach_node() parameter list dlpar_cpu_add() needs to be fixed up to hold the
"parent" reference until after dlpar_attach_node() returns.

-Tyrel

> 
> cheers
> 
