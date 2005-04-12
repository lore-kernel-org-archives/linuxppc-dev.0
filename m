Return-Path: <frannk_m1@yahoo.com>
Received: from web32204.mail.mud.yahoo.com (web32204.mail.mud.yahoo.com
	[68.142.207.135]) by ozlabs.org (Postfix) with SMTP id AB12967AC7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 05:14:59 +1000 (EST)
Message-ID: <20050412190817.746.qmail@web32204.mail.mud.yahoo.com>
Date: Tue, 12 Apr 2005 12:08:16 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
> I've been trying to get a WRS 8265 to do a warm reboot, and
> found some
> things that I am wondering about.
> 
> Firstly, is anyone having success on having "reboot" restart
> the machine
> on a similar platform?
> 
> Secondly, the default BOOTROM_RESTART_ADDR is 0x40000104
> (sbc82xx.h) and I
> was wondering if this matches any platforms out there.  On
> this board, the
> place where U-Boot lives is 0xFFF00104 -- and I've verified
> this by typing
> "g fff00104" at the U-Boot prompt which causes U-Boot to
> simply restart.
> 
> I've changed the value in sbc82xx.h and now at the reboot,
> instead of a
> register dump, it simply hangs.  Looking at m8260_gorom (in
> kernel/head.S)
> it clears the MSR_EE (ext int. enable) bit in the MSR before
> jumping --
> but I was wondering if there are other bits in MSR that need
> to be
> cleared; e.g. instruction relocation enable and data
> relocation enable
> (MSR_IR and MSR_DR). The register bits are on p76 of
> MPCFPE32B.pdf from
> Freescale.
> 
> I guess if somebody even said "it works for me" then I'd have
> a better
> feeling thinking that what is done to the MSR currently is
> sufficient.
> 
> Paul.
> 
I'm working on the exact same problem with u-boot (trying to do
warm reboot from the VxWorks shell). I modified romInit.S to
pass control to u-boot (at 0xfe000000) and that works just fine.
But after I boot VxWorks from u-boot (go 0xfff00100) and invoke
reboot from the VxWorks shell, it just hangs. If I boot VxWorks
without invoking u-boot first, it works fine. If you find the
problem befor me, let me know and I'll do tha same...

> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Yahoo! Small Business - Try our new resources site!
> http://smallbusiness.yahoo.com/resources/
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/
