Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36D042C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 15:06:52 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 21:06:50 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D52B819D8036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 21:06:44 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q46KHT10223994
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 05:06:20 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q46k4v022533
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 21:06:46 -0700
Message-ID: <530D6855.6070009@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 20:06:45 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] powerpc/pseries: fix issues in suspend/resume code
References: <1392843415-17153-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1393206791.6771.157.camel@pasglop>
In-Reply-To: <1393206791.6771.157.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2014 05:53 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-02-19 at 12:56 -0800, Tyrel Datwyler wrote:
>> This patchset fixes a couple of issues encountered in the suspend/resume code
>> base. First when using the kernel device tree update code update-nodes is
>> unnecessarily called more than once. Second the cpu cache lists are not
>> updated after a suspend/resume which under certain conditions may cause a
>> panic. Finally, since the cache list fix utilzes in kernel device tree update
>> code a means for telling drmgr that updating the device tree from userspace
>> is unnecessary.
> 
> This series breaks the !SMP build.
> 
> Cheers,
> Ben.

The second patch in this series created the build breakage. I've replied
to that patch with a new version that fixes the break.

-Tyrel

> 
>> Changes from v3:
>> - Updated patch descriptions to better reflect the behavior/interface changes
>>   and why they are acceptable per Ben's concerns.
>>
>> Changes from v2:
>> - Moved dynamic configuration update code into pseries specific routine
>>   per Nathan's suggestion.
>>
>> Changes from v1:
>> - Fixed several commit message typos
>> - Fixed authorship of first two patches
>>
>> Haren Myneni (2):
>>   powerpc/pseries: Device tree should only be updated once after
>>     suspend/migrate
>>   powerpc/pseries: Update dynamic cache nodes for suspend/resume
>>     operation
>>
>> Tyrel Datwyler (1):
>>   powerpc/pseries: Report in kernel device tree update to drmgr
>>
>>  arch/powerpc/include/asm/rtas.h           |  1 +
>>  arch/powerpc/platforms/pseries/mobility.c | 26 +++++++-----------
>>  arch/powerpc/platforms/pseries/suspend.c  | 44 ++++++++++++++++++++++++++++++-
>>  3 files changed, 54 insertions(+), 17 deletions(-)
>>
> 
> 
