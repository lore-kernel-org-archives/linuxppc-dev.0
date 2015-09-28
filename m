Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CAB21A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:56:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 14:56:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A9B4F2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:55:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8S4toEX51118148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:55:58 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8S4tQjI016250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 14:55:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
In-Reply-To: <1443044256.3100.51.camel@kernel.crashing.org>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823285.2819.1.camel@kernel.crashing.org>
 <87mvwgduuj.fsf@linux.vnet.ibm.com>
 <1442833578.11901.2.camel@kernel.crashing.org>
 <878u80gf8q.fsf@linux.vnet.ibm.com>
 <1443044256.3100.51.camel@kernel.crashing.org>
Date: Mon, 28 Sep 2015 10:25:06 +0530
Message-ID: <8737xzi1n9.fsf@linux.vnet.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2015-09-21 at 17:23 +0530, Aneesh Kumar K.V wrote:
>> The page that contain pte entries. Or the last level of the linux page
>> table. or we could call them pte fragments. We need to allocate one
>> full page at lowest level, because we want to use split ptlock. Now
>> for keeping the pte_t entries, we will just be using 2K space. Rest of
>> the space can be reused. We did that in commit 
>> 5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4 . Now all those pmd entries
>> that have pte page (pte fragments) coming from the same 64K page
>> will also end up sharing the same ptlock.
>
> Ok, I'm still a bit confused between what we do today vs. what we do
> after your patch, can you provide a clear description (maybe with
> ASCII art) of what is used, how, an how much is wasted overall when
> not using subpages ?
>




       pmd table             
     +------------+             
     |  pmd entry \              64k linux page
     +------------+\          +-----------------+
     |            | \        /|    pte fragment |
     |            |  \      / |                 |
     |            |   \    /  |    8K size      |
     |            |    \  /   |                 |
     +------------+     \/    +-----------------+
                        /\    |                 |
                       /  \   |                 |
                      /    \  |                 |
                     /      \ |                 |
       pmd table    /        \|                 |
    +--------------/          +-----------------+
    |  pmd entry   |          |                 |
    +--------------+          |    pte fragment |
    |              |          |    8k size      |
    |              |          +-----------------+
    |              |            
    |              |
    +--------------+


Actual size of pte fragment needed to map a 16MB range is 2K.
(2K size consist of 256 entries (2*1024/8 each entry is 8 bytes))
256 * 64K  = 16MB

Now since we also need to track details of 4K subpages, we used to
use pte frag of size 4K. The second half 2K is used to track subpages.
For each 64K we need to track 16 subpages. We took 8 bytes per
each 64K. So we are able to track details of subpages for 16MB range
in 2K size.  That brings us to total pte frag size needed to map 16MB
to be 2K to track pte_t and 2K to track subpages = 4K.


Now what we are changing here is to update that to 8K. The 6K space in
the pte fragment (outside the 2K needed to track pte_t) is used to track
subpages here. The additional space enable us to use 8bits per subpage.

Total subpages in a 16MB range = 4096.
1 byte per subpage now. Hence we take 4K space for tracking subpages. 
Total space taken by pte_t and subpage tracking 2K + 4K = 6k. Inorder to
align it we increase that to 8K


-aneesh
