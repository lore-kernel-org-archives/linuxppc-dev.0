Return-Path: <cody@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9B3FE2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 09:47:32 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 15:47:30 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C956F19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 15:47:25 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PMlROt7667974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:47:27 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PMorcL011638
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 15:50:54 -0700
Message-ID: <530D1D6F.1050603@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 14:47:11 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Olof Johansson <olof@lixom.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: Re: [PATCH] powerpc: warn users of smt-snooze-delay that the API
 isn't there anymore
References: <1393028074-26797-1-git-send-email-cody@linux.vnet.ibm.com>
 <530C21E6.5020106@linux.vnet.ibm.com>
In-Reply-To: <530C21E6.5020106@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 08:53 PM, Madhavan Srinivasan wrote:
> On Saturday 22 February 2014 05:44 AM, Cody P Schafer wrote:
>> /sys/devices/system/cpu/cpu*/smt-snooze-delay was converted into a NOP
>> in commit 3fa8cad82b94d0bed002571bd246f2299ffc876b, and now does
>> nothing. Add a pr_warn() to convince any users that they should stop
>> using it.
>>
>> The commit message from the removing commit notes that this
>> functionality should move into the cpuidle driver, essentially by
>
> Would prefer to cleanup the code since the functionality is moved,
> instead of adding to it.

We'd still want users of the interface to use an attribute wired up 
under the cpuidle/ dir, so a warning (to update their software) is still 
needed. As deepthi has noted, cpuidle right now doesn't support changing 
this on a per-cpu basis, so a "cleanup" isn't a simple matter.
