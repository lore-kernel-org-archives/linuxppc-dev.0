Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id BA450DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 07:16:49 +1000 (EST)
Received: by qyk29 with SMTP id 29so11579051qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 May 2009 14:16:45 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A01351C87@tanisys-ex2.Tanisys.Local>
References: <AcnM6e3UsebkDqu/R72I7X8j7/gKCQ==>
	<16691A8B34B5D9458EA3A1C37A11555A01351C87@tanisys-ex2.Tanisys.Local>
Date: Tue, 5 May 2009 16:16:45 -0500
Message-ID: <ed82fe3e0905051416u79e431bdy8544a437c79c1cd1@mail.gmail.com>
Subject: Re: Setting Kernel Allocated Memory Uncached on the PPC460
From: Timur Tabi <timur@freescale.com>
To: Judd Gilbert <JuddG@tanisys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 4, 2009 at 1:55 PM, Judd Gilbert <JuddG@tanisys.com> wrote:
> I have a driver which maps some kernel allocated memory to user space which
> works, and now I am trying to set that memory non-cacheable, on a power PC
> using the Denx ELDK (linux-2.6.24) on a PPC460ex.

Because of the way the kernel maps main memory, you cannot do this.
It is a violation of the PowerPC architecture to map a particular
memory address as both cached and uncached (using different TLB
entries) at the same time.  When the kernel boots, it uses large
mappings to map all of memory as cached.  There is no mechanism to
punch holes in these mappings.  Therefore, if the memory is already
mapped cached by the kernel, you cannot remap it as uncached.

The only way around this is to use high memory, which is not mapped by
the kernel normally.  You can "bring in" a high memory page and map it
uncached.  However, I don't think there is a way for you to manually
specify certain memory to be high.

-- 
Timur Tabi
Linux kernel developer at Freescale
