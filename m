Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14D662C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 22:23:44 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 2 Dec 2013 04:23:37 -0700
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3502719D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 04:23:28 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB29LUkl1769764
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 10:21:30 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB2BNXew019918
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 04:23:33 -0700
Message-ID: <529C6CF5.6010209@linux.vnet.ibm.com>
Date: Mon, 02 Dec 2013 16:50:21 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: 3.13 Oops on ppc64_cpu --smt=off
References: <9C236EE3-BB04-4BF9-ACE0-870A9E97EA0F@suse.de>
 <529C0614.6070708@linux.vnet.ibm.com>
 <6466B80A-5F19-4D1B-968F-AE19B28EF8DB@suse.de>
In-Reply-To: <6466B80A-5F19-4D1B-968F-AE19B28EF8DB@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 12/02/2013 03:27 PM, Alexander Graf wrote:
> 
> On 02.12.2013, at 05:01, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> 
>> Hi,
>>
>> On 11/30/2013 11:15 PM, Alexander Graf wrote:
>>> Hi Ben,
>>>
>>> With current linus master (3.13-rc2+) I'm facing an interesting issue with
>>
>> SMT disabling on p7. When I trigger the cpu offlining it works as expected,
>> but after a few seconds the machine goes into an oops as you can see below.
>>>
>>> It looks like a null pointer dereference.
>>
>> tip/sched/urgent has the below fix. Can you please apply the following it and
>> check if the issue gets resolved?  A similar issue was reported earlier as
> 
> I've disabled NO_HZ now on that machine which also "fixed" it for me. Unfortunately I can't reboot that box for at least the next week now to test whether the patch does fix the issue.

The commit 37dc6b50cee9 that has caused this regression is around NO_HZ.
It decides when to kick nohz idle balancing.

Regards
Preeti U Murthy
> 
> 
> Alex
> 
