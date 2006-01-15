Return-Path: <dhlii@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.152])
	by ozlabs.org (Postfix) with ESMTP id 2628C689FE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Jan 2006 20:14:01 +1100 (EST)
Message-ID: <43CA1242.6030101@comcast.net>
Date: Sun, 15 Jan 2006 04:13:38 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: srideep.devireddy@wipro.com
Subject: Re: Problems starting /sbin/init
References: <20051208231947.92EB9353F77@atlas.denx.de>
	<43BB73A2.4040708@comcast.net>
	<6AD9F6A5F6E096408F0B703773355A070E705B@CHN-SNR-MBX01.wipro.com>
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A070E705B@CHN-SNR-MBX01.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

srideep.devireddy@wipro.com wrote:
> Hello David ,
> 
>   I am bringing up  Montavista Linux on mpc8272 custom board .But as we completed almost all the configurations and linux is booting well till the NFS or Ramdisk file system is mounted . then it hangs  .. when i tried to debug i saw the /sbin/init in the init/main.c is not getting executed . i had printk and checked all the printks are executed but not the /sbin/init and the printks after the init is also executed .so this /sbin/init is not getting excecuting and i am not getting any messages .
> 
> Thanks & Regards
> Srideep Reddy D
> Wipro Technologies
> 
> 
Srideep;

	I was eventually able to resolve my problem. My serial console driver
was inadvertently using the physical address of the uart and not the
virtual address. When the TLB entry created in head_4xx.S for that
physical address eventually got overwritten - which coincidentally
occured after loading /init (or /bin/sh or ....) but prior to their
outputting anything.

	It is possible but unlikely you are having a similar problem.

	Regardless, you can isolate your problem further. You can sprinkle
prink's inside init/main.c to figure out exactly how far you are getting.
	If you are actually getting to attempting to start /init, you can
change main.c to start the program of your choice instead of init.
I started with "Hello World" in ppc assmebler with no library dependencies.
	You can enable SHOW_SYSCALLS and find out what system calls are
occuring immeditely prior to your system running off the rails.

	And I am sure others may have even more and better ideas.


Dave
