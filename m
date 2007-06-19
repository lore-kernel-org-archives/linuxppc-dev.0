Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8FA77DDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 10:01:48 +1000 (EST)
Message-ID: <46771CE7.8040901@am.sony.com>
Date: Mon, 18 Jun 2007 17:01:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
References: <46730D8A.9090309@am.sony.com>
	<951969d2021fe6e78917ef8bdb47cf6f@bga.com>
	<20070618225537.GA19966@mag.az.mvista.com>
In-Reply-To: <20070618225537.GA19966@mag.az.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
>> Not bad.   Since this code doesn't have to be at any particular 
>> location when it is built (you have no .org or similar, its all PIC), I 
>> don't see anything that couldn't be done from an asm block in the 
>> platform .c file, like the entry point in prpmc2800.c file; that would 
>> save a file in the boot directory.  In that case __system_reset_kernel 
>> would be an array of 256 bytes.
> 
> Agree.
> 
> As for the rest of Geoff's patch, I think I get the gist of what's going
> on but it would be really nice to have it described in English (and put
> in the patch description).  That way others (like me) could understand
> the problem you're solving and what your solution is.

This is from the comment the patch adds to the wrapper script.  I think
it gives you what you need:

+ps3)
+    # The ps3's loader supports loading gzipped binary images from flash
+    # rom to addr zero. The loader enters the image at addr 0x100.  A
+    # bootwrapper overlay is use to arrange for the kernel to be loaded
+    # to addr zero and to have a suitable bootwrapper entry at 0x100.
+    # To construct the rom image, 0x100 bytes from offset 0x100 in the
+    # kernel is copied to the bootwrapper symbol __system_reset_kernel.
+    # The 0x100 bytes at the bootwrapper symbol __system_reset_overlay is
+    # then copied to offset 0x100.  At runtime the bootwrapper program
+    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.
