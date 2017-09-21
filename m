Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyX8S3db0zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 19:57:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
 abdul <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
In-Reply-To: <3c15ac5c-c966-be45-1a6c-ba3fa1b9e439@linux.vnet.ibm.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
 <87bmm5lhuu.fsf@concordia.ellerman.id.au>
 <3c15ac5c-c966-be45-1a6c-ba3fa1b9e439@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 19:57:11 +1000
Message-ID: <87fubgcr2g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 09/20/2017 04:39 AM, Michael Ellerman wrote:
>> Rob Herring <robh@kernel.org> writes:
>>> On Fri, Sep 15, 2017 at 6:04 AM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
>>>>
>>>> Mainline kernel panics during DLPAR CPU add/remove operation.
>>>>
>>>> Machine Type: Power8 PowerVM LPAR
>>>> kernel 4.13.0
>>>
>>> Did 4.12 work or when was it last working? I'm not seeing anything
>>> recent in the DT code that looks suspicious.
>> 
>> I'm pretty sure it's:
>> 
>> int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
>> {
>> 	int rc;
>> 
>> 	dn->parent = parent;
>> 
>> 	rc = of_attach_node(dn);
>> 	if (rc) {
>> 		printk(KERN_ERR "Failed to add device node %pOF\n", dn);
>> 		return rc;
>> 	}
>> 
>> 	of_node_put(dn->parent);
>> HERE    ^^^^^^^^^^
>> 
>> 	return 0;
>> }
>> 
>> 
>> Prior to 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node
>> dependency on full path"), we re-looked up the parent, and got another
>> reference on it. That meant the put before the return there was correct.
>> But now it's not because the caller has a reference to parent but it's
>> not ours to drop.
>> 
>> Testing a fix, will report back.
>
> So, that patch slipped past me. Not only is the parent reference not ours to drop, but
> when I went and looked at dlpar_cpu_add() I also noticed that of_node_put() was done on
> the parent prior to the call to dlpar_attach_node(). With the addition of "parent" to the
> dlpar_attach_node() parameter list dlpar_cpu_add() needs to be fixed up to hold the
> "parent" reference until after dlpar_attach_node() returns.

Yep. I wrote the same patch :)

Rob asked me to test it, which I did, but /cpus starts out with an
elevated ref count, so you have to do ~30 (on my system) DLPAR removes
to hit the bug, which I didn't do.

I've updated my test script to do roughly $(nproc) x 10 DLPAR removes,
which is hopefully sufficient to catch these bugs in future.

cheers
