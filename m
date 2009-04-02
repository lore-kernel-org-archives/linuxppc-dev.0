Return-Path: <yigal_gold@yahoo.com>
Received: from web38901.mail.mud.yahoo.com (web38901.mail.mud.yahoo.com
	[209.191.125.107]) by ozlabs.org (Postfix) with SMTP id A06EDDDDA2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 07:12:39 +1100 (EST)
Message-ID: <52907.72158.qm@web38901.mail.mud.yahoo.com>
Date: Thu, 2 Apr 2009 13:05:58 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@yahoo.com>
Subject: early kernel debugging
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,
I'm using u-boot to boot kernel 2.6.24.2 on a powerpc based board .
I see that after uncompressing the kernel it hangs.
I found a location (System.map) I think corresponds to the __log_buf (my SDRAM starts at physical address 0 (and u-boot performs -> Load Address: 00000000 Entry Point: 00000000) .
So I just removed the leading C0xxxxxx from the address leaving xxxxxx .
And that's where I looked . 
I did see 2 error messages (though they were somewhat corrupt) the first designated a memory fault and the second a kernel oops at some address.
I looked this address up on System.map and it's somewhere inside prom.c
in of_scan_flat_dt( ) . 

I have a few question at this point :
A)Am I looking at the right memory location for __log_buf ?
B)What is printed to the buffer (printk's of what verbose level ?)
C)In a previous kernel version 2.6.14 I don't remember explicitly using a flat device tree or pointing at such a tree through the bootm command) , but I used the ARCH=ppc then as opposed to ARCH=powerpc Now .
I see a lot of stuff regarding the need to provide such a data structure upon booting via bootm .Do I need to explicitly prepare such a data structure and provide a pointer to it via bootm ?
Might this be the cause for this early hang ?

Best Regards,
Yigal Goldberger. 


      
