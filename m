Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 849E8DDDB2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 09:09:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n45N3fPC021187
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 17:03:41 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n45N9V5X203862
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 17:09:31 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n45N9VoJ009161
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 17:09:31 -0600
Date: Tue, 5 May 2009 19:08:24 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Setting Kernel Allocated Memory Uncached on the PPC460
Message-ID: <20090505230824.GD14017@zod.rchland.ibm.com>
References: <16691A8B34B5D9458EA3A1C37A11555A01351C87@tanisys-ex2.Tanisys.Local>
	<ed82fe3e0905051416u79e431bdy8544a437c79c1cd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0905051416u79e431bdy8544a437c79c1cd1@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Judd Gilbert <JuddG@tanisys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 05, 2009 at 04:16:45PM -0500, Timur Tabi wrote:
>On Mon, May 4, 2009 at 1:55 PM, Judd Gilbert <JuddG@tanisys.com> wrote:
>> I have a driver which maps some kernel allocated memory to user space which
>> works, and now I am trying to set that memory non-cacheable, on a power PC
>> using the Denx ELDK (linux-2.6.24) on a PPC460ex.
>
>Because of the way the kernel maps main memory, you cannot do this.
>It is a violation of the PowerPC architecture to map a particular
>memory address as both cached and uncached (using different TLB
>entries) at the same time.  When the kernel boots, it uses large
>mappings to map all of memory as cached.  There is no mechanism to
>punch holes in these mappings.  Therefore, if the memory is already
>mapped cached by the kernel, you cannot remap it as uncached.
>
>The only way around this is to use high memory, which is not mapped by
>the kernel normally.  You can "bring in" a high memory page and map it
>uncached.  However, I don't think there is a way for you to manually
>specify certain memory to be high.

That isn't entirely true.  You can always limit the memory mapped via the
kernel with mem= (or via a memreserve), and then have a driver ioremap the
now unused memory.

josh
