Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 8F5922BF11
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 10:35:14 +1100 (EST)
Message-ID: <41D9D6A2.2010705@nortelnetworks.com>
Date: Mon, 03 Jan 2005 17:34:58 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
References: <41D9CD19.50207@nortelnetworks.com>
	<20050103225822.GC7335@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20050103225822.GC7335@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: dcbz not used on ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard wrote:

>>1) Is it in fact true that ppc64 does not use dcbz in the kernel?
>>2) If so, why not?  Presumably it would be a win in some cases, 
>>otherwise they wouldn't be using it in ppc32.  Is there some other 
>>factore in play for ppc64?
> 
> 
> include/asm-ppc64/page.h:clear_page() uses it:

Hmm.  As of 2.6.9 at least, clear_page() is only ever called by 
clear_user_page(), which in turn is only ever called by 
drivers/media/video/video-buf.c.  I'm not using that driver, which 
explains why the instruction didn't show up when I disassembled the kernel.

Still, ppc32 also uses it in cacheable_memzero and __copy_tofrom_user. 
It's also used in cacheable_memcpy, but that routine doesn't seem to be 
used anywhere.

Chris
