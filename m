Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 329B11A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:52:42 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 18:52:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 43D882BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:52:38 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u118qUml61931576
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:52:38 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u118q5ko025199
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:52:05 +1100
Message-ID: <56AF1CA2.30603@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 14:21:46 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 9/9] pseries: Automatically resize HPT for memory hot
 add/remove
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-10-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-10-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:54 AM, David Gibson wrote:
>  #ifdef CONFIG_MEMORY_HOTPLUG
> +void resize_hpt_for_hotplug(unsigned long new_mem_size)
> +{
> +	unsigned target_hpt_shift;
> +
> +	if (!ppc_md.resize_hpt)
> +		return;
> +
> +	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
> +
> +	/*
> +	 * To avoid lots of HPT resizes if memory size is fluctuating
> +	 * across a boundary, we deliberately have some hysterisis


What do you mean by 'memory size is fluctuating across a boundary' ?
Through memory hotplug interface ? Why some one will do that ? I
can understand why we dont have this check in the sysfs debug path
as we would like to test any memory HPT re sizing scenario we want
in any sequence of increase or decrease we want.

Overall the RFC V2 looks pretty good. Looking forward to see the
host side of the code for this feature.
