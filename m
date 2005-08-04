Return-Path: <wd@denx.de>
To: "Debora Liu" <deboralh@fel.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Aug 2005 17:29:09 +0800."
	<20050804092525.15A4A67EBC@ozlabs.org>
Date: Thu, 04 Aug 2005 12:18:41 +0200
Sender: wd@denx.de
Message-Id: <20050804101841.6E06B352B36@atlas.denx.de>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245 reboot 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050804092525.15A4A67EBC@ozlabs.org> you wrote:
> 
> If do reboot board by jump address of uboot start address?

Bad idea. That address may not be mapped at all, or not at the  right
physical  address.  Also,  just  jumping to a boot loader entry point
does not cause a hardware reset, so any devices that might  be  stuck
will remain stuck.

You should always try to  cause  a  real  reset;  there  are  several
methods  in  use  for  this,  like  using a watchdog reset, causing a
machine check, etc. Just see existing code.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
All these theories, diverse as they are, have two things  in  common:
they explain the observed facts, and they are completeley and utterly
wrong.                       - Terry Pratchett, _The Light Fantastic_
