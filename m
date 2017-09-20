Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxySZ433VzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:39:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [mainline][DLPAR][Oops] OF: ERROR: Bad of_node_put() on /cpus
In-Reply-To: <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
References: <1505473476.9665.13.camel@abdul.in.ibm.com>
 <CAL_JsqLXpU3kr7bD0NYZhYBbzxmGzqPL3j0jfLLMpSmXwPGvOw@mail.gmail.com>
Date: Wed, 20 Sep 2017 21:39:05 +1000
Message-ID: <87bmm5lhuu.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:

> On Fri, Sep 15, 2017 at 6:04 AM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
>> Hi,
>>
>> Mainline kernel panics during DLPAR CPU add/remove operation.
>>
>> Machine Type: Power8 PowerVM LPAR
>> kernel 4.13.0
>
> Did 4.12 work or when was it last working? I'm not seeing anything
> recent in the DT code that looks suspicious.

I'm pretty sure it's:

int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
{
	int rc;

	dn->parent = parent;

	rc = of_attach_node(dn);
	if (rc) {
		printk(KERN_ERR "Failed to add device node %pOF\n", dn);
		return rc;
	}

	of_node_put(dn->parent);
HERE    ^^^^^^^^^^

	return 0;
}


Prior to 215ee763f8cb ("powerpc: pseries: remove dlpar_attach_node
dependency on full path"), we re-looked up the parent, and got another
reference on it. That meant the put before the return there was correct.
But now it's not because the caller has a reference to parent but it's
not ours to drop.

Testing a fix, will report back.

cheers
