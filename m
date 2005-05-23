Return-Path: <mlei30@yahoo.com>
Received: from web61022.mail.yahoo.com (web61022.mail.yahoo.com
	[209.73.179.16]) by ozlabs.org (Postfix) with SMTP id 2C7CA679F6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 07:02:40 +1000 (EST)
Message-ID: <20050523205558.28957.qmail@web61022.mail.yahoo.com>
Date: Mon, 23 May 2005 13:55:58 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mmporter@home.com
Subject: MMUCR on ppc440 GP/GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have problem on running system with linuxppc
2.4.19(ppc440GP/GX) regarding MMU Control
Register(MMUCR).

I checked the code in arch/ppc/ there is no code
setting or unsetting bit 12(DULXE) or bit 13(IULXE),
but somehow these two bits got changed during boot
process.

Question 1:
Does CPU or other hardware change these two bits? If
linux code doesnt set these two bits initiallt, what's
the default value?  Or I miss something in the code
that may change these two bits?

Question 2:
For current 2.4.19 PPC440 implementation, there is no
special handling for this kind of DataStorage
exception, is it possible for the user code to stuck
in this exception forever if these two bits got set in
MMUCR and the user code calls icbi instruction?

I did a simple test on head_440.S so whenever the
DataStorage exception happens, in DataStorage assmbly
code, I clear these two bits in MMUCR, but somehow
these two bits got set mysteriourly in next exception
with error_code 0x200000(got from ESR DLK bits).
What's happening here?

Thanks for any points and suggestions,
Ming



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new Resources site
http://smallbusiness.yahoo.com/resources/
