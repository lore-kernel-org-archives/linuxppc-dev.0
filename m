Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7n8P2NVgzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 15:13:41 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id h41so12086462ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:13:41 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com> <58F83C66.7030806@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, rostedt@goodmis.org,
 mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F84369.3080304@gmail.com>
Date: Wed, 19 Apr 2017 22:13:13 -0700
MIME-Version: 1.0
In-Reply-To: <58F83C66.7030806@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/17 21:43, Frank Rowand wrote:
> On 04/19/17 16:27, Tyrel Datwyler wrote:
>> On 04/18/2017 06:31 PM, Michael Ellerman wrote:

< snip >

>>
>> To get that same info as far as I know is to add a dump_stack() after
>> each pr_debug.
> 
> Here is a patch that I have used.  It is not as user friendly in terms
> of human readable stack traces (though a very small user space program
> should be able to fix that).  The patch is cut and pasted into this
> email, so probably white space damaged.

< snip >

> +
> +	if (node) {
> +		int k;
> +		int refcount = refcount_read(&node->kobj.kref.refcount);
> +		pr_err("XXX get 0x%p %3d [0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx] ",
> +			node, refcount,

If this was a real patch, meant for people other than myself, the
pr_err() would instead be pr_debug().

-Frank

< snip >
