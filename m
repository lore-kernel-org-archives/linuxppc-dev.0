Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DA781A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 15:40:56 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 28 Dec 2015 14:40:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D8FD42CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 15:40:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBS4eFNE31916176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 15:40:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBS4eB8T012284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 15:40:11 +1100
Message-ID: <5680BD18.1070408@linux.vnet.ibm.com>
Date: Mon, 28 Dec 2015 10:09:52 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: lvivier@redhat.com, thuth@redhat.com, paulus@samba.org,
 bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 0/3] Prototype PAPR hash page table resizing (guest side)
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <567BB96D.6050504@linux.vnet.ibm.com> <20151224103844.GB3011@voom.redhat.com>
In-Reply-To: <20151224103844.GB3011@voom.redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2015 04:08 PM, David Gibson wrote:
> On Thu, Dec 24, 2015 at 02:52:53PM +0530, Anshuman Khandual wrote:
>> > On 12/22/2015 10:44 AM, David Gibson wrote:
>>> > > I've discussed with Paul and Ben previously the possibility of
>>> > > extending PAPR to allow changing the size of a running guest's hash
>>> > > page table (HPT).  This would allow for much more flexible memory
>>> > > hotplug, since the HPT wouldn't have to be sized in advance for the
>>> > > maximum possible memory size of the guest.
>> > 
>> > Does it include reducing the size of HPT as well ?
> It does, but that could fail with H_PTEG_FULL if there's a collision
> between bolted entries in the reduced table.

So in the case when we request for a reduced size HPT table, as mentioned
in the second implementation method, will we allocate the required smaller
HPT table to shadow the original or we just reduce the original HPT in
size without allocating a new one ?
