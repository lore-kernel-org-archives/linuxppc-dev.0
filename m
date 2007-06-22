Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 490BADDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 05:07:31 +1000 (EST)
Message-ID: <467C1E58.6070702@ru.mvista.com>
Date: Fri, 22 Jun 2007 23:09:12 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch] powerpc: sysfs fix compiler warning
References: <20070622194853.72fb652a@localhost>	
	<1182537519.1554.14.camel@weaponx.rchland.ibm.com>	
	<467C1BB5.2040600@ru.mvista.com>
	<1182539095.1554.18.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1182539095.1554.18.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Christian Krafft <krafft@de.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 2007-06-22 at 22:57 +0400, Sergei Shtylyov wrote:
> 
>>Hello.
>>
>>Josh Boyer wrote:
>>
>>
>>>>From: Christian Krafft <krafft@de.ibm.com>
>>
>>>>This patch fixes the following compiler warning:
>>>>arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
>>>>`sysfs_create_group',
>>
>>>>Signed-off-by: Christian Krafft <krafft@de.ibm.com>
>>
>>>>Index: linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
>>>>===================================================================
>>>>--- linux-2.6.22-rc5.orig/arch/powerpc/kernel/sysfs.c
>>>>+++ linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
>>>>@@ -380,16 +380,23 @@ int cpu_add_sysdev_attr_group(struct att
>>>>{
>>>>	int cpu;
>>>>	struct sys_device *sysdev;
>>>>+	int error;
>>>>
>>>>	mutex_lock(&cpu_mutex);
>>>>
>>>>	for_each_possible_cpu(cpu) {
>>>>		sysdev = get_cpu_sysdev(cpu);
>>>>-		sysfs_create_group(&sysdev->kobj, attrs);
>>>>+		error |= sysfs_create_group(&sysdev->kobj, attrs);

>>>Why are you or'ing the return value with whatever is in the
>>>uninitialized variable?

>>    To make it always fail, no doubt. ;-)
>>    ISO accumulation error, it makes more sense to start cleanup created 
>>groups right after the first creation failure -- although with the callers opf 
>>this function ignoring the result anyway, who cares. :-)

> I care because he does an if (error) below that.  Since error isn't
> initialized, it could be some random value and or'ing a 0 return code
> from sysfs_create_group would still trigger the error path.

> Plus, it's bogus anyway and should be fixed.

    You misunderstood: I didn't at all object to fixing the bogosity you've 
pointed out, just mused about how/if the error cleanup should be done.

> josh

WBR, Sergei
